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
    func reloadTodos()
}

class TodoPresenter: TodoPresenterProtocol {
    
    var viewModel: TodoViewModel?
    var router: TodoRouterProtocol?
    var interactor: TodoInteractorProtocol?
    weak var view: TodoViewProtocol?
    weak var creationDelegate: TodoCreationProtocol?
    
    func didTapBack(title: String, body: String) {
        guard let viewModel = viewModel else {
            interactor?.handleSavingTodo(title: title, body: body)
            creationDelegate?.reloadTodos()
            print("save")
            router?.navigateBack()
            return
        }
        interactor?.handleEditTodo(id: viewModel.id, title: title, body: body)
        creationDelegate?.reloadTodos()
        print("edit")
        router?.navigateBack()
        print(1)
    }
}
