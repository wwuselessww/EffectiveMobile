//
//  TodoView.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 23.06.25.
//

import UIKit

protocol TodoViewProtocol: AnyObject {
    var presenter: TodoPresenterProtocol? { get set }
}

class TodoView: UIViewController, TodoViewProtocol {
    var presenter: (any TodoPresenterProtocol)?
    var dateLbl: UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = .secondaryLabel
        return l
    }()
    var titleField: UITextField = {
        var t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = .label
        t.font = UIFont.systemFont(ofSize: 34)
        t.text = "Kekekeke"
        return t
    }()
    
    var bodyTextView: UITextView = {
        var tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .label
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTitle()
        setupDate()
        setupBody()
        setupNavigationBar()
    }
    
    private func setupTitle() {
        view.addSubview(titleField)
//        titleField.backgroundColor = .yellow
        titleField.text = presenter?.viewModel?.title
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleField.heightAnchor.constraint(greaterThanOrEqualToConstant: 41)
        ])
    }
    
    private func setupNavigationBar() {
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(tapBackButton))
        backBtn.tintColor = .systemYellow
        navigationItem.leftBarButtonItem = backBtn
    }
    
    private func setupDate() {
        view.addSubview(dateLbl)
//        dateLbl.backgroundColor = .blue
        dateLbl.text = presenter?.viewModel?.date
        NSLayoutConstraint.activate([
            dateLbl.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 8),
            dateLbl.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            dateLbl.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            dateLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func setupBody() {
        view.addSubview(bodyTextView)
//        bodyTextView.backgroundColor = .red
        bodyTextView.text = presenter?.viewModel?.body
        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 16),
            bodyTextView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    @objc private func tapBackButton() {
        dismiss(animated: true)
        print("tapped back")
        presenter?.navigateBack()
    }
}
