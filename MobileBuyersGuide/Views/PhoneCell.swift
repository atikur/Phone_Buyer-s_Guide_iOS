//
//  PhoneCell.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

class PhoneCell: UITableViewCell {
    
    // --------------------------
    // MARK: - Properties
    // --------------------------
    
    public static let cellId = String(describing: PhoneCell.self)
    
    // --------------------------
    // MARK: - Initializers
    // --------------------------
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --------------------------
    // MARK: - Configure
    // --------------------------
    
    public func configure(mobile: Mobile) {
        titleLabel.text = mobile.name.trimmingCharacters(in: .whitespaces)
        descriptionLabel.text = mobile.description.trimmingCharacters(in: .whitespaces)
        ratingLabel.text = "Rating: \(mobile.rating)"
        priceLabel.text = "Price: $\(mobile.price)"
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        backgroundColor = .white
        
        addPhoneImageView()
        addLabels()
    }
    
    private func addPhoneImageView() {
        contentView.addSubview(phoneImageView)
        phoneImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        phoneImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        phoneImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    private func addLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(ratingLabel)
        contentView.addSubview(favoriteButton)
        
        titleLabel.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}