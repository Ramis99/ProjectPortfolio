//
//  ProductsViewController.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import UIKit

class ProductsViewController: UIViewController {
    
    let viewModel = ProductsViewModel()
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
        registerTableView()
        fetchAllCategories()
        // Do any additional setup after loading the view.
    }
    
    private func configureUI() {
        let backButton = UIBarButtonItem()
        backButton.title = "Volver"
        navigationItem.backBarButtonItem = backButton
    }
    
    private func registerCell() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        let categoriesCell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        self.categoriesCollectionView!.register(categoriesCell, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        
    }
    private func registerTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        let productsTable = UINib(nibName: "ProductsTableViewCell" , bundle: nil)
        self.productsTableView!.register(productsTable, forCellReuseIdentifier: "ProductsTableViewCell")
    }
    
    private func fetchAllCategories() {
        if InternetConnection.shared.isConnectedToInternet() {
            viewModel.fetchCategories {[weak self] error in
                guard let self = self else { return }
                
                if error != nil {
                    print("error al consumir WS")
                } else {
                    UserDefaultsManager.saveCategories(viewModel.categories)
                    categoriesCollectionView.reloadData()
                }
            }
        } else {
            viewModel.categories = UserDefaultsManager.loadCategories()
            categoriesCollectionView.reloadData()
        }
    }
    
    private func fetchProduct() {
        if InternetConnection.shared.isConnectedToInternet() {
            viewModel.fetchProducts(for: viewModel.categorySelected!){[weak self] error in
                guard let self = self else { return }
                
                if error != nil {
                    print("error al consumir WS")
                } else {
                    productsTableView.reloadData()
                    UserDefaultsManager.saveProducts(products: viewModel.products, forCategory: viewModel.categorySelected!)
                }
            }
        } else {
            let products =  UserDefaultsManager.loadProducts(forCategory: viewModel.categorySelected ?? "")
            if products != nil {
                viewModel.products = products!
                productsTableView.reloadData()
            }
        }
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.nameCategoryLabel.text = viewModel.categories[index].name
        cell.isSelected = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.categorySelected = viewModel.categories[index].name
        fetchProduct()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selected = collectionView.indexPathsForSelectedItems
        if selected == nil || selected!.isEmpty {
            DispatchQueue.main.async { [self] in
                collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
                viewModel.categorySelected = viewModel.categories[0].name
                fetchProduct()
            }
        }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as! ProductsTableViewCell
        let index = indexPath.row
        cell.titleLabel.text = viewModel.products[index].title
        cell.rateLabel.text = "\(viewModel.products[index].rating.rate)"
        cell.priceLabel.text = "$ \(viewModel.products[index].price)"
        if let imageUrl = URL(string: viewModel.products[index].image) {
            ImageLoader.loadImage(from: imageUrl, into: cell.productImage)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let vc = DetailsProductViewController()
        vc.viewmodel.productModel = viewModel.products[index]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
