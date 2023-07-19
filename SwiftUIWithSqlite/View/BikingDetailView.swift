//
//  BikingDetailView.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct BikingDetailView: View {
    
    @ObservedObject var viewModel: BikingDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var status = ["Completed", "Incomplete"]

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Text("Name:")
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
            }

            HStack(spacing: 20) {
                Text("Approx Date:")
                DatePicker("", selection: $viewModel.approxDate)
                Spacer()
            }

            HStack {
                Text("Status:")
                Picker("Choose Status?", selection: $viewModel.status) {
                    ForEach(status, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                Spacer()
            }

            HStack {
                Button(action: {
                    let updateSuccess = viewModel.onUpdateClick()
                    if updateSuccess {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Update")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                }
                .background(Color.accentColor)
                .cornerRadius(.infinity)
                .padding()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct BikingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BikingDetailView.init(viewModel: BikingDetailViewModel.init(id: 1))
    }
}
