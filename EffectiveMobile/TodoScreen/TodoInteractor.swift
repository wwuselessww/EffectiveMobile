//
//  TodoInteractor.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 23.06.25.
//

import Foundation

protocol TodoInteractorProtocol:AnyObject {
    var presenter: TodoPresenterProtocol? { get set }
    func handleSavingTodo(title: String, body: String)
}

class TodoInteractor: TodoInteractorProtocol {
   weak var presenter:  TodoPresenterProtocol?
    
    func handleSavingTodo(title: String, body: String) {
        CoreDataManager.shared.createTodo(title: title, date: Date.now, body: body)
    }
}
