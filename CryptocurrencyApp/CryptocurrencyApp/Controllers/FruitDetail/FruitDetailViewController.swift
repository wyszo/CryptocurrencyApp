//
//  FruitDetailViewController.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

class FruitDetailViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var viewDidFinishDrawing: VoidCallback?
    
    var viewModel: FruitDetailViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewDidFinishDrawing?()
    }
    
    func updateUI() {
        guard let viewModel = viewModel, isViewLoaded else {
            return
        }
        
        typeLabel.text = viewModel.type
        priceLabel.text = viewModel.price
        weightLabel.text = viewModel.weight
    }
}
