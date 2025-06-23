//
//  TodoListRouter.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit
typealias ToDoListEntryPoint = ToDoListViewProtocol & UIViewController

protocol ToDoListRouterProtocol: AnyObject {
    var entry: ToDoListEntryPoint? { get }
    static func start() -> ToDoListRouterProtocol
    func navigateToCreateNewToDo(from view: UIViewController)
    func navigateToDetail(from view: UIViewController, viewModel: TodoViewModel)
}

class TodoListRouter: ToDoListRouterProtocol {
    
    var entry: ToDoListEntryPoint?
    
    static func start() -> ToDoListRouterProtocol {
        let router = TodoListRouter()
        let view: (ToDoListViewProtocol)? = TodoListVC()
        let presenter: ToDoListPresenterProtocol = TodoListPresenter()
        let interactor: ToDoListInteractorProtocol = TodoListInteractor()
        
        view?.presenter = presenter
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? ToDoListEntryPoint
        return router
    }
    
    func navigateToCreateNewToDo(from view: UIViewController) {
        //navigate to the second view
        guard let todoVC = TodoRouter.start( ).todoEntryPoint else {
        print("no todo vc")
            return
        }
        view.navigationController?.pushViewController(todoVC, animated: true)
    }
    
    func navigateToDetail(from view: UIViewController, viewModel: TodoViewModel) {
        guard let todoVC = TodoRouter.start( viewModel).todoEntryPoint else {
            print("no todo view")
            return
        }
        view.navigationController?.pushViewController(todoVC, animated: true)
        
    }
    
    
}
