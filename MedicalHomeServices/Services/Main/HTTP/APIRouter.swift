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
    case AddUserToProviderRequest([AddUserToProviderRequestModel])
    case ServiceRequest(ServiceRequestModel)
    case RequestNominatedProviders(Int)
    case ProviderNominatedRequests(Int)
    
    case GetUserServices(Int)
    
    case AddTempProviderToRequest
    case ActionByProviderToRequest
    case GetRequestStatus
    case UpdateRequestStatus

    //MARK: - Updates

    public var method: HTTPMethod {
        switch self {
        case .Register,.Login,.AddUserToProviderRequest,.ServiceRequest,.ActionByProviderToRequest,.AddTempProviderToRequest,.UpdateRequestStatus:
            return .post
        case .MedicalServices,.RequestNominatedProviders,.ProviderNominatedRequests,.GetUserServices,.GetRequestStatus:
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
        case .AddUserToProviderRequest:
            return "/ServiceProvider/AddUserToProviderRequests"
        case .ServiceRequest:
            return "/ServiceRequest"
        case .RequestNominatedProviders:
            return "/ServiceRequest/GetRequestNominatedProviders"
        case .ProviderNominatedRequests:
            return "/ServiceRequest/GetProviderNominatedRequests"
        case .GetUserServices:
            return "/ServiceProvider/GetUserToProviderRequests"
        case .AddTempProviderToRequest:
            return "/ServiceRequest/AddTempProviderToRequest"
        case .ActionByProviderToRequest:
            return "/ServiceRequest/ReactionByTempProviderToRequest"
        case .GetRequestStatus:
            return "/ServiceRequest/NotifyUserOfRequestStatus"
        case .UpdateRequestStatus:
            return "/ServiceRequest/UpdateRequestStatus"
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
    
    private var parameters: Data? {
        switch self {
        
        case .Register(let signUpModel):
            return try? newJSONEncoder().encode(signUpModel)
        case .Login(let signInModel):
            return try? newJSONEncoder().encode(signInModel)
        case .AddUserToProviderRequest(let model):
            return try? newJSONEncoder().encode(model)
        case .ServiceRequest(let model):
            return try? newJSONEncoder().encode(model)

        default:
            break
        }
        return nil
    }
    
    private var urlParameters: [URLQueryItem]? {
        switch self {

//            // MARK: Task Center
        case .RequestNominatedProviders(let requestId):
            return [URLQueryItem(name: "requestID", value: "\(requestId)")]
        case .ProviderNominatedRequests(let providerId):
            return [URLQueryItem(name: "providerID", value: "\(providerId)")]
        case .GetUserServices(let userId):
            return [URLQueryItem(name: "userID", value: "\(userId)")]
    
        default:
            break
        }
        return nil
    }
    
    private var acceptContentType: String? {
        switch self {
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
