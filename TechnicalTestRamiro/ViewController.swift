//
//  ViewController.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        continueBtn.layer.cornerRadius = 13
    }

    @IBAction func continueActionBtn(_ sender: Any) {
        let vc = ProductsViewController(nibName: "ProductsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

