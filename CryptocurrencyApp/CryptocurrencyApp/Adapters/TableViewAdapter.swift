//
//  TableViewAdapter.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

class TableViewAdapter: NSObject {
    typealias CellForRowCallback = (Int, UITableViewCell) -> ()
    
    private let tableView: UITableView
    private let cellReuseId: String
    
    var didPullToRefresh: VoidCallback?
    var didSelectRow: IntCallback?
    var cellForRow: CellForRowCallback?
    var numberOfItems = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    init(tableView: UITableView, cellReuseId: String, allowRefreshControl: Bool) {
        self.tableView = tableView
        self.cellReuseId = cellReuseId
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        super.init()
        
        bindTo(tableView: tableView)
        
        if allowRefreshControl {
            tableView.refreshControl = self.refreshControl
        }
    }
    
    private func bindTo(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func handleRefresh() {
        didPullToRefresh?()
        refreshControl.endRefreshing()
    }
}

extension TableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        didSelectRow?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        cell.textLabel?.textAlignment = .center
        
        cellForRow?(indexPath.row, cell)
        return cell
    }
}

public enum TableAdapterError: Error {
    case dataInconsistencyError
}

extension TableAdapterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataInconsistencyError:
            return NSLocalizedString("data model inconsistency, row doesn't exist", comment: "")
        }
    }
}
