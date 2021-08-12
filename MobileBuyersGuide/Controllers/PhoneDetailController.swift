//
//  PhoneDetailController.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit
import ProgressHUD

class PhoneDetailController: UIViewController {
    
    // --------------------------
    // MARK: - Property
    // --------------------------
    
    public var mobileViewModel: MobileViewModel!
    
    // --------------------------
    // MARK: - Lifecyle Methods
    // --------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadData()
        
        ProgressHUD.show("Loading...")
    }
    
    // --------------------------
    // MARK: - Load Data
    // --------------------------
    
    private func loadData() {
        SCBRequestManager.shared.getImages(mobileId: mobileViewModel.id) { [weak self] result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let images):
                print(images)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        view.backgroundColor = .white
    }
}
