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
    var skip: Int
    var limit: Int
}

struct TodoModel: Decodable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
    var title: String?
    var date: Date?
}
