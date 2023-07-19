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
    private var db: Connection? = nil

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
    func insert(name:String ,date:Date) -> Int64? {
        guard let database = db else { return nil }
        let insert = tasks.insert(self.name <- name,
                                  self.date <- date,
                                  self.status <- false)
        do {
            let rowId = try database.run(insert)
            return rowId
        }catch {
            print(error)
            return nil
        }
    }
    
    // 获取全部task
    func getAllTasks() -> [Task] {
        var tasks:[Task] = []
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
        }catch {
            print(error)
        }
        return tasks
    }
}
