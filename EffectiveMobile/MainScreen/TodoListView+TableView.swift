//
//  Untitled.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//
import UIKit

extension TodoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let todos = todos else { return 0 }
        return todos.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        guard let todos = todos else { return cell }
        cell.textLabel?.text = todos.todos[indexPath.row].todo
        return cell
    }
    
    internal func setupTableView() {
        view.addSubview(table)
        table.backgroundColor = .systemBackground
        table.delegate = self
        table.dataSource = self
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}
