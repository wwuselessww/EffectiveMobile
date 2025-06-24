//
//  TodoViewModel.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 22.06.25.
//

import UIKit

struct TodoListViewModel {
    var todos: [TodoViewModel]
    var totalCount: Int
}

struct TodoViewModel {
    var id: UUID
    var title: String
    var image: String
    var body: String
    var date: String
    var btnColor: UIColor
}
