//
//  CGFloat+Extention.swift
//  Safer Resident
//
//  Created by Ramy Sabry on 25/05/2021.
//  Copyright © 2021 Ramy Ayman Sabry. All rights reserved.
//

import Foundation
import QuartzCore


extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
}
