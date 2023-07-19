//
//  ContentView.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BikingListView(viewModel: BikingListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
