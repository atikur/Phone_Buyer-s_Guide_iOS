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
    // MARK: - Properties
    // --------------------------
    
    private var selectedTab: Tab = .all {
        didSet {
        }
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
        view.addSubview(tabControl)
        tabControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tabControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private let tabControl: TabControl = {
        let options = Tab.allCases.map {$0.rawValue.capitalized}
        let tabControl = TabControl(options: options)
        tabControl.isUserInteractionEnabled = true
        tabControl.translatesAutoresizingMaskIntoConstraints = false
        return tabControl
    }()
}
