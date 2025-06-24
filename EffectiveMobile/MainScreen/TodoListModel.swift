//
//  TodoModel.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import Foundation


struct TodoListModel: Decodable {
    var todos: [TodoModel]
    var total: Int
}

struct TodoModel: Decodable {
    var id: Int
    var todo: String
    var completed: Bool
    var title: String?
    var date: Date?
}
