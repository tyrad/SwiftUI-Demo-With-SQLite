//
//  NavigationPath.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct NavigationPathView: View {
    
    @State
    private var navPath:NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack.init(path: $navPath) {
            Button.init {
                navPath.append("NextPage")
            } label: {
                Text("Next Page")
            }.navigationDestination(for: String.self) { name in
                if name == "NextPage" {
                    Text("This is Next Page")
                }
            }
        }
    }
}

struct NavigationPath_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPathView()
    }
}
