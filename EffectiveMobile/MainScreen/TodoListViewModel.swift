//
//  TodoViewModel.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 22.06.25.
//

import Foundation

struct TodoListViewModel {
    var todos: [TodoViewModel]
    var totalCount: Int
}

struct TodoViewModel {
    var title: String
    var image: String
    var body: String
    var date: Date
}
