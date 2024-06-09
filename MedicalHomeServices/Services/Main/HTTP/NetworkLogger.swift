//
//  NetworkLogger.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {

    let queue = DispatchQueue(label: "com.masterteam.ekhtesrha.networklogger")

    func requestDidFinish(_ request: Request) {
    #if DEBUG
        // Logging
        print(request.description)
        print(request.error ?? "--")
        request.cURLDescription(on: .global(qos: .utility)) { cURL in
            print(cURL)
        }
    #endif
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        #if DEBUG
        DispatchQueue.global(qos: .utility).async {
            guard let data = response.data else {
                return
            }
            
            // DispatchQueue.global().async {
            //     APILoggerManager.shared.responses.insert(response, at: 0)
            // }
            if let json = try? JSONSerialization
                .jsonObject(with: data, options: .mutableContainers) {
                print(json)
            }
        }
        #endif
    }
}
