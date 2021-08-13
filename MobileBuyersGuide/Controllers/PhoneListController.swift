//
//  PhoneListController.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit
import ProgressHUD

class PhoneListController: UIViewController {
    
    enum SortOption {
        case priceDesc
        case priceAsc
        case ratingDesc
    }
    
    // --------------------------
    // MARK: - Properties
    // --------------------------
    
    private var selectedTabIndex = 0 {
        didSet {
            if selectedTabIndex == 1 {
                MobileViewModel.filterFavorites(mobileList: mobileList) { favorites in
                    self.filteredList = favorites
                    self.sortResults()
                }
            } else {
                self.filteredList = self.mobileList
                self.sortResults()
            }
        }
    }
    
    private var selectedSortOption: SortOption? {
        didSet {
            sortResults()
        }
    }
    
    private var mobileList: [MobileViewModel] = []
    private var filteredList: [MobileViewModel] = [] {
        didSet {
            emptyLabel.text = selectedTabIndex == 0 ? "No records found!" : "No favoties yet! Add to favorite from All tab."
            emptyLabel.isHidden = !filteredList.isEmpty
            tableView.isHidden = filteredList.isEmpty
            !filteredList.isEmpty ? tableView.reloadData() : ()
        }
    }
    
    // --------------------------
    // MARK: - Action Handlers
    // --------------------------
    
    @objc private func handleDidTapSortBarButtonItem() {
        showSortAlert()
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
                self?.mobileList = mobiles.map {MobileViewModel(with: $0)}
                self?.filteredList = self?.mobileList ?? []
                self?.tableView.isHidden = false
            case .failure(let error):
                self?.filteredList = []
                if let error = error as? SCBRequestManager.SCBError {
                    self?.showAlert(title: "Error", message: error.message)
                } else {
                    self?.showAlert(title: "Error", message: "Please try again later.")
                }
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
        addEmptyLabel()
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
        tableView.topAnchor.constraint(equalTo: tabControl.bottomAnchor, constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    private func addEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        emptyLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 20).isActive = true
    }
    
    // --------------------------
    // MARK: - Sort
    // --------------------------
    
    private func showSortAlert() {
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.selectedSortOption = .priceAsc
        }))
        alertController.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.selectedSortOption = .priceDesc
        }))
        alertController.addAction(UIAlertAction(title: "Rating 5-1", style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.selectedSortOption = .ratingDesc
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    private func sortResults() {
        guard let sortOption = selectedSortOption else { return }
        switch sortOption {
        case .priceDesc:
            filteredList.sort(by: {$0.price > $1.price})
        case .priceAsc:
            filteredList.sort(by: {$0.price < $1.price})
        case .ratingDesc:
            filteredList.sort(by: {$0.rating > $1.rating})
        }
    }
    
    // --------------------------
    // MARK: - Views
    // --------------------------
    
    private lazy var tabControl: TabControl = {
        let tabControl = TabControl(options: ["All", "Favorite"])
        tabControl.delegate = self
        tabControl.isUserInteractionEnabled = true
        tabControl.translatesAutoresizingMaskIntoConstraints = false
        return tabControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 108
        tableView.tableFooterView = UIView()
        tableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: PhoneTableViewCell.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension PhoneListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneTableViewCell.cellId, for: indexPath) as! PhoneTableViewCell
        cell.configure(mobile: filteredList[indexPath.row])
        cell.isDisplayingFavoritesTab = selectedTabIndex == 1
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PhoneDetailController()
        controller.mobileViewModel = filteredList[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return selectedTabIndex == 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let mobileViewModel = filteredList[indexPath.row]
            mobileViewModel.removeFromFavorite()
            filteredList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        print("delete row")
    }
}

extension PhoneListController: PhoneCellDelegate {
    
    func didTapFavorite(mobile: MobileViewModel) {
        mobile.isFavorite() ? mobile.removeFromFavorite() : mobile.addToFavorite()
    }
}

extension PhoneListController: TabControlDelegate {
    
    func didChangeTab(selectedIndex: Int) {
        selectedTabIndex = selectedIndex
    }
}
