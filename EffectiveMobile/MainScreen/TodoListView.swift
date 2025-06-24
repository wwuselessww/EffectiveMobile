//
//  ViewController.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit
protocol ToDoListViewProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    
    func update(with todos: TodoListViewModel?)
    func update(with error: String)
}

class TodoListVC: UIViewController, ToDoListViewProtocol, ToDoCellDelegate {

    var presenter: ToDoListPresenterProtocol?
    
    internal var table: UITableView = {
        var t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.identifier)
        t.isHidden = true
        return t
    }()
    
    private var errorLbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isHidden = true
        l.textColor = .label
        return l
    }()
    internal var footer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray6
        return v
    }()
    private var newTodoBtn: UIButton = {
        var btn = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: symbolConfig), for: .normal)
        btn.tintColor = .systemYellow
        return btn
    }()
    
    private var taskCountLbl: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.text = "7 Задач"
        lbl.textAlignment = .center
        return lbl
    }()
    private var searchController: UISearchController = UISearchController()
    var todos: TodoListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupSearchController()
        setupErrorLbl()
        
        setupFooter()
        setupCreateNewTodoBtn()
        setupTaskCounterLbl()
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
    
    private func setupFooter() {
        view.addSubview(footer)
        NSLayoutConstraint.activate([
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 83)
        ])
    }
    
    private func setupCreateNewTodoBtn() {
        footer.addSubview(newTodoBtn)
        newTodoBtn.addTarget(self, action: #selector(tapNewNoteBtn), for: .touchUpInside)
        NSLayoutConstraint.activate([
            newTodoBtn.trailingAnchor.constraint(equalTo: footer.trailingAnchor),
            newTodoBtn.widthAnchor.constraint(equalToConstant: 68),
            newTodoBtn.heightAnchor.constraint(equalToConstant: 44),
            newTodoBtn.topAnchor.constraint(equalTo: footer.topAnchor, constant: 5)
        ])
    }
    
    private func setupTaskCounterLbl() {
        footer.addSubview(taskCountLbl)
        NSLayoutConstraint.activate([
            taskCountLbl.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            taskCountLbl.topAnchor.constraint(equalTo: footer.topAnchor, constant: 20),
            taskCountLbl.widthAnchor.constraint(equalToConstant: 200),
            taskCountLbl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func tapNewNoteBtn(_ sender: UIButton) {
        print("ejej")
        presenter?.didTapCreateNewTodo()
    }
    
    //MARK: protocol methods
    
    func update(with todos: TodoListViewModel?) {
        print("ww")
        DispatchQueue.main.async {
            print("jeje")
            self.todos = todos
            self.table.reloadData()
            self.table.isHidden = false
            guard let todos else { return }
            self.taskCountLbl.text = String("\(todos.totalCount) Задач")
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.errorLbl.text = error
            self.errorLbl.isHidden = false
            self.table.isHidden = true
            self.todos = nil
            self.taskCountLbl.text = ""
        }
    }
    
    func didTapCheckbox(for cell: ToDoCell) {
        if let indexPath = table.indexPath(for: cell) {
            presenter?.didTapDone(at: indexPath)
        }
    }
    
    
}


