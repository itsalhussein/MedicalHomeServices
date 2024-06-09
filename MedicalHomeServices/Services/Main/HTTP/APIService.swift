//
//  APIClient.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation
import Alamofire
import Swime

class APIService {
    static let shared: APIService = APIService()
    private init() { }
}

extension APIService: ServiceProtocol {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        //configuration.timeoutIntervalForRequest = 30
        let logger = NetworkLogger()
        //let interceptor = RequestInterceptor()
        let session = Session(
            configuration: configuration,
            // interceptor: interceptor,
            eventMonitors: [logger]
        )
        return session
    }()
    
    /// Download to .cachesDirectory
    @discardableResult
    func download(
        route: APIRouter,
        fileName: String,
        progress: @escaping (Progress) -> Void,
        completion: @escaping (Result<URL, Error>) -> Void
    ) -> Request? {
        
        let directoryURLs = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let directoryURL = directoryURLs[0]
            .appendingPathComponent(route.urlRequest?.url?.lastPathComponent ?? "general")

        let url = directoryURL.appendingPathComponent(fileName)
        
        // Try to load from cash
        if FileManager.default.fileExists(atPath: url.path(percentEncoded: false)) {
            completion(.success(url))
            return nil
        }

        // Load from Server
        let destination: DownloadRequest.Destination = { _, _ in
            return (url, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let request = APIService.session.download(
            route,
            interceptor: RequestInterceptor(),
            to: destination
        )
        
        request
        .validate(statusCode: [200])
        .downloadProgress { aProgress in
            #if DEBUG
            print("\(aProgress.completedUnitCount) of \(aProgress.totalUnitCount): \(aProgress.fractionCompleted)%")
            #endif
            progress(aProgress)
        }
        .response { response in
            if let error = response.error {
                #if DEBUG
                print(error)
                #endif
                let networkError = response.resumeData.flatMap {
                    try? newJSONDecoder().decode(NetworkError.self, from: $0)
                }
                let apiError = APIError.afError(
                    error,
                    message: networkError?.Errors //networkError?.errorsConcatenated ?? networkError?.message
                )
                try? FileManager.default.removeItem(at: url)

                completion(.failure(apiError))
                
            } else if let fileURL = response.fileURL {
                #if DEBUG
                print(fileURL.absoluteString)
                #endif
                completion(.success(fileURL))
            }
        }
        
        return request
    }

    // MARK: - Async-Await
    func fetch<ModelType: Decodable>(route: APIRouter) async throws -> ModelType? {
        let response = await APIService.session
            .request(route, interceptor: RequestInterceptor())
            .serializingDecodable(ModelType?.self, decoder: newJSONDecoder())
            .response
        
        return try handleResponse(response: response)
    }
    
//    func upload<ModelType: Decodable>(route: APIRouter) async throws -> ModelType? {
//        let response = await getUploadRequest(for: route)
//            .serializingDecodable(ResponseWrapper<ModelType>?.self, decoder: newJSONDecoder())
//            .response
//        
//        return try handleResponse(response: response)
//    }
    
    
    // MARK: - Private
    
    private func getUploadRequest(for route: APIRouter) -> UploadRequest {
        APIService.session.upload(
            multipartFormData: { multipartFormData in
                route.multiPartData?.forEach { object in
                    guard let data = object.data else { return }
                    var fileName = object.fileName
                    let mime = Swime.mimeType(data: data)

                    if fileName.isNilOrEmpty {
                        fileName = [
                            String(Date.timeIntervalSinceReferenceDate),
                            mime?.ext
                        ]
                            .compactMap { $0 }
                            .joined(separator: ".")
                    }
                    let mimeType = object.mimeType ?? mime?.mime ?? "application/octet-stream"

                    multipartFormData.append(
                        data,
                        withName: object.name,
                        fileName: fileName,
                        mimeType: mimeType
                    )
                }
                
                
                route.multiPartParameters?.forEach { item in
                    guard let data = item.value?.data(using: .utf8) else { return }

                    multipartFormData.append(data, withName: item.name)
                }
                
            },
            with: route,
            interceptor: RequestInterceptor()
        )
    }
    
    private func handleResponse<ModelType: Decodable>(response: DataResponse<ModelType?, AFError>) throws -> ModelType? {
            switch response.result {
            case .success(let dataWrapper):
//                if let cacheSession = dataWrapper?.cacheSession,
//                   cacheSession != AppSettings.shared.cacheSession{
//                    AppSettings.shared.loadSettings(with: cacheSession)
//                }
                if let dataWrapper = dataWrapper {
                    return dataWrapper
                }
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
                let networkError = response.data.flatMap {
                    try? newJSONDecoder().decode(NetworkError.self, from: $0)
                }
                let apiError = APIError.afError(
                    error,
                    message: networkError?.Errors
                )
                throw apiError
            }
            return nil
        }
}



/*
 APIError
 */

enum APIError: Error {
    // case loginFailed
    // case serverNameInvalid
    // case generalError
    case tokenExpired
    case validationError(String?)
    case exceptionError(String?)
    case custom(String?)
    case afError(AFError, message: String?)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
            // case .loginFailed:
            //     return NSLocalizedString("Username or password is not correct", comment: "")
            // case .serverNameInvalid:
            //     return NSLocalizedString("The Server name is not valid", comment: "")
            // case .generalError:
            //     return NSLocalizedString("General Error", comment: "")
        case .tokenExpired:
//            if AppSettings.shared.isLoggedIn {
//                AppSettings.shared.resetUserSettings()
//                AppSettings.shared.currentUser = nil
//                DispatchQueue.main.async {
//                    AppSettings.shared.appStatus = .notLoggedIn
//                    AppSettings.shared.rootViewId = UUID()
//                }
//            }
            return NSLocalizedString("The user has been involuntarily logged out of the system.\nIf the user wishes to continue, it will be necessary to login again.", comment: "")
        case .validationError(let string):
            return string
        case .exceptionError(let string):
            return string
        case .custom(let string):
            return string
        case .afError(let error, let message):
            return message ?? error.baseUnderlyingError.localizedDescription
        }
    }
}

extension AFError {
    var baseUnderlyingError: Error {
        var error: Error = self
        while let underlyingError = error.asAFError?.underlyingError {
            error = underlyingError
        }
        return error
    }
}


