//
//  TodoRouter.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 23.06.25.
//

import UIKit

typealias TodoEntryPoint = TodoViewProtocol & UIViewController

protocol TodoRouterProtocol {
    var todoEntryPoint: TodoEntryPoint? { get }
    static func start(_ viewModel: TodoViewModel?) -> TodoRouterProtocol
    func navigateBack()
}

class TodoRouter: TodoRouterProtocol {
    var todoEntryPoint: TodoEntryPoint?
    
    static func start(_ viewModel: TodoViewModel? = nil) -> TodoRouterProtocol {
        let router = TodoRouter()
        let view: (TodoViewProtocol)? = TodoView()
        let interactor: TodoInteractorProtocol = TodoInteractor()
        let presenter: TodoPresenterProtocol = TodoPresenter()
        
        view?.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.viewModel = viewModel
        
        router.todoEntryPoint = view as? TodoEntryPoint
    
        return router
    }
    
    func navigateBack() {
        print("from router navigate back")
        todoEntryPoint?.navigationController?.popViewController(animated: true)
    }
}
