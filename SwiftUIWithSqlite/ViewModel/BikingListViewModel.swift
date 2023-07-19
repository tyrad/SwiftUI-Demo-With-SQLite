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
}
