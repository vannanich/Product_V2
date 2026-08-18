//
//  NavigationBar.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//

import UIKit

class NavigationBar: UIView {

    var onChatTap: (() -> Void)?
    var onNotificationTap: (() -> Void)?
    var onProfileTap: (() -> Void)?

    // Main Title Label (Default: "DELiSHOP")
    private let onlineTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "DELiSHOP"
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.textColor = UIColor(red: 0.35, green: 0.65, blue: 0.2, alpha: 1.0)
        return label
    }()

    // Subtitle Label (Default: "ONLINE SUPERMARKET")
    private let onlineSubLabel: UILabel = {
        let label = UILabel()
        label.text = "ONLINE SUPERMARKET"
        label.font = .systemFont(ofSize: 7, weight: .bold)
        label.textColor = .gray
        return label
    }()

    private let expressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "DELiSHOP"
        label.font = .systemFont(ofSize: 12, weight: .black)
        label.textColor = .systemRed
        return label
    }()

    private let expressSubLabel: UILabel = {
        let label = UILabel()
        label.text = "EXPRESS"
        label.font = .systemFont(ofSize: 7, weight: .bold)
        label.textColor = .systemRed
        return label
    }()

    private lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.left.and.bubble.right.fill"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(chatTapped), for: .touchUpInside)
        return button
    }()

    private lazy var notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(notificationTapped), for: .touchUpInside)
        return button
    }()

    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 0.5, green: 0.75, blue: 0.2, alpha: 1.0)
        button.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    // REUSABLE METHOD: Call this from any screen to change only these 2 texts
    func configure(title: String, subtitle: String) {
        onlineTitleLabel.text = title
        onlineSubLabel.text = subtitle
    }

    private func setupLayout() {
        backgroundColor = .white

        let onlineStack = UIStackView(arrangedSubviews: [onlineTitleLabel, onlineSubLabel])
        onlineStack.axis = .vertical

        let expressStack = UIStackView(arrangedSubviews: [expressTitleLabel, expressSubLabel])
        expressStack.axis = .vertical

        let brandStack = UIStackView(arrangedSubviews: [onlineStack, expressStack])
        brandStack.axis = .horizontal
        brandStack.spacing = 12
        brandStack.alignment = .center

        let actionStack = UIStackView(arrangedSubviews: [chatButton, notificationButton, profileButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 14
        actionStack.alignment = .center

        addSubview(brandStack)
        addSubview(actionStack)

        brandStack.translatesAutoresizingMaskIntoConstraints = false
        actionStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            brandStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            brandStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            actionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc private func chatTapped() { onChatTap?() }
    @objc private func notificationTapped() { onNotificationTap?() }
    @objc private func profileTapped() { onProfileTap?() }
}
