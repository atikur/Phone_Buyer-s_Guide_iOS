//
//  MobileDetailCollectionViewCell.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

class MobileDetailCollectionViewCell: UICollectionViewCell {
    
    // --------------------------
    // MARK: - Properties
    // --------------------------
    
    public static let cellId = String(describing: MobileDetailCollectionViewCell.self)
    
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
    // MARK: - Configure Cell
    // --------------------------
    
    public func configure(viewModel: MobileViewModel, image: MobileImage) {
        // some urls don't have url scheme, let's fix that
        let urlStr: String
        
        if image.url.hasPrefix("https://") || image.url.hasPrefix("http://") {
            urlStr = image.url
        } else {
            urlStr = "http://\(image.url)"
        }
        
        guard let imageUrl = URL(string: urlStr) else { return }
        mobileImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
        
        ratingLabel.text = "Rating: \(viewModel.rating)"
        priceLabel.text = "Price: $\(viewModel.price)"
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        contentView.addSubview(mobileImageView)
        contentView.addSubview(infoContainerView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingLabel)
        
        addPhoneImageView()
        addInfoLabels()
    }
    
    private func addPhoneImageView() {
        mobileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        mobileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mobileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        mobileImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addInfoLabels() {
        infoContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        infoContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        infoContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        infoContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: infoContainerView.centerYAnchor).isActive = true
        
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mobileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
