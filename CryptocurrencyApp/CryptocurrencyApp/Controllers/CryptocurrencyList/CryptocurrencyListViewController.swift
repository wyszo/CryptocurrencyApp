//
//  CryptocurrencyListViewController.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

class CryptocurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var adapter: TableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeList()
    }
    
    private func initializeList() {
        let adapter = TableViewAdapter(tableView: tableView,
                                       cellReuseId: Constants.cellReuseId,
                                       allowRefreshControl: true)
        
        self.adapter = adapter
        
        adapter.didPullToRefresh = {
            assertionFailure("not implemented yet")
        }
        
        adapter.didSelectRow = { _ in
            assertionFailure("not implemented yet")
        }
        
        adapter.cellForRow = { _, _ in
            assertionFailure("not implemented yet")
        }
    }
    
    struct Constants {
        static let cellReuseId = "CryptocurrencyCellIdentifier"
    }
}
