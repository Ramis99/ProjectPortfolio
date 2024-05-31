//
//  ProductsTableViewCell.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 10/04/24.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.blue.cgColor
        containerView.layer.cornerRadius = 8
    }
    
}
