//
//  TaskInsertViewModel.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import Foundation

class BikingInsertViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var startDate: Date = .init()

    func onAddButtonClick() -> Int64? {
        let db = BikingDataStore.shared
        return db.insert(name: name, date: startDate)
    }
}
