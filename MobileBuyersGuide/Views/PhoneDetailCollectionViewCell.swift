//
//  PhoneDetailCollectionViewCell.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

class PhoneDetailCollectionViewCell: UICollectionViewCell {
    
    // --------------------------
    // MARK: - Properties
    // --------------------------
    
    public static let cellId = String(describing: PhoneDetailCollectionViewCell.self)
    
    // --------------------------
    // MARK: - Initializers
    // --------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --------------------------
    // MARK: - Configure
    // --------------------------
    
    public func configure(viewModel: MobileViewModel, image: MobileImage) {
        guard let imageUrl = URL(string: image.url) else { return }
        phoneImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        contentView.addSubview(phoneImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingLabel)
        
        phoneImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        phoneImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        phoneImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        phoneImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
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
}
