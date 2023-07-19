//
//  TaskListViewModel.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import Foundation
import SwiftUI

class BikingListViewModel: ObservableObject {
    @Published var allTask: [Task] = []

    func getTaskList() {
        allTask = BikingDataStore.shared.getAllTasks()
    }

    // 删除:删除完成刷新页面
    func deleteTask(at indexSet: IndexSet) {
        let id = indexSet.map { self.allTask[$0].id }.first
        if let id = id {
            let delete = BikingDataStore.shared.delete(id: id)
            if delete {
                getTaskList()
            }
        }
    }
}
