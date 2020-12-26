//
//  CryptocurrencyListViewController.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit
import Resolver

class CryptocurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var adapter: TableViewAdapter?
    @Injected private var router: RouterProtocol
    @Injected private var viewModel: CryptocurrencyListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeList()
    }
    
    private func initializeList() {
        let adapter = TableViewAdapter(tableView: tableView,
                                       cellReuseId: Constants.cellReuseId,
                                       allowRefreshControl: true)
        
        self.adapter = adapter
        
        adapter.didPullToRefresh = { [weak self] in
            guard let `self` = self else {
                assertionFailure("ViewController class deallocated prematurely!")
                return
            }
            _ = self.viewModel.fetch()
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
