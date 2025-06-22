//
//  ToDoCell.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit
protocol ToDoCellDelegate {
    func didTapCheckbox(for cell: ToDoCell)
}


class ToDoCell: UITableViewCell {
    static let identifier = "ToDoCell"
    var delegate: ToDoCellDelegate?
    var titleLbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.textColor = .label
        l.text = "Make a ToDo list app"
        return l
    }()
    
    var bodyLbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .label
        l.numberOfLines = 2
        l.text = "Lorem ipsum dolor sit amet consectetur adipisicing elit."
//        l.backgroundColor = .red
        return l
    }()
    
    var dateLbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .secondaryLabel
        l.text = "02/10/24"
//        l.backgroundColor = .green
        return l
    }()
    
    var doneBtn: UIButton = {
        let btn = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "circle"), for: .normal)
        btn.tintColor = .secondaryLabel
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBtn()
        setupTitleLbl()
        setupBodyLbl()
        setupDateLbl()
        doneBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBtn() {
        contentView.addSubview(doneBtn)
        NSLayoutConstraint.activate([
            doneBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            doneBtn.widthAnchor.constraint(equalToConstant: 24),
            doneBtn.heightAnchor.constraint(equalToConstant: 24),
            doneBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        ])
    }
    
    private func setupTitleLbl() {
        contentView.addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: doneBtn.trailingAnchor, constant: 8),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLbl.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func setupBodyLbl() {
        contentView.addSubview(bodyLbl)
        NSLayoutConstraint.activate([
            bodyLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 6),
            bodyLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            bodyLbl.heightAnchor.constraint(lessThanOrEqualToConstant: 32)
        ])
    }
    
    private func setupDateLbl() {
        contentView.addSubview(dateLbl)
        NSLayoutConstraint.activate([
            dateLbl.topAnchor.constraint(equalTo: bodyLbl.bottomAnchor, constant: 6),
            dateLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            dateLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    @objc private func didTapButton(sender: UIButton) {
        delegate?.didTapCheckbox(for: self)
    }
    
    func configure(with viewModel: TodoViewModel) {
        titleLbl.text = viewModel.title
        bodyLbl.text = viewModel.body
        dateLbl.text = viewModel.date
        doneBtn.setImage(UIImage(systemName: viewModel.image), for: .normal)
        doneBtn.tintColor = viewModel.btnColor
    }
    
    
    
    
}
