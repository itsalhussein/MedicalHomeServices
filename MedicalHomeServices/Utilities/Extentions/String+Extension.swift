//
//  String+Extension.swift
//  Safer Resident
//
//  Created by Ramy Sabry on 25/05/2021.
//  Copyright © 2021 Ramy Ayman Sabry. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func copyToClipboard() {
        UIPasteboard.general.setValue(self, forPasteboardType: "public.plain-text")
    }
    
    var firstAndSecondChars: String {
        let saStringArray = split{$0 == " "}.map(String.init)
        
        guard saStringArray.isEmpty == false else { return "" }
        
        if saStringArray.count > 1 {
            let saName: String = String(saStringArray[0].prefix(1)) + String(saStringArray[1].prefix(1))
            return saName.uppercased()
        } else {
            return String(saStringArray[0].prefix(1)).uppercased()
        }
    }
}

extension String {
    func capitalizeFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func capitalizeFirstCharInWord() -> String {
        var wordsArray = split{$0 == " "}.map(String.init)
        wordsArray.indices.forEach({ wordsArray[$0] = wordsArray[$0].capitalizeFirstLetter() })
        return wordsArray.joined(separator: " ")
    }
    
    func getSingleCharSaName() -> String {
        let saStringArray = split{$0 == " "}.map(String.init)
        if saStringArray.count > 0 {
           return String(saStringArray[0].prefix(1)).uppercased()
        }
        return ""
    }
}


extension String {
    func stringCharCountWithoutSpacing() -> Int {
        return String(filter { !" \n\t\r".contains($0) }).count
    }
    
    func stringCharWithoutSpacing() -> String {
        return String(filter { !" \n\t\r".contains($0) })
    }
}
