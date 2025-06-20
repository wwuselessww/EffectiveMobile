//
//  ViewController.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit
protocol ToDoListViewProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    
    func update(with todos: TodoListModel?)
    func update(with error: String)
}

class TodoListVC: UIViewController, ToDoListViewProtocol {
    var presenter: ToDoListPresenterProtocol?
    
    internal var table: UITableView = {
        var t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        t.isHidden = true
        return t
    }()
    
    private var errorLbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isHidden = true
        l.textColor = .green
        return l
    }()
    
    private var searchController: UISearchController = UISearchController()
    var todos: TodoListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupSearchController()
        setupErrorLbl()
        setupTableView()

        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    

    
    
    
    private func setupErrorLbl() {
        view.addSubview(errorLbl)
        
        NSLayoutConstraint.activate([
            errorLbl.widthAnchor.constraint(equalToConstant: 200),
            errorLbl.heightAnchor.constraint(equalToConstant: 50),
            errorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    //MARK: protocol methods

    func update(with todos: TodoListModel?) {
        DispatchQueue.main.async {
            self.todos = todos
            self.table.reloadData()
            self.table.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.errorLbl.text = error
            self.errorLbl.isHidden = false
            self.table.isHidden = true
            self.todos = nil
        }
    }
}


