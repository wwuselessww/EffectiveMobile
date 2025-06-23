//
//  TodoListPresenter.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

//import Foundation
import UIKit

protocol ToDoListPresenterProtocol: AnyObject {
    var router: ToDoListRouterProtocol? {get set}
    var interactor: ToDoListInteractorProtocol? {get set}
    var view: ToDoListViewProtocol? {get set}
    var viewModel: TodoListViewModel? {get set}
    
    func interactorDidFetchTodos(with result: Result<TodoListModel, Error>)
    func didTapDone(at indexPath: IndexPath)
    func didTapCreateNewTodo()
    func didTapOnCell(at indexPath: IndexPath)
}

class TodoListPresenter: ToDoListPresenterProtocol {
    var viewModel: TodoListViewModel?
    var router: ToDoListRouterProtocol?
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorProtocol? {
        didSet {
            interactor?.getToDos()
        }
    }
    
   
    
    func interactorDidFetchTodos(with result: Result<TodoListModel, Error>) {
        switch result {
        case.success(let todoModel):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let todos = todoModel.todos.map { todo in
                let date = todo.date ?? Date.now
                return TodoViewModel(
                    title: todo.title ?? "Task Title" ,
                    image: todo.completed ? "checkmark.circle" : "circle",
                    body: todo.todo,
                    date: dateFormatter.string(from: date),
                    btnColor: todo.completed ? .systemYellow : .secondaryLabel
                )
            }
            let todoListViewModel: TodoListViewModel = TodoListViewModel(todos: todos, totalCount: todos.count)
            viewModel = todoListViewModel
            view?.update(with: todoListViewModel)
        case.failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    func didTapDone(at indexPath: IndexPath) {
        interactor?.handleDoneTap(at: indexPath)
    }
    
    func didTapCreateNewTodo() {
        print("new todo")
        guard let vc = view as? UIViewController else {
            print("no vc")
            return
        }
        router?.navigateToCreateNewToDo(from: vc)
    }
    func didTapOnCell(at indexPath: IndexPath) {
        guard let vc = view as? UIViewController else {
            print("no vc")
            return
        }
        guard let viewModel = viewModel?.todos[indexPath.row] else {
            print("no view model")
            return
        }
        router?.navigateToDetail(from: vc, viewModel: viewModel)
    }
}
