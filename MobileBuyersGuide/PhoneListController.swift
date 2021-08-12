//
//  PhoneListController.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

class PhoneListController: UIViewController {
    
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
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private func addSortBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleDidTapSortBarButtonItem))
    }
}
