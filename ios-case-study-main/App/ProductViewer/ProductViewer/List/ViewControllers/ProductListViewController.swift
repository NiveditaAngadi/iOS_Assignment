//
//  ProductListViewController.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 18/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RequestDelegate, ActivityIndicatorHandler {
    @IBOutlet weak var dealsTableView: UITableView!
    
    private let viewModel = ProductListViewModel()
    
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel.delegate = self
        
        if NetworkConnectionManager().hasNetworkConnectivity() {
            viewModel.fetchProducts()
        } else {
            showOKDialog(title: "Connection Error!", message: "Verify internet connection")
        }
    }
    
    // MARK: -  UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DealsListCell = tableView.dequeueReusableCell(withIdentifier: "DealsListCell")! as! DealsListCell
        let productViewModel = viewModel.getProductViewModel(for: indexPath)
        cell.bind(to: productViewModel)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedProduct = viewModel.getProduct(for: indexPath)
        
        let detailsViewModel = ProductDetailsViewModel.init(selectedProduct: selectedProduct)
        
        let detailsViewController = ProductDetailsViewController.getController(selectedProductId: selectedProduct.id, viewModel: detailsViewModel)
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    // MARK: - Request Delegate Methods
    
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self  else { return }
            switch state {
            case .idle:
                break
            case .loading:
                showActivityIndicator()
            case .success:
                self.dealsTableView.reloadData()
                hideActivityIndicator()
            case .error(let error):
                hideActivityIndicator()
                let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.fetchProducts()
                })
                self.showDialog(title: "Error has occured!",
                                message: error.localizedDescription,
                                actions: [tryAgainAction])
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        title = "List"

        dealsTableView.delegate = self
        dealsTableView.dataSource = self
        
        dealsTableView.register(DealsListCell.self, forCellReuseIdentifier: "DealsListCell")
        dealsTableView.rowHeight = UITableView.automaticDimension
        dealsTableView.estimatedRowHeight = 320.0
        
        dealsTableView.tableFooterView = UIView(frame: .zero)
    }
}
