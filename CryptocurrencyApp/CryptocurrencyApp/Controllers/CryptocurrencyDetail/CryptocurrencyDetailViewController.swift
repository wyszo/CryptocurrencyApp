//
//  CryptocurrencyDetailViewController.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit
import Resolver

class CryptocurrencyDetailViewController: UIViewController {
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var shortName: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var change7d: UILabel!
    
    var viewModel: CryptocurrencyDetailViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let viewModel = viewModel, isViewLoaded else {
            return
        }
        
        name.text = viewModel.name
        shortName.text = viewModel.shortName
        price.text = viewModel.priceUSD
        change7d.text = viewModel.changePercent7d
    }
}
