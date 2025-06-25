//
//  CoreDataManager.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 24.06.25.
//

import Foundation
import CoreData

class CoreDataManager {
   static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    private init() {
            container = NSPersistentContainer(name: "TodoDataModel")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("❌ Failed to load Core Data stack: \(error)")
                } else {
                    print("✅ Persistent store loaded: \(description)")
                }
            }
        }
    var context: NSManagedObjectContext {
            return container.viewContext
        }
    
    func createTodo(title: String, date: Date, body: String) {
        let todoEntity = TaskEntity(context: context)
        todoEntity.id = UUID()
        todoEntity.title = title
        todoEntity.bodyText = body
        todoEntity.date = date
        todoEntity.completed = false
        saveContext()
    }
    func fetchTodo(with id: UUID) -> TaskEntity? {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        do {
            let todo = try context.fetch(request)
            return todo.first
        } catch {
            print("cant fetch todo: \(error)")
            return nil
        }
        
    }
    
    func deleteTodo(with id: UUID) {
            guard let todo = fetchTodo(with: id) else { return }
            context.delete(todo)
            saveContext()
    }
    func toggleTodo(with id: UUID) {
       var todo = fetchTodo(with: id)
        todo?.completed.toggle()
        saveContext()
    }
    
    func fetchTodos() -> [TaskEntity] {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let todos = try context.fetch(fetchRequest)
            return todos
        } catch {
            print("cant fetch todos: \(error)")
        }
        return []
    }
    
    func updateTodo(with id: UUID, title: String? = nil, body: String? = nil, date: Date? = nil) {
        guard let todo = fetchTodo(with: id) else { return }
        if let title = title {
            todo.title = title
        }
        if let body = body {
            todo.bodyText = body
        }
        if let date = date {
            todo.date = date
        }
        print(todo)
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
}

