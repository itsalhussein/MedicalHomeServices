import Foundation

enum APIResponse<T: Decodable>: Decodable {
    case success(ResponseWrapper<T>)
    case error(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            // Attempt to decode as success response
            let successResponse = try container.decode(ResponseWrapper<T>.self)
            self = .success(successResponse)
        } catch DecodingError.typeMismatch {
            // If decoding as success response fails, decode as error response
            let errorMessage = try container.decode(String.self)
            self = .error(errorMessage)
        }
    }
}

struct ResponseWrapper<T: Decodable>: Decodable {
    let endpoint: String?
    let status: Int?
    let code: Int?
    let locale: String? // en, ar
    let message: String?
    let errors: String?
    let data: T?
    let cacheSession:String?
    
    var isSuccess: Bool {
        status == 200
    }
    enum CodingKeys: String, CodingKey {
        case status, code, locale, message, endpoint, cacheSession, data,errors
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        code = try container.decodeIfPresent(Int.self, forKey: .code)
        locale = try container.decodeIfPresent(String.self, forKey: .locale)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        endpoint = try container.decodeIfPresent(String.self, forKey: .endpoint)
        cacheSession = try container.decodeIfPresent(String.self, forKey: .cacheSession)
        errors = try container.decodeIfPresent(String.self, forKey: .errors)

        do {
            // Attempt to decode 'data' as the generic type T
            data = try container.decode(T.self, forKey: .data)
            print(#line,"=============\n\n",data)
        } catch DecodingError.typeMismatch {
            if let rawString = try? container.decode(String.self, forKey: .data) {
                // The entire response is a string, handle it accordingly
                print("Entire response is a string: \(rawString)")
                data = rawString as? T
            } else if let rawBool = try? container.decode(Bool.self, forKey: .data) {
                // Handle unexpected boolean value for 'data' field
                print("Unexpected boolean value for data field: \(rawBool)")
                data = rawBool as? T // or set a default value as needed
            } else {
                // Handle other cases where the expected type cannot be decoded
                data = nil
            }
        } catch {
            // Handle other decoding errors
            data = nil
        }
    }
}

 
struct NetworkError: Decodable {
    let Status: Int?
    let Code : Int?
    let Errors: String?
    let Data: String?
    let error: String?
}

