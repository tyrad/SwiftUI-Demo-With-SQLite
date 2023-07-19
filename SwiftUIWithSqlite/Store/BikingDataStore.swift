//
//  TaskDataStore.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import Foundation
import SQLite

class BikingDataStore {
    static let shared = BikingDataStore()

    static let DIR_TASK_DB = "BikingDB"
    static let STORE_NAME = "biking.sqlite3"

    private let tasks = Table("bike_record")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let date = Expression<Date>("date")
    private let status = Expression<Bool>("status")
    private var db: Connection?

    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)

            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }

    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            // 创建表
            try database.run(tasks.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(name)
                table.column(date)
                table.column(status)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }

    // 新增
    func insert(name: String, date: Date) -> Int64? {
        guard let database = db else { return nil }
        let insert = tasks.insert(self.name <- name,
                                  self.date <- date,
                                  status <- false)
        do {
            let rowId = try database.run(insert)
            return rowId
        } catch {
            print(error)
            return nil
        }
    }

    // 获取全部task
    func getAllTasks() -> [Task] {
        var tasks: [Task] = []
        guard let database = db else {
            return []
        }
        do {
            for task in try database.prepare(self.tasks) {
                tasks.append(Task(id: task[id],
                                  name: task[name],
                                  date: task[date],
                                  status: task[status]))
            }
        } catch {
            print(error)
        }
        return tasks
    }

    // 查找
    func findTask(taskId: Int64) -> Task? {
        var task = Task(id: taskId, name: "", date: Date(), status: false)
        guard let database = db else {
            return nil
        }
        let filter = tasks.filter(id == taskId)
        do {
            for t in try database.prepare(filter) {
                task.name = t[name]
                task.date = t[date]
                task.status = t[status]
            }
        } catch {
            print(error)
        }
        return task
    }

    // 更新
    func update(id: Int64, name: String, date: Date = Date(), status: Bool = false) -> Bool {
        guard let database = db else {
            return false
        }

        let task = tasks.filter(self.id == id)
        do {
            let update = task.update([
                self.name <- name,
                self.date <- date,
                self.status <- status
            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    // 删除
    func delete(id: Int64) -> Bool {
        guard let database = db else {
            return false
        }
        do {
            let filter = tasks.filter(self.id == id)
            try database.run(filter.delete())
            return true
        } catch {
            print(error)
            return false
        }
    }
}
