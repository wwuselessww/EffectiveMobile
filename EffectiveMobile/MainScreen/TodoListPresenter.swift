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
    
    func interactorDidFetchTodos(with result: Result<[TaskEntity], Error>)
    func didTapDone(at indexPath: IndexPath)
    func didTapCreateNewTodo()
    func didTapOnCell(at indexPath: IndexPath)
    func didDeleteTodo(with id: UUID)
}

class TodoListPresenter: ToDoListPresenterProtocol {
    var viewModel: TodoListViewModel?
    var router: ToDoListRouterProtocol?
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorProtocol? {
        didSet {
            interactor?.checkForFirstLaunch()
        }
    }
    
    func interactorDidFetchTodos(with result: Result<[TaskEntity], Error>) {
        switch result {
        case.success(let todoModel):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let todos = todoModel.map { todo in
                let date = Date.now
                return TodoViewModel(
                    id: todo.id,
                    title: todo.title ?? "Task Title" ,
                    image: todo.completed ? "checkmark.circle" : "circle",
                    body: todo.bodyText ?? "no body????",
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
        guard let todo = viewModel?.todos[indexPath.row] else {return}
        interactor?.handleDoneTap(with: todo.id)
        view?.update(with: viewModel)
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
    
    func didDeleteTodo(with id: UUID) {
        interactor?.handleDelete(with: id)
        viewModel?.todos.removeAll { $0.id == id }
        let updateViewModel: TodoListViewModel = TodoListViewModel(todos: viewModel?.todos ?? [], totalCount: viewModel?.todos.count ?? 0)
        view?.update(with: updateViewModel)
    }
}
