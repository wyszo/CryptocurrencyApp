//
//  FruitListViewController.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

class FruitListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var adapter: TableViewAdapter?
    
    var viewDidFinishDrawing: VoidCallback?
    
    var router: RouterProtocol?
    var analyticsProvider: AnalyticsProviderProtocol?
    var viewModel: FruitListViewModel?
    {
        didSet {
            viewModel?.fetch()
            viewModel?.viewModelDidChange = { [weak self] fruits in
                self?.adapter?.numberOfItems = fruits.count
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidFinishDrawing?()
        
        let adapter = TableViewAdapter(tableView: tableView,
                                       cellReuseId: cellReuseId,
                                       allowRefreshControl: true)
        self.adapter = adapter
        
        adapter.didPullToRefresh = { [weak self] in
            self?.viewModel?.fetch()
        }
        adapter.didSelectRow = { [weak self] row in
            guard let `self` = self else { return }
            assert(self.router != nil)

            guard let fruit = self.viewModel?.fruitAtIndex(row) else {
                assertionFailure("data model inconsistency, row doesn't exist")
                self.analyticsProvider?.errorDidOccur(error: TableAdapterError.dataInconsistencyError)
                return
            }
            self.router?.presentFruitDetailViewController(fruit: fruit)
        }
        adapter.cellForRow = { [weak self] row, cell in
            cell.textLabel?.text = self?.viewModel?.fruitAtIndex(row)?.type
        }
        
        if let fruits = viewModel?.fruits {
            adapter.numberOfItems = fruits.count
        }
    }
    
    let cellReuseId = "FruitCellIdentifier"
}
