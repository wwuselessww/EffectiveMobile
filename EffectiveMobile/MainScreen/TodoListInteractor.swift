//
//  TodoListInteractor.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import Foundation

enum FetchError: Error {
    case networkError
    case decodingError
    case unknown
}

//https://dummyjson.com/todos
protocol ToDoListInteractorProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    func getToDos()
    func handleDoneTap(at indexPath: IndexPath)
}
class TodoListInteractor: ToDoListInteractorProtocol {
   weak var presenter: ToDoListPresenterProtocol?
    
    func getToDos() {
        let url = URL(string: "https://dummyjson.com/todos")!
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("got error fetching todos")
                self?.presenter?.interactorDidFetchTodos(with: .failure(FetchError.unknown))
                return
            }
            do {
                let entities = try JSONDecoder().decode(TodoListModel.self, from: data)
                self?.presenter?.interactorDidFetchTodos(with: .success(entities))
                
            } catch {
                self?.presenter?.interactorDidFetchTodos(with: .failure(error))
            }
        }
        task.resume()
    }
    
    func handleDoneTap(at indexPath: IndexPath) {
        //update completion state in coredata
        print("hehe\(indexPath.row)")
    }
    
    
}
