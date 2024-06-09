//
//  Image+Extension.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 22/10/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import SwiftUI

extension Image {
    init?(base64String: String?) {
        guard let base64String = base64String else { return nil }
        guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
