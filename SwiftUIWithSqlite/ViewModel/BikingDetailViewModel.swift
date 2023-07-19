//
//  BikingDetailViewModel.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import Foundation

class BikingDetailViewModel: ObservableObject {
    var id: Int64
    private var task: Task?

    @Published var name: String = ""
    @Published var approxDate: Date = .init()
    @Published var status: String = "Incomplete"

    init(id: Int64) {
        self.id = id
        getTask()
    }

    func getTask() {
        task = BikingDataStore.shared.findTask(taskId: id)
        if let task = task {
            name = task.name
            approxDate = task.date
            status = task.status ? "Completed" : "Incomplete"
        }
    }

    func onUpdateClick() -> Bool {
        return BikingDataStore.shared.update(id: id,
                                             name: name,
                                             date: approxDate,
                                             status: status == "Completed")
    }
}
