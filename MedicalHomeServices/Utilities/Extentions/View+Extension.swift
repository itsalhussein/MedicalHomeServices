//
//  View+Extension.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 22/10/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
//    func hidden(_ shouldHide: Bool) -> some View {
//        opacity(shouldHide ? 0 : 1)
//    }
}

//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape( RoundedCorner(radius: radius, corners: corners) )
//    }
//}

extension View {
    func navigatePush(whenTrue toggle: Binding<Bool>) -> some View {
        NavigationLink(
            destination: self,
            isActive: toggle
        ) { EmptyView() }
    }

    func navigatePush<H: Hashable>(when binding: Binding<H>,
                                   matches: H) -> some View {
        NavigationLink(
            destination: self,
            tag: matches,
            selection: Binding<H?>(binding)
        ) { EmptyView() }
    }

    func navigatePush<H: Hashable>(when binding: Binding<H?>,
                                   matches: H) -> some View {
        NavigationLink(
            destination: self,
            tag: matches,
            selection: binding
        ) { EmptyView() }
    }
}
