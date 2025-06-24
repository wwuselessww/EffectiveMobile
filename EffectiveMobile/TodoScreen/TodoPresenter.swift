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
}

class TodoPresenter: TodoPresenterProtocol {
    var viewModel: TodoViewModel?
    var router: TodoRouterProtocol?
    var interactor: TodoInteractorProtocol?
    weak var view: TodoViewProtocol?
    
    func didTapBack(title: String, body: String) {
        if viewModel == nil {
            interactor?.handleSavingTodo(title: title, body: body)
            print("save")
        } else {
//            interactor?.handleEditTodo(title: title, body: body)
            print("edit")
            
        }
        router?.navigateBack()
    }
}
