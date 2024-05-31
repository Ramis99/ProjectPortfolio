//
//  CategoriesCollectionViewCell.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
        
    }
    
    func configureUI() {
        categoryView.layer.borderWidth = 1.0
        categoryView.layer.borderColor = UIColor.blue.cgColor
        categoryView.layer.cornerRadius = 13
    }
    
    override var isSelected: Bool {
        willSet {
            super.isSelected = newValue
            if newValue {
                categoryView.backgroundColor = .yellow
            } else {
                categoryView.backgroundColor = .white
            }
        }
    }

}
