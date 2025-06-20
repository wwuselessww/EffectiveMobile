//
//  TodoListRouter.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit
typealias ToDoEntryPoint = ToDoListViewProtocol & UIViewController

protocol ToDoListRouterProtocol: AnyObject {
    var entry: ToDoEntryPoint? { get }
    static func start() -> ToDoListRouterProtocol
}

class TodoListRouter: ToDoListRouterProtocol {
    var entry: ToDoEntryPoint?
    
    static func start() -> ToDoListRouterProtocol {
        let router = TodoListRouter()
        var view: (ToDoListViewProtocol)? = TodoListVC()
        var presenter: ToDoListPresenterProtocol = TodoListPresenter()
        var interactor: ToDoListInteractorProtocol = TodoListInteractor()
        
        view?.presenter = presenter
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? ToDoEntryPoint
        return router
    }
    
    
}
