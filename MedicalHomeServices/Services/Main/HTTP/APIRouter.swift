//
//  APIRouter.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    // MARK: - Authenticate
    case Register(SignUpRequest)
    case Login(SignInRequest)
    case MedicalServices

    //MARK: - Updates

    public var method: HTTPMethod {
        switch self {
        case .Register:
            return .post
        case .Login:
            return .post
        case .MedicalServices:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .Register:
            return "/Auth/register"
        case .Login:
            return "/Auth/login"
        case .MedicalServices:
            return "/MedicalService"
        }
    }
    
    private var isRequiredToken: Bool{
        switch self {
 
        case .Register,.Login:
            return false
        default:
            return true
        }
    }
    
    struct MultiPartData {
        let data: Data?
        let name: String
        let fileName: String?
        let mimeType: String?
    }
    
    var multiPartData: [MultiPartData]? {
        switch self {
//         case .upload(let file):
//            var multipartData : [MultiPartData] = []
//            switch file.value {
//            case .document(let  url):
//                let data = try? Data(contentsOf: url)
//                multipartData.append(
//                    MultiPartData(
//                        data: data,
//                        name: "Attachment",
//                        fileName: url.lastPathComponent,
//                        mimeType: url.mimeType
//                    )
//                )
//            case .image(let image):
//                if let imageData  = image.data() {
//                    multipartData.append(
//                        MultiPartData(
//                            data: imageData,
//                            name: "Attachment",
//                            fileName: "\(UUID().uuidString).jpeg",
//                            mimeType: nil
//                        )
//                    )
//                }
//            }
//            return multipartData
            
            
//            [
//                MultiPartData(
//                    data: data,
//                    name: "Attachment",
//                    fileName: imageURL.lastPathComponent,
//                    mimeType: imageURL.mimeType
//                )
//            ]
//
//        case .upload(let file):
//            let data = try? Data(contentsOf: file)
//            return [
//                MultiPartData(
//                    data: data,
//                    name: "file",
//                    fileName: file.lastPathComponent,
//                    mimeType: file.mimeType
//                )
//            ]
            
        default:
            return nil
        }
    }
    
    
    var multiPartParameters: [URLQueryItem]? {
        switch self {
        // case .completeProfile(let request, _):
        //     return try? newURLQueryItemEncoder().encode(request)
        //
        default:
            break
        }
        return nil
    }
    
    
    private var parameters: Data? {
        switch self {
        
        case .Register(let signUpModel):
            return try? newJSONEncoder().encode(signUpModel)
        case .Login(let signInModel):
            return try? newJSONEncoder().encode(signInModel)


        default:
            break
        }
        return nil
    }
    
    private var urlParameters: [URLQueryItem]? {
        switch self {

//            // MARK: Task Center
//        case .customModule(let moduleId):
//            return [URLQueryItem(name: "moduleId", value: moduleId.planeString)]
//        case .customModuleDetails(let moduleId, _):
//            return [URLQueryItem(name: "moduleId", value: moduleId.planeString)]
//
//            // MARK: Workflow Data (My Space)
//        case .registry(let filter):
//            return [URLQueryItem(name: "Filters", value: filter)]
//        case .getSectionForEdit:
//            return [URLQueryItem(name: "mode", value: "edit")]
//        case .getActionItemForEdit:
//            return [URLQueryItem(name: "mode", value: "edit")]
////
//        case .workflowAction(let action):
//            return URLComponents(string: action.url)?.queryItems
//            
        
//
//        case .modulePrivileges(let moduleId, let instanceId):
//            return [
//                URLQueryItem(name: "moduleId", value: moduleId.planeString),
//                URLQueryItem(name: "instanceId", value: instanceId.planeString)
//            ]

        default:
            break
        }
        return nil
    }
    
    private var acceptContentType: String? {
        switch self {
//        case .download(let attachment):
//            return attachment.body.contentType
        case .MedicalServices:
            return "text/plain"
        default:
            return "*/*"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        /// URL
        let baseUrl = K.server.url
        let url = try baseUrl.asURL()
        
        var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        
        if let urlParameters = urlParameters {
            urlComponents?.queryItems = urlParameters
        }
        
        var urlRequest = URLRequest(url: urlComponents!.url!)
        
        /// Headers
        urlRequest.setValue(acceptContentType ?? "application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue(AppSettings.shared.currentLang.rawValue, forHTTPHeaderField: "Accept-Language")
        // urlRequest.setValue(K.server.apiKey, forHTTPHeaderField: "API_KEY")
        // if APIRouter.refreshToken.path == path, let refreshToken = Settings.shared.refreshToken {
        //     urlRequest.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        // } else
        
        if isRequiredToken,
           let token = AppSettings.shared.accessToken {
             urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
                
        /// Method
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            urlRequest.httpBody = parameters
        }
        
        return urlRequest
    }
    
}
