//
//  EncodeDecode+Helpers.swift
//  Snack
//
//  Created by Khaled Khaldi on 15/03/2022.
//

import Foundation
//import URLQueryItemEncoder

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    // encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    return decoder
}

extension DateFormatter {
    static let json_T_DateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // "2023-03-28T17:04:24"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()

    static let json_T_DateTimeFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // "2023-03-07T11:56:50.8877295"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
    
    static let json_T_DateTimeFormatter3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // "2023-05-04T11:53:13.5700758+03:00"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
    
    

    static let json_AM_PM_DateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a" // "2023-03-28 11:32 AM"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
}


//func newURLQueryItemEncoder() -> URLQueryItemEncoder {
//    let encoder = URLQueryItemEncoder()
//    //encoder.keyEncodingStrategy = .convertToSnakeCase
//    return encoder
//}

extension Array where Element == URLQueryItem {
    var dictionaryStrings: [String: String?]? {
        Dictionary(uniqueKeysWithValues: self.map { ($0.name, $0.value) })
    }
}

extension Encodable {
    var dictionary: [String: Any?]? {
        guard let data = try? newJSONEncoder().encode(self) else { return nil }
        let fragmented = try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        )
        return fragmented as? [String: Any?]
    }
}

// extension Encodable {
//     var urlFormData: Data? {
//         dictionary?
//             .compactMap {key, value in "\(key)=\(value ?? "")" }
//             .joined(separator:"&")
//             .data(using: .utf8)
//     }
// }

protocol CaseIterableDefaultsValue: Decodable & RawRepresentable
where Self.RawValue: Decodable {
    static var defaultValue: Self { get }
}

extension CaseIterableDefaultsValue {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.defaultValue
    }
}



extension Bool {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let boolVal = try? container.decode(Bool.self) {
            self = boolVal
            
        } else if let intVal = try? container.decode(Int.self) {
            self = (intVal == 1)
            
        } else if let string = try? container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines) {
            self = ["true", "yes", "1"].contains(string.lowercased())

        } else {
            self = false
        }
    }

}

extension KeyedDecodingContainer {
    public func decodeIfPresent(_ type: String.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> String? {
        do {
            return try decode(String.self, forKey: key)

        } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
            return nil
            
        } catch DecodingError.typeMismatch {
            return try String(decode(Int.self, forKey: key))

        } catch { //DecodingError.typeMismatch, DecodingError.keyNotFound ,DecodingError.valueNotFound{
            print("❌❌❌ \(error)")
            return nil
        }
        
    }
    
    public func decodeIfPresent(_ type: Int.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int? {
        do {
            return try decode(Int.self, forKey: key)

        } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
            return nil

        } catch DecodingError.typeMismatch {
            do {
                return try Int(decode(String.self, forKey: key))
            } catch DecodingError.typeMismatch {
                return try Int(decode(Bool.self, forKey: key) == true ? 1 : 0)

            } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
                return nil

            } catch {
                print("❌❌❌ \(error)")
                return nil
            }
        } catch { //DecodingError.typeMismatch, DecodingError.keyNotFound ,DecodingError.valueNotFound{
            print("❌❌❌ \(error)")
            return nil
        }
        
    }
    
    public func decodeIfPresent(_ type: Double.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Double? {
        do {
            return try decode(Double.self, forKey: key)

        } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
            return nil

        } catch {//DecodingError.typeMismatch, DecodingError.keyNotFound ,DecodingError.valueNotFound{
            print("❌❌❌ \(error)")
            return nil
        }
    }
    
    public func decodeIfPresent(_ type: Bool.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Bool? {
        do {
            return try decode(Bool.self, forKey: key)
       
        } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
            return nil

        } catch DecodingError.typeMismatch {
            do {
                return try Bool(decode(Int.self, forKey: key) == 1)
                
            } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
                return nil

            } catch {
                print("❌❌❌ \(error)")
                return nil
            }

        } catch {//DecodingError.typeMismatch, DecodingError.keyNotFound, DecodingError.valueNotFound {
            print("❌❌❌ \(error)")
            return nil
        }
    }
    
    // public func decodeIfPresent<T:Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> NewBaseResponse<T>? {
    //     do {
    //         return try decode(NewBaseResponse<T>.self, forKey: key)
    //     } catch {//DecodingError.typeMismatch, DecodingError.keyNotFound ,DecodingError.valueNotFound{
    //         return nil
    //     }
    // }
    
    public func decodeIfPresent<T: Decodable>(_ type: T?.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T? {
        do {
            return try decode(T?.self, forKey: key)
            
        } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
            return nil
            
        } catch { //DecodingError.typeMismatch, DecodingError.dataCorrupted {
            print("❌❌❌ \(error)")
            return nil
        }
    }
    
    public func decodeIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T? {
        do {
            return try decode(T?.self, forKey: key)
            
        } catch DecodingError.keyNotFound, DecodingError.valueNotFound {
            return nil
            
        } catch { //DecodingError.typeMismatch, DecodingError.dataCorrupted {
            print("❌❌❌ \(error)")
            return nil
        }
    }
    
    // public func decodeIfPresent(_ type: [].Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> []? {
    //     do {
    //         return try decode(String.self, forKey: key)
    //     } catch {//DecodingError.typeMismatch, DecodingError.keyNotFound ,DecodingError.valueNotFound{
    //         return nil
    //     }
    // }
}




// MARK: - JSONNumber

// enum JSONNumber<T: Numeric>: Codable where T: Codable { // Correct
// Numeric & Codable & LosslessStringConvertible
enum JSONNumber<T: Codable & LosslessStringConvertible>: Codable { // Correct
    case value(T)
    //case string(String)
    
    var value: T {
        switch self {
        case .value(let num):
            return num
            // case .string(let string):
            //     return T(string)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        
        // Decode the number
        do {
            let numVal = try container.decode(T.self)
            self = .value(numVal)
        } catch DecodingError.typeMismatch {
            // Decode the string
            let string = try container.decode(String.self)
            if let value_ = T(string.trimmingCharacters(in: .whitespacesAndNewlines)) {
                self = .value(value_)
            } else {
                throw DecodingError.typeMismatch(
                    T.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Encoded payload not of an expected type"
                    )
                )
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .value(let value):
            try container.encode(value)
            /*
             case .string(let value):
             try container.encode(value)
             */
        }
    }
}


// // MARK: - JSONString
// 
// struct JSONString: Codable {
//     let value: String
//     
//     static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//         let context = DecodingError.Context(codingPath: codingPath, debugDescription: "JSONString")
//         return DecodingError.typeMismatch(JSONString.self, context)
//     }
// 
//     init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
//         if let value = try? container.decode(Bool.self, forKey: .value) {
//             self.value = "\(value)"
//             
//         } else if let value = try? container.decode(Int64.self, forKey: .value) {
//             self.value = "\(value)"
//             
//         } else if let value = try? container.decode(Double.self, forKey: .value) {
//             self.value = "\(value)"
//             
//         } else if let value = try? container.decode(String.self, forKey: .value) {
//             self.value = value
//             
//         } else {
//             throw JSONString.decodingError(forCodingPath: container.codingPath)
//             
//         }
//     }
//     
// }


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
