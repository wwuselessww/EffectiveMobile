//
//  Untitled.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//
import UIKit

extension TodoListVC: UITableViewDelegate, UITableViewDataSource {
    
    internal func setupTableView() {
        view.addSubview(table)
        table.backgroundColor = .systemBackground
        table.delegate = self
        table.dataSource = self
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: footer.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    //MARK: delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let todos = todos else { return 0 }
        return todos.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        guard let todos = todos else { return cell }
        let todo = todos.todos[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapOnCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                     trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                     -> UISwipeActionsConfiguration? {
          let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
              guard let id = self?.todos?.todos[indexPath.row].id else { return }
              self?.presenter?.didDeleteTodo(with: id)
//              self?.items.remove(at: indexPath.row)
              
              DispatchQueue.main.async {
                  tableView.deleteRows(at: [indexPath], with: .automatic)
                  tableView.reloadData()
              }
              completionHandler(true)
          }
          deleteAction.backgroundColor = .systemRed
          let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
          configuration.performsFirstActionWithFullSwipe = true
          return configuration
      }
                         
}
