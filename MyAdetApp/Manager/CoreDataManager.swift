//
//  CoreDataManager.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Adet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Core Data Stack: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError(
                    "Couldn't save context of Core Data: \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveNewHabit(name: String, goalDays: Int32) {
        let newHabit = Adet(context: mainContext)
        newHabit.name = name
        newHabit.date = Date()
        newHabit.completed = false
        newHabit.streak = 0
        newHabit.goalDays = max(1, goalDays)
        saveContext()
    }

    func fetchHabits() -> [Adet] {
        let fetchRequest: NSFetchRequest<Adet> = Adet.fetchRequest()

        do {
            let habits = try mainContext.fetch(fetchRequest)
            return habits
        } catch {
            print("Error downloading habits: \(error)")
            return []
        }
    }
}
