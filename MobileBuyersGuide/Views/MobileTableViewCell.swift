//
//  MobileTableViewCell.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit
import SDWebImage

protocol MobileCellDelegate: class {
    func didTapFavorite(mobile: MobileViewModel)
}

class MobileTableViewCell: UITableViewCell {
    
    // --------------------------
    // MARK: - Properties
    // --------------------------
    
    public static let cellId = String(describing: MobileTableViewCell.self)
    public weak var delegate: MobileCellDelegate?
    private var mobile: MobileViewModel?
    
    public var isDisplayingFavoritesTab = false {
        didSet {
            favoriteButton.isHidden = isDisplayingFavoritesTab
        }
    }
    
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
    // MARK: - Lifecyle Methods
    // --------------------------
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        priceLabel.text = nil
        ratingLabel.text = nil
        mobileImageView.image = nil
    }
    
    // --------------------------
    // MARK: - Action Handlers
    // --------------------------
    
    @objc private func handleDidTapFavoriteButton() {
        guard let mobile = mobile else { return }
        delegate?.didTapFavorite(mobile: mobile)
        setFavoriteButtonImage()        
    }
    
    // --------------------------
    // MARK: - Configure Cell
    // --------------------------
    
    public func configure(mobile: MobileViewModel) {
        self.mobile = mobile
        
        titleLabel.text = mobile.name.trimmingCharacters(in: .whitespaces)
        descriptionLabel.text = mobile.description.trimmingCharacters(in: .whitespaces)
        ratingLabel.text = "Rating: \(mobile.rating)"
        priceLabel.text = "Price: $\(mobile.price)"
        
        guard let imageUrl = URL(string: mobile.thumbImageURL) else { return }
        mobileImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
        
        setFavoriteButtonImage()
    }
    
    private func setFavoriteButtonImage() {
        guard let isFavorite = mobile?.isFavorite else { return }
        let favoriteImg = isFavorite ? "starFilled" : "starEmpty"
        favoriteButton.setImage(UIImage(named: favoriteImg), for: .normal)
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(mobileImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(favoriteButton)
        
        addLabels()
        addImageAndButton()
    }
    
    private func addLabels() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mobileImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
        ratingLabel.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
    }
    
    private func addImageAndButton() {
        favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor).isActive = true
        
        mobileImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mobileImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        mobileImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -24).isActive = true
        mobileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
    
    private let mobileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "starEmpty"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDidTapFavoriteButton), for: .touchUpInside)
        return button
    }()
}
