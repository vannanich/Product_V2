
//
//  NavBar.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//

import UIKit
 
enum ButtomNav: Int, CaseIterable {
    case home
    case categories
    case search
    case myProducts
    case basket
  
    var title: String {
        switch self {
        case .home: return "Home"
        case .categories: return "Categories"
        case .search: return "Search"
        case .myProducts: return "Products"
        case .basket: return "Basket"
        }
    }
 
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .categories: return "square.grid.2x2.fill"
        case .search: return "magnifyingglass"
        case .myProducts: return "heart.fill"
        case .basket: return "basket.fill"
        }
    }
}
 
class TabBarView: UIView {
 
    var onSelect: ((ButtomNav) -> Void)?
 
    private(set) var selectedItem: ButtomNav = .home {
        didSet { updateSelection() }
    }
 
    private let selectedTintColor: UIColor = .systemGreen
    private let unselectedTintColor: UIColor = .darkGray
 
    private var buttons: [ButtomNav: UIButton] = [:]
    private let stackView = UIStackView()
    private let selectionPill = UIView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
 
    private func setupLayout() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 4)
 
        selectionPill.backgroundColor = selectedTintColor.withAlphaComponent(0.12)
        selectionPill.layer.cornerRadius = 18
        addSubview(selectionPill)
 
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)
 
        translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            heightAnchor.constraint(equalToConstant: 64)
        ])
 
        for item in ButtomNav.allCases {
            let button = makeButton(for: item)
            buttons[item] = button
            stackView.addArrangedSubview(button)
        }
 
        updateSelection()
    }
 
    private func makeButton(for item: ButtomNav) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: item.iconName)
        config.title = item.title
        config.imagePlacement = .top
        config.imagePadding = 4
        
        //
        config.imagePlacement = .top
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 12, bottom: 20, trailing: 12)
        config.baseForegroundColor = unselectedTintColor
        config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .systemFont(ofSize: 8, weight: .medium)
                return outgoing
            }
 
        let button = UIButton(configuration: config)
        button.tag = item.rawValue
        button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        return button
    }
 
    @objc private func tabTapped(_ sender: UIButton) {
        guard let item = ButtomNav(rawValue: sender.tag) else { return }
        selectedItem = item
        onSelect?(item)
    }
 
    func select(_ item: ButtomNav) {
        selectedItem = item
    }
 
    private func updateSelection() {
        for (item, button) in buttons {
            let isSelected = item == selectedItem
            button.configuration?.baseForegroundColor = isSelected ? selectedTintColor : unselectedTintColor
        }
        layoutIfNeeded()
        positionPill(under: selectedItem, animated: true)
    }
 
    private func positionPill(under item: ButtomNav, animated: Bool) {
        guard let button = buttons[item] else { return }
        let targetFrame = button.frame.insetBy(dx: -6, dy: 6)
 
        let apply = { self.selectionPill.frame = targetFrame }
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: apply)
        } else {
            apply()
        }
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        positionPill(under: selectedItem, animated: false)
    }
}
 
