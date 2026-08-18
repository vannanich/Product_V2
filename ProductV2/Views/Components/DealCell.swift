//
//  DealCell.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//

import UIKit

class DealCell: UICollectionViewCell {
    
    static let reuseID = "DealCell"
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .brown
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.numberOfLines = 1
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(badgeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // Image
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 130),
            
            // Badge
            badgeLabel.topAnchor.constraint(
                equalTo: imageView.topAnchor,
                constant: 8
            ),
            badgeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: 8
            ),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            badgeLabel.heightAnchor.constraint(equalToConstant: 26),
            // Title
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            // Description
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8)
        ])
    }
    
    
    func configure(with item: DealItem) {
        
        titleLabel.text = item.title
        descriptionLabel.text = item.descriptionText
        badgeLabel.text = item.badge?.text
        imageView.image = nil
        guard let imageURL = item.image,
              let url = URL(string: imageURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            
            guard let data = data,
                let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
            
        }.resume()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        badgeLabel.text = nil
    }
}
