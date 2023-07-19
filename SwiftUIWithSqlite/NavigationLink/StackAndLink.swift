//
//  StackAndLink.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

enum Route {
    case NewView
}

struct StackAndLink: View {
    var body: some View {
        NavigationStack {
            NavigationLink(value: Route.NewView) {
                Text("Show NewView")
            }
            .navigationDestination(for: Route.self) { view in
                if view == Route.NewView {
                    Text("This is NewView")
                }
            }
        }
    }
}

struct StackAndLink_Previews: PreviewProvider {
    static var previews: some View {
        StackAndLink()
    }
}
