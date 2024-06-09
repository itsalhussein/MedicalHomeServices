//
// JSONDecoder+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation

extension JSONDecoder {
    static func serverJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let text = try container.decode(String.self).trimmed()

            let formatters: [DateFormatter] = [.serverDateTimeFormatter, .serverDateTimeFormatterWithMilliSec, .serverDateTimeFormatterWithZone]

            var date: Date?
            formatters.forEach { formatter in
                if let value = formatter.date(from: text) { date = value }
            }
            if let date = date {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(text)")

        }
        return decoder
    }

}


extension DateFormatter {
    /// 2022-10-09T13:58:09
    static let serverDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier:"UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    /// 2021-09-15T18:32:05.712
    static let serverDateTimeFormatterWithMilliSec: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier:"UTC")
        return formatter
    }()
    /// 2021-09-15T18:32:05.712Z or 2022-09-30T06:00:00.000+0000
    static let serverDateTimeFormatterWithZone: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier:"UTC")
        return formatter
    }()

}


