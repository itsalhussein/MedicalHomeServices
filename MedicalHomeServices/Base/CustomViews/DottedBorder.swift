//
// DottedBorder.swift
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct DottedBorder: Shape {
    var strokeWidth: CGFloat = 1
    var dash: [CGFloat] = [5, 5] // Adjust this array to change the dash pattern
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Draw the outer rectangle
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        // Draw the dotted border
        path = path.trimmedPath(from: 0, to: 1)
        return path
    }
}
