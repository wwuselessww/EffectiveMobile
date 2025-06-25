//
//  Errors.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 26.06.25.
//

import Foundation

enum FetchError: Error {
    case networkError
    case decodingError
    case unknown
}

enum CoreDataError: Error {
    case fetchingError
    case savingError
    case NoTodo
}
