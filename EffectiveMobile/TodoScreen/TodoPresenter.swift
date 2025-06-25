//
//  TodoPresenter.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 23.06.25.
//

import Foundation

protocol TodoPresenterProtocol: AnyObject {
    var router: TodoRouterProtocol? {get set}
    var interactor: TodoInteractorProtocol? {get set}
    var view: TodoViewProtocol? {get set}
    var viewModel: TodoViewModel? {get set}
    func didTapBack(title: String, body: String)
    var creationDelegate: TodoCreationProtocol? { get set }
}

protocol TodoCreationProtocol: AnyObject {
    func didCreateNewTodo()
}

class TodoPresenter: TodoPresenterProtocol {
   
    var viewModel: TodoViewModel?
    var router: TodoRouterProtocol?
    var interactor: TodoInteractorProtocol?
    weak var view: TodoViewProtocol?
    weak var creationDelegate: TodoCreationProtocol?
    func didTapBack(title: String, body: String) {
        if viewModel == nil {
            interactor?.handleSavingTodo(title: title, body: body)
            creationDelegate?.didCreateNewTodo()
            print("save")
        } else {
//            interactor?.handleEditTodo(title: title, body: body)
            print("edit")
            
        }
        router?.navigateBack()
    }
}
