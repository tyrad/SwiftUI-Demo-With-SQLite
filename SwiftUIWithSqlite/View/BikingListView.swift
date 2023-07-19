//
//  TaskListView.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct BikingListView: View {
    @ObservedObject
    var viewModel: BikingListViewModel

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    Text("Welcome !!!")
                        .font(.largeTitle.bold())
                    if viewModel.allTask.isEmpty {
                        Text("You have no record.")
                    } else {
                        List {
                            ForEach(viewModel.allTask, id: \.id) { task in
                                Text(task.name)
                            }
                        }
                        .listStyle(.plain)
                        .onAppear {
                            UITableView.appearance().backgroundColor = .clear
                            UITableViewCell.appearance().selectionStyle = .none
                            UITableView.appearance().showsVerticalScrollIndicator = false
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            BikingInsertView.init(viewModel: BikingInsertViewModel.init())
                        } label: {
                            BikingStartButton()
                            .padding()
                        }
                    }
                }
            }.onAppear {
                // 页面出现的时候，进行数据刷新
                viewModel.getTaskList()
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        BikingListView(viewModel: BikingListViewModel())
    }
}
