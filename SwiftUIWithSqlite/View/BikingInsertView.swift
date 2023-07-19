//
//  BikingInsertView.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct BikingInsertView: View {
    @ObservedObject var viewModel: BikingInsertViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("Task Name : ")
                TextField("Task Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()

            HStack(spacing: 20) {
                Text("Start Date  :")
                DatePicker("", selection: $viewModel.startDate)
                Spacer()
            }
            .padding()

            HStack {
                Button(action: {
                    // 新增成功后，返回主键id【非空】
                    let id = viewModel.onAddButtonClick()
                    if id != nil {
                        // pop 
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                }
                .background(.blue)
                .cornerRadius(.infinity)
                .padding()
            }
            Spacer()
        }
    }
}

struct BikingInsertView_Previews: PreviewProvider {
    static var viewModel = BikingInsertViewModel()
    static var previews: some View {
        BikingInsertView(viewModel: viewModel)
    }
}
