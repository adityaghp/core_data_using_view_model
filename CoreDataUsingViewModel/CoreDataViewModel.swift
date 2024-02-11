//
//  CoreDataViewModel.swift
//  LearningSwiftUIIntermediate
//
//  Created by Aditya Ghorpade on 10/02/24.
//

import SwiftUI

struct CoreDataViewModel: View {
    
    @StateObject var vm = CoreDataViewM()
    @State private var textFieldText: String = ""
    @State private var updateItem: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                Button {
                    if !textFieldText.isEmpty {
                        vm.addFruit(name: textFieldText)
                    }
                    textFieldText = ""
                } label: {
                    Text("Submit")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(vm.savedEntities) { fruits in
                        HStack {
                            Text(fruits.name ?? "No data")
                                .onTapGesture {
                                    updateItem.toggle()
                                }
                        }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataViewModel()
}
