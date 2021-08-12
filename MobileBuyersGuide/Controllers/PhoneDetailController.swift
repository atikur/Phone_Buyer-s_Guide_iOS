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
    
    private var imageList: [MobileImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var mobileViewModel: MobileViewModel!
    
    // --------------------------
    // MARK: - Lifecyle Methods
    // --------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadData()
        
        ProgressHUD.show("Loading...")
        descriptionLabel.text = mobileViewModel.description
    }
    
    // --------------------------
    // MARK: - Load Data
    // --------------------------
    
    private func loadData() {
        SCBRequestManager.shared.getImages(mobileId: mobileViewModel.id) { [weak self] result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let images):
                self?.imageList = images
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
        title = mobileViewModel.name
        
        addCollectionView()
        addDescriptionLabel()
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.register(PhoneDetailCollectionViewCell.self, forCellWithReuseIdentifier: PhoneDetailCollectionViewCell.cellId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension PhoneDetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneDetailCollectionViewCell.cellId, for: indexPath) as! PhoneDetailCollectionViewCell
        cell.configure(viewModel: mobileViewModel, image: imageList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    // inter item spacing [spacing between columns]
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

