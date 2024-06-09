//
// Router.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

//https://betterprogramming.pub/routing-in-swiftui-with-navigationstack-aa8bb9b032de
//https://www.swiftyplace.com/blog/better-navigation-in-swiftui-with-navigation-stack
//https://blorenzop.medium.com/routing-navigation-in-swiftui-f1f8ff818937

extension NavigationPath{
    
    mutating func navigate<T : Hashable>(to destination: T) {
        append(destination)
    }
    
    mutating func navigateBack() {
        if count > 0{
            removeLast()
        }
    }

    mutating func navigateToRoot() {
        if count > 0{
            removeLast(count)
        }
    }
}

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case home
        case boarding
        case text(x:String)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        if navPath.count > 0{
            navPath.removeLast()
        }
    }

    func navigateToRoot() {
        if navPath.count > 0{
            navPath.removeLast(navPath.count)
        }
    }
    
    static let shared = Router()

}
