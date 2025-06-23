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
    func navigateBack()
}

class TodoPresenter: TodoPresenterProtocol {
    var viewModel: TodoViewModel?
    var router: TodoRouterProtocol?
    var interactor: TodoInteractorProtocol?
    weak var view: TodoViewProtocol?
    
    func navigateBack() {
        router?.navigateBack()
    }
}
