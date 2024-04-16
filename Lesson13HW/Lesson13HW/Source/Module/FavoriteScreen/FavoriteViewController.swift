//
//  FavoriteViewController.swift
//  Lesson13HW
//

//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var contentView: FavoriteView!
    var model: FavoriteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
        setupClearAllItems()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.saveChangesIfNeeded()
       
    }
    
    private func setupInitialState() {
        
        title = "Favorite"
        
        model = FavoriteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(CustomCellTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        contentView.tableView.separatorColor = .systemGreen
        contentView.tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    private func setupClearAllItems() {
        let clearAll = UIBarButtonItem(title: "Remove All", style: .plain, target: self, action: #selector(removeList))
        navigationItem.rightBarButtonItem = clearAll
        clearAll.isEnabled = !model.favoriteItems.isEmpty
    }
    @objc private  func removeList() {
        let alertVC = UIAlertController(title: "This list will be deleted", message: nil, preferredStyle: .alert)
        let agreeAction = UIAlertAction(title: "Yes", style: .default, handler: {[weak self]_ in
            guard let self = self else {return}
            self.model.clearAllFavorites()
            self.setupClearAllItems()
        }
      )
        let cancelButton = UIAlertAction(title: "No", style: .default, handler: nil)
        alertVC.addAction(agreeAction)
        alertVC.addAction(cancelButton)
        present(alertVC, animated: true)
    }
}

// MARK: - FavoriteModelDelegate
extension FavoriteViewController: FavoriteModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - FavoriteViewDelegate
extension FavoriteViewController: FavoriteViewDelegate {
   
    
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCellTableViewCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = model.favoriteItems[indexPath.row]
        cell.configuteFavoriteItem(pc: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.removeFromFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            model.saveChangesIfNeeded()
            setupClearAllItems()
        }
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    
    
}
