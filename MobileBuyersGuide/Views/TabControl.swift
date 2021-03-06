//
//  TabControl.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

protocol TabControlDelegate: class {
    func didChangeTab(selectedIndex: Int)
}

class TabControl: UIView {
    
    // --------------------------
    // MARK: - Properties
    // --------------------------
    
    weak var delegate: TabControlDelegate?
    
    private let options: [String]
    
    private var selectedIndex: Int = 0 {
        didSet {
            handleTabSwitchUIUpdate()
        }
    }
    
    // --------------------------
    // MARK: - Initializers
    // --------------------------
    
    init(options: [String]) {
        self.options = options
        self.selectedIndex = 0
        
        super.init(frame: .zero)
        setupViews()
        addTapGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --------------------------
    // MARK: - Action Handlers
    // --------------------------
    
    @objc private func handleDidTapOnFirstOption() {
        selectedIndex = 0
        delegate?.didChangeTab(selectedIndex: selectedIndex)
    }
    
    @objc private func handleDidTapOnSecondOption() {
        selectedIndex = 1
        delegate?.didChangeTab(selectedIndex: selectedIndex)
    }
    
    // --------------------------
    // MARK: - Helpers
    // --------------------------
    
    private func handleTabSwitchUIUpdate() {
        if selectedIndex == 0 {
            firstOptionLabel.textColor = Color.tabFocused
            secondOptionLabel.textColor = Color.tabUnfocused
        } else {
            firstOptionLabel.textColor = Color.tabUnfocused
            secondOptionLabel.textColor = Color.tabFocused
        }
    }
    
    // --------------------------
    // MARK: - Setup UI
    // --------------------------
    
    private func setupViews() {
        addContainerView()
        addFirstOptionLabel()
        addSecondOptionLabel()
    }
    
    private func addContainerView() {
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addFirstOptionLabel() {
        containerView.addSubview(firstOptionLabel)
        firstOptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        firstOptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        firstOptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        firstOptionLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func addSecondOptionLabel() {
        containerView.addSubview(secondOptionLabel)
        secondOptionLabel.leadingAnchor.constraint(equalTo: firstOptionLabel.trailingAnchor).isActive = true
        secondOptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        secondOptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        secondOptionLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func addTapGestureRecognizers() {
        let firstOptionTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDidTapOnFirstOption))
        firstOptionLabel.isUserInteractionEnabled = true
        firstOptionLabel.addGestureRecognizer(firstOptionTapRecognizer)
        
        let secondOptionTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDidTapOnSecondOption))
        secondOptionLabel.isUserInteractionEnabled = true
        secondOptionLabel.addGestureRecognizer(secondOptionTapRecognizer)
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var firstOptionLabel: UILabel = {
        let label = UILabel()
        label.text = options[0]
        label.textAlignment = .center
        label.textColor = Color.tabFocused
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondOptionLabel: UILabel = {
        let label = UILabel()
        label.text = options[1]
        label.textAlignment = .center
        label.textColor = Color.tabUnfocused
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
