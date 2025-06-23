//
//  TodoInteractor.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 23.06.25.
//

import Foundation

protocol TodoInteractorProtocol:AnyObject {
    var presenter: TodoPresenterProtocol? { get set }
}

class TodoInteractor: TodoInteractorProtocol {
   weak var presenter:  TodoPresenterProtocol?
    
    
    
}
