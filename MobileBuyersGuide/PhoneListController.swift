//
//  PhoneListController.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

class PhoneListController: UIViewController {
    
    enum Tab: String, CaseIterable {
        case all
        case favorite
    }
    
    // --------------------------
    // MARK: - Action Handlers
    // --------------------------
    
    @objc private func handleDidTapSortBarButtonItem() {
        print("sort")
    }
    
    // --------------------------
    // MARK: - Lifecyle Methods
    // --------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        view.backgroundColor = .white
        
        addSortBarButtonItem()
        addTabOptions()
    }
    
    private func addSortBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleDidTapSortBarButtonItem))
    }
    
    // --------------------------
    // MARK: - Tab Options
    // --------------------------
    
    private func addTabOptions() {
        view.addSubview(tabOptionsContainer)
        tabOptionsContainer.addSubview(allOptionLabel)
        tabOptionsContainer.addSubview(favoriteOptionLabel)
        
        tabOptionsContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabOptionsContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabOptionsContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tabOptionsContainer.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        allOptionLabel.leadingAnchor.constraint(equalTo: tabOptionsContainer.leadingAnchor).isActive = true
        allOptionLabel.centerYAnchor.constraint(equalTo: tabOptionsContainer.centerYAnchor).isActive = true
        allOptionLabel.widthAnchor.constraint(equalTo: tabOptionsContainer.widthAnchor, multiplier: 0.5).isActive = true
        
        favoriteOptionLabel.leadingAnchor.constraint(equalTo: allOptionLabel.trailingAnchor).isActive = true
        favoriteOptionLabel.centerYAnchor.constraint(equalTo: tabOptionsContainer.centerYAnchor).isActive = true
        favoriteOptionLabel.widthAnchor.constraint(equalTo: tabOptionsContainer.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private let tabOptionsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        return view
    }()
    
    private let allOptionLabel: UILabel = {
        let label = UILabel()
        label.text = Tab.all.rawValue.capitalized
        label.textAlignment = .center
        label.textColor = Color.tabFocused
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteOptionLabel: UILabel = {
        let label = UILabel()
        label.text = Tab.favorite.rawValue.capitalized
        label.textAlignment = .center
        label.textColor = Color.tabUnfocused
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
