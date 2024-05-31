//
//  DetailsProductViewController.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 10/04/24.
//

import UIKit

class DetailsProductViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    let viewmodel = DetailsProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    private func setData() {
        if let imageUrl = URL(string: viewmodel.productModel.image) {
            ImageLoader.loadImage(from: imageUrl, into: productImageView)
            titleLabel.text = viewmodel.productModel.title
            priceLabel.text = "$ \(viewmodel.productModel.price)"
            descriptionLabel.text = viewmodel.productModel.description
            categoryLabel.text = "Category: \(viewmodel.productModel.category)"
            rateLabel.text = "Rating: \(viewmodel.productModel.rating.rate)"
            countLabel.text = "Stock: \(viewmodel.productModel.rating.count)"
        }
        
    }
    
    
}
