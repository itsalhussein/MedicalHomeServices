import Foundation
import Alamofire
// import FirebaseAuth

/**
 * Use NSLock  from this URL
 * https://stackoverflow.com/questions/56963748/alamofire-auto-refresh-token-and-retry-previous-api-call-in-ios-swift-4/56965479#56965479
 */
final class RequestInterceptor: Alamofire.RequestInterceptor {

     let retryLimit = 3
     let retryDelay: TimeInterval = 3

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // guard urlRequest.url?.absoluteString.hasPrefix(K.server.url) == true else {
        //     return completion(.success(urlRequest))
        // }
        // var urlRequest = urlRequest
        // urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        // urlRequest.addValue(APIConstants.Server.authorizationHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        // /// Set the Authorization header value using the access token.
        // if let token = Settings.shared.accessToken {
        //     urlRequest.addValue(token, forHTTPHeaderField: HTTPHeaderField.token.rawValue)
        // }
        #if DEBUG
        print("Start Time \(Date())")
        #endif
        
        completion(.success(urlRequest))
    }

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        
        let response = request.task?.response as? HTTPURLResponse
        
//        if let statusCode = response?.statusCode,
//           (500...599).contains(statusCode),
//           request.retryCount < retryLimit {
//            completion(.retryWithDelay(retryDelay))
//        }
        
        
        
        // Token Expired
        if response?.statusCode == 401{
//           AppSettings.shared.isLoggedIn,
//           (request.request?.url?.absoluteString.contains("refresh-token")).isFalseOrNil {
//            
//            // RequestInterceptor.refreshToken(completion)
//            AppSettings.shared.resetUserSettings()
//            AppSettings.shared.currentUser = nil
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                AppSettings.shared.setNextMainScreen()
//            }
            
            return
        }
        return completion(.doNotRetryWithError(error))

    }
    
    
    // private static var isRefreshingToken = false
    // private static var completionList = [(RetryResult) -> Void]()
    // 
    // private static func refreshToken(_ completion: @escaping (RetryResult) -> Void) {
    //     completionList.append(completion)
    //     
    //     if isRefreshingToken { return }
    //     
    //     self.isRefreshingToken = true
    //     
    //     
    //     func refreshSuccessActions(_ accessToken: AccessToken) {
    //         Settings.shared.accessToken = accessToken.token
    //         Settings.shared.refreshToken = accessToken.refreshToken
    //         
    //         self.completionList.forEach {
    //             $0(.retry)
    //         }
    //     }
    // 
    //     func refreshFailureActions(_ error: Error) {
    //         self.completionList.forEach {
    //             $0(.doNotRetryWithError(error))
    //         }
    //         Settings.shared.resetUserSettings()
    //         WindowManager.shared.show(.login, animated: true, withReset: true)
    //         WindowManager.Window.login.controller.showHUD(
    //             style: .warning,
    //             details: error.localizedDescription,
    //             hideAfter: 2.0
    //         )
    //     }
    //     
    //     //let request =
    //     APIService.session
    //         .request(APIRouter.refreshToken, interceptor: nil)
    //         .responseDecodable(of: Response<AccessToken>.self, decoder: newJSONDecoder()) { response in
    //             
    //             self.isRefreshingToken = false
    //             
    //             switch response.result {
    //             case .success(let dataWrapper):
    //                 if dataWrapper.status {
    //                     refreshSuccessActions(dataWrapper.data)
    //                 } else {
    //                     refreshFailureActions(APIError.custom(dataWrapper.message))
    //                 }
    //             case .failure(let error):
    //                 #if DEBUG
    //                 print(error)
    //                 #endif
    //                 let networkError = response.data.flatMap {
    //                     try? newJSONDecoder().decode(NetworkError.self, from: $0)
    //                 }
    //                 let apiError = APIError.afError(
    //                     error,
    //                     message: networkError?.errorsConcatenated ?? networkError?.message
    //                 )
    //                 refreshFailureActions(apiError)
    //             }
    //             
    //             self.completionList.removeAll()
    //             
    //         }
    //     
    // }

}
