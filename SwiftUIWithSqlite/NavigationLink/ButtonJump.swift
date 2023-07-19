//
//  ButtonJump.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct ButtonJump: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Button("Button") {}
            } label: {
                Text("Hello, World!")
            }
        }
    }
}

struct ButtonJump_Previews: PreviewProvider {
    static var previews: some View {
        ButtonJump()
    }
}
