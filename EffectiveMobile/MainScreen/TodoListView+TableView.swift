//
//  Untitled.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//
import UIKit

extension TodoListVC: UITableViewDelegate {
    
    internal func setupTableView() {
        view.addSubview(table)
        
        table.backgroundColor = .systemBackground
        table.delegate = self
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: footer.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    //MARK: delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapOnCell(at: indexPath)
    }
    
    func initialSnapshot() {
        var snapshot = dataSource.snapshot()

        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        if let todos = todoListModel?.todos {
            snapshot.appendItems(todos, toSection: 0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView,
                     trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                     -> UISwipeActionsConfiguration? {
          let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
              guard let id = self?.todoListModel?.todos[indexPath.row].id else { return }
              self?.presenter?.didDeleteTodo(with: id)
              completionHandler(true)
          }
          deleteAction.backgroundColor = .systemRed
          let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
          configuration.performsFirstActionWithFullSwipe = true
          return configuration
      }
                         
}
