//
//  TodoListPresenter.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import Foundation

protocol ToDoListPresenterProtocol: AnyObject {
    var router: ToDoListRouterProtocol? {get set}
    var interactor: ToDoListInteractorProtocol? {get set}
    var view: ToDoListViewProtocol? {get set}
    
    func interactorDidFetchTodos(with result: Result<TodoListModel, Error>)
    func didTapDone(at indexPath: IndexPath)
}

class TodoListPresenter: ToDoListPresenterProtocol {
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
            view?.update(with: todoModel)
        case.failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    func didTapDone(at indexPath: IndexPath) {
        interactor?.handleDoneTap(at: indexPath)
    }
}
