//
//  ButtonNavigationView.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct ButtonNavigationView: View {
    @State private var isShowingSecondView: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: { isShowingSecondView = true }) {
                    Text("Show second view")
                }
            }.navigationDestination(isPresented: $isShowingSecondView) {
                Text("SecondView")
            }
        }
    }
}

struct ButtonNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonNavigationView()
    }
}
