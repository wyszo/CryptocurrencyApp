//
//  CryptoListViewController.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit
import Resolver

class CryptoListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var adapter: TableViewAdapter?
    
    @Injected private var router: RouterProtocol
    @Injected private var viewModel: CryptoListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeStrings()
        initializeList()
        viewModel.attachedToView()
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
                assertionFailure("ViewController deallocated!")
                return
            }
            guard let currency = self.viewModel.itemAtIndex(row) else {
                assertionFailure("Data model inconsistency, row doesn't exist")
                return
            }
            self.viewModel.itemSelected(cryptocurrency: currency)
            self.router.presentCryptoDetailViewController(currency)
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

