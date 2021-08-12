//
//  PhoneListController.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit
import ProgressHUD

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
    
    private var mobileList: [Mobile] = []
    
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
        loadData()
        
        ProgressHUD.show("Loading...")
    }
    
    // --------------------------
    // MARK: - Load Data
    // --------------------------
    
    private func loadData() {
        SCBRequestManager.shared.getMobileList { [weak self] result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let mobiles):
                self?.mobileList = mobiles
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
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
        
        addSortBarButtonItem()
        addTabOptions()
        addTableView()
    }
    
    private func addSortBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleDidTapSortBarButtonItem))
    }
    
    private func addTabOptions() {
        view.addSubview(tabControl)
        tabControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tabControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: tabControl.bottomAnchor, constant: 12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private let tabControl: TabControl = {
        let options = Tab.allCases.map {$0.rawValue.capitalized}
        let tabControl = TabControl(options: options)
        tabControl.isUserInteractionEnabled = true
        tabControl.translatesAutoresizingMaskIntoConstraints = false
        return tabControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.register(PhoneCell.self, forCellReuseIdentifier: PhoneCell.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

extension PhoneListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneCell.cellId, for: indexPath) as! PhoneCell
        cell.configure(mobile: mobileList[indexPath.row])
        return cell
    }
}
