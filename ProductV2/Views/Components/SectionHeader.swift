//
//  SectionHeader.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//

import UIKit

class SectionHeader: UIView{
    // for title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    // for button
    private let actionButton: UIButton = {

        let button = UIButton(type: .system)

        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.setTitleColor(
            UIColor(
                red: 0.55,
                green: 0.75,
                blue: 0.25,
                alpha: 1
            ),
            for: .normal
        )
        return button
    }()
    // create it put title and button tgt
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    func configure(title: String, actionTitle: String? = nil) {
        titleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)
    }
}
