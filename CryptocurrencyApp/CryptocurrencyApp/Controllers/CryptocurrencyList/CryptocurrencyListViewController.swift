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
        initializeStrings()
        initializeList()
    }
    
    private func initializeStrings() {
        navigationItem.title = viewModel.navbarTitle
    }
    
    private func initializeList() {
        let adapter = TableViewAdapter(tableView: tableView,
                                       cellReuseId: Constants.cellReuseId,
                                       allowRefreshControl: true)
        
        self.adapter = adapter
        
        viewModel.fetch().done { [weak self] cryptoList in
            guard let `self` = self else {
                assertionFailure("ViewController instance deallocated prematurely!")
                return
            }
            guard let adapter = self.adapter else {
                assertionFailure("Adapter instance deallocated prematurely!")
                return
            }
            adapter.numberOfItems = cryptoList.cryptocurrencies.count
        }.catch { error in
            assertionFailure("Error handling not implemented yet")
        }
        
        adapter.didPullToRefresh = { [weak self] in
            guard let `self` = self else {
                assertionFailure("ViewController instance deallocated prematurely!")
                return
            }
            _ = self.viewModel.fetch()
        }
        
        adapter.didSelectRow = { [weak self] row in
            guard let `self` = self else {
                assertionFailure("Unexpected closure; ViewController deallocated!")
                return
            }
            guard let currency = self.viewModel.itemAtIndex(row) else {
                assertionFailure("data model inconsistency, row doesn't exist")
                return
            }
            self.router.presentCryptocurrencyDetailViewController(currency)
        }
        
        adapter.cellForRow = { [weak self] row, cell in
            guard let `self` = self else {
                assertionFailure("ViewController class deallocated unnexpectedly!")
                return
            }
            cell.textLabel?.text = self.viewModel.itemAtIndex(row)?.shortDescription
        }
    }
    
    struct Constants {
        static let cellReuseId = "CryptocurrencyCellIdentifier"
    }
}
