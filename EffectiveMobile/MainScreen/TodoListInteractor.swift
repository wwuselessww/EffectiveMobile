//
//  TodoListInteractor.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import Foundation

protocol ToDoListInteractorProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    func handleDoneTap(with id: UUID)
    func checkForFirstLaunch()
    func handleDelete(with id: UUID)
}
class TodoListInteractor: ToDoListInteractorProtocol {
    
    
    
   weak var presenter: ToDoListPresenterProtocol?
    
    func getToDosFromAPI() {
        let url = URL(string: "https://dummyjson.com/todos")!
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("got error fetching todos")
                self?.presenter?.interactorDidFetchTodos(with: .failure(FetchError.unknown))
                return
            }
            do {
                let entities = try JSONDecoder().decode(TodoListModel.self, from: data)
                var counter = 0
                for entity in entities.todos {
                    CoreDataManager.shared.createTodo(title: entity.title ?? "Задача № \(counter)", date: Date.now, body: entity.todo)
                    counter += 1
                }
                let taskArray = CoreDataManager.shared.fetchTodos()
                self?.presenter?.interactorDidFetchTodos(with: .success(taskArray))
            } catch {
                print(error)
                self?.presenter?.interactorDidFetchTodos(with: .failure(error))
            }
        }
        task.resume()
    }
    
    func handleDoneTap(with id: UUID) {
        //handle done
        CoreDataManager.shared.toggleTodo(with: id)
        let todos = CoreDataManager.shared.fetchTodos()
        presenter?.interactorDidFetchTodos(with: .success(todos))
    }
    
    func checkForFirstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            let taskArray = CoreDataManager.shared.fetchTodos()
            
            if taskArray.isEmpty {
                DispatchQueue.main.async {
                    self.presenter?.interactorDidFetchTodos(with: .failure(CoreDataError.NoTodo))
                    print("no todos")
                }
            } else {
                print("yes todos")
//                print(todoArray)
                DispatchQueue.main.async {
                    self.presenter?.interactorDidFetchTodos(with: .success(taskArray))
                }
            }
        } else {
            print("First launch, setting UserDefault.")
            getToDosFromAPI()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    func handleDelete(with id: UUID) {
        CoreDataManager.shared.deleteTodo(with: id)
        let todos = CoreDataManager.shared.fetchTodos()
        presenter?.interactorDidFetchTodos(with: .success(todos))
    }
    
}
