//
//  TodoListPresenterTests.swift
//  EffectiveMobileTests
//
//  Created by Alexander Kozharin on 26.06.25.
//

import XCTest
import CoreData
@testable import EffectiveMobile

class MockTodoListView: ToDoListViewProtocol {
    var presenter: ToDoListPresenterProtocol?
    
    func update(with todos: TodoListViewModel?) {
        didUpdateWithViewModel = todos
    }
    
    var didUpdateWithViewModel: TodoListViewModel?
    var didUpdateWithError: String?
    
    func update(with error: String) {
        didUpdateWithError = error
    }
}

final class TodoListPresenterTests: XCTestCase {
    var presenter: TodoListPresenter!
    var persistentContainer: NSPersistentContainer!
    
    override func setUp() {
        persistentContainer = {
            let container = NSPersistentContainer(name: "TodoDataModel")
            return container
        }()
    }
    
    func testInteractorDidFetchTodos_successfulResult_updatesView() {
        // Arrange
        let mockView = MockTodoListView()
        presenter = TodoListPresenter()
        presenter.view = mockView
        
        let context = persistentContainer.viewContext
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = "Test Task"
        task.bodyText = "Test Body"
        task.completed = false
        
        // Act
        presenter.interactorDidFetchTodos(with: .success([task]))
        
        // Assert
        guard let viewModel = mockView.didUpdateWithViewModel else {
            XCTFail("View model was not updated")
            return
        }
        
        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertEqual(viewModel.todos[0].title, "Test Task")
        XCTAssertEqual(viewModel.todos[0].body, "Test Body")
        XCTAssertEqual(viewModel.todos[0].image, "circle")
    }
    
    func testInteractorDidFetchTodos_failureResult_updatesViewWithError() {
        // Arrange
        let mockView = MockTodoListView()
        presenter = TodoListPresenter()
        presenter.view = mockView
        
        // Act
        presenter.interactorDidFetchTodos(with: .failure(CoreDataError.NoTodo))
        
        // Assert
        XCTAssertEqual(mockView.didUpdateWithError, "Something went wrong")
    }

}
