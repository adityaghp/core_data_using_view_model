//
//  ViewModel.swift
//  LearningSwiftUIIntermediate
//
//  Created by Aditya Ghorpade on 10/02/24.
//

import Foundation
import CoreData

class CoreDataViewM: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data... \(error)")
            } else {
                print("Core data loaded successfully..")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching... \(error)")
        }
    }
    
    func addFruit(name: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
    
    func deleteFruit(index: IndexSet) {
        guard let index = index.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
        /*
        if let index = index.first {
            let entity = savedEntities[index]
            container.viewContext.delete(entity)
            saveData()
        }
         */
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving.. \(error)")
        }
    }
}
