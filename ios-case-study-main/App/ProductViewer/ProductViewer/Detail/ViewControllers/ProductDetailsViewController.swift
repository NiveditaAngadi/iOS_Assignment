//
//  ProductDetailsViewController.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 18/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit
import Cartography

class ProductDetailsViewController: UIViewController, RequestDelegate, ActivityIndicatorHandler {
    private let dealImageView = UIImageView()
    private let salesPriceLabel = UILabel()
    private let regularPriceLabel = UILabel()
    private let fulfilmentLabel = UILabel()
    private let titleLabel = UILabel()
    private let availabilityLabel = UILabel()
    private let productDescriptionView = UITextView()

    var selectedProductId: Int!
    var viewModel: ProductDetailsViewModel!

    var activityIndicator = UIActivityIndicatorView()

    static func getController(selectedProductId: Int, viewModel: ProductDetailsViewModel) -> ProductDetailsViewController {
        let storyboard = UIStoryboard(name: "Product", bundle: .main)
        
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else {
            fatalError("Details controller loading error!")
        }
        detailsViewController.selectedProductId = selectedProductId
        detailsViewController.viewModel = viewModel
        
        return detailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        viewModel.delegate = self 
        if NetworkConnectionManager().hasNetworkConnectivity() {
            viewModel.fetchProductDetails(for: selectedProductId)
        } else {
            showOKDialog(title: "Connection Error!", message: "Verify internet connection")
        }
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
                self.bind(with: viewModel)
                hideActivityIndicator()
            case .error(let error):
                hideActivityIndicator()
                let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.fetchProductDetails(for: selectedProductId)
                })
                self.showDialog(title: "Error has occured!", 
                                message: error.localizedDescription,
                                actions: [tryAgainAction])
                }
            }
        }
    
    
    // MARK: - Private Methods
    
    private func setup() {
        title = "Detail"
        navigationController?.navigationBar.tintColor = .targetRed

        // Header separator
        let headerSeparator = UIView()
        view.addSubview(headerSeparator)
        headerSeparator.backgroundColor = .thinBorderGray
        let navigationBarHeight = navigationController?.navigationBar.bounds.height ?? 0.0
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        let statusBarHeight = keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        constrain(headerSeparator, view) { separator, containerView in
            separator.height == 1.0
            separator.width == containerView.width
            separator.leading == containerView.leading
            separator.trailing == containerView.trailing
            separator.top == containerView.top + navigationBarHeight + statusBarHeight
        }
        
        // deals Image
        dealImageView.contentMode = .scaleAspectFit
        dealImageView.layer.cornerRadius = 8.0
        view.addSubview(dealImageView)
        constrain(dealImageView, headerSeparator) { dealImageView, separator in
            dealImageView.height == 343.0
            dealImageView.leading == separator.leading + 16
            dealImageView.trailing == separator.trailing - 16
            dealImageView.top == separator.bottom + 16
        }
        
        // Title info
        let titleInfoStackView = UIStackView()
        titleInfoStackView.axis = .vertical
        titleInfoStackView.spacing = 2.0
        view.addSubview(titleInfoStackView)
        constrain(titleInfoStackView, dealImageView) { titleInfoView, dealImageView in
            titleInfoView.leading == dealImageView.leading
            titleInfoView.trailing == dealImageView.trailing
            titleInfoView.top == dealImageView.bottom + 28
        }
        
        titleLabel.font = .Deals.title
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        titleInfoStackView.addArrangedSubview(titleLabel)

        // Price Info
        let priceInfoHolderStackView = UIStackView()
        priceInfoHolderStackView.axis = .horizontal
        priceInfoHolderStackView.spacing = 4.0
        
        salesPriceLabel.font = .Deals.largeBold
        salesPriceLabel.textColor = .targetRed
        priceInfoHolderStackView.addArrangedSubview(salesPriceLabel)
                
        regularPriceLabel.font = .Deals.regular
        regularPriceLabel.textColor = .grayDarkest
        priceInfoHolderStackView.addArrangedSubview(regularPriceLabel)
        
        regularPriceLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        salesPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        titleInfoStackView.addArrangedSubview(priceInfoHolderStackView)

        fulfilmentLabel.font = .Deals.regular
        fulfilmentLabel.textColor = .textLightGray
        titleInfoStackView.addArrangedSubview(fulfilmentLabel)

        // Separator
        let separatorView = UIView()
        view.addSubview(separatorView)
        separatorView.backgroundColor = .thinBorderGray
        constrain(separatorView, titleInfoStackView, view) { separatorView, titleInfoStackView, containerView in
            separatorView.height == 16.0
            separatorView.top == titleInfoStackView.bottom + 12 
            separatorView.width == containerView.width
            separatorView.leading == containerView.leading
            separatorView.trailing == containerView.trailing
        }

        // Product details
        let productDetailsHolderStackView = UIStackView()
        productDetailsHolderStackView.axis = .vertical
        
        view.addSubview(productDetailsHolderStackView)
        constrain(productDetailsHolderStackView, separatorView) { detailsHolderView, separatorView in
            detailsHolderView.leading == separatorView.leading + 16
            detailsHolderView.trailing == separatorView.trailing - 16
            detailsHolderView.top == separatorView.bottom + 16
        }
        
        let productDetailsTitleLabel = UILabel()
        productDetailsTitleLabel.text = "Product details"
        productDetailsTitleLabel.font = .Deals.boldTitle
        
        productDetailsHolderStackView.addArrangedSubview(productDetailsTitleLabel)

        let descriptionContainerView = UIView()
        descriptionContainerView.backgroundColor = .yellow
        productDetailsHolderStackView.addArrangedSubview(descriptionContainerView)

        productDescriptionView.font = .Deals.copy
        productDescriptionView.textColor = .grayMedium
        productDescriptionView.isEditable = false
        productDescriptionView.isSelectable = false
        descriptionContainerView.addSubview(productDescriptionView)
        constrain(productDescriptionView, descriptionContainerView) { descriptionView, containerView in
            descriptionView.edges == containerView.edges
            descriptionView.height <= 171.0 ~ 999
        }
        
        let bottomTabHolderView = UIView()
        bottomTabHolderView.backgroundColor = .white
        bottomTabHolderView.layer.cornerRadius = 8.0
        view.addSubview(bottomTabHolderView)
        constrain(bottomTabHolderView, view, productDetailsHolderStackView) { bottomTabHolderView, containerView, detailsHolderView in
            bottomTabHolderView.leading == containerView.leading
            bottomTabHolderView.trailing == containerView.trailing
            bottomTabHolderView.bottom == containerView.bottom - 16.0
            bottomTabHolderView.top == detailsHolderView.bottom
        }
        
        let addToCartButton = UIButton()
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.titleLabel?.font = .Deals.boldTitle
        addToCartButton.titleLabel?.textColor = .white
        addToCartButton.backgroundColor = .targetRed
        addToCartButton.layer.cornerRadius = 8.0
        bottomTabHolderView.addSubview(addToCartButton)
        constrain(addToCartButton, bottomTabHolderView) { addToCartButton, holderView in
            addToCartButton.height == 44.0
            addToCartButton.width == 343.0
            addToCartButton.center == holderView.center
        }
    }
    
    private func bind(with model: ProductDetailsViewModel) {
        dealImageView.loadImage(from: model.imageUrl ?? "")
        titleLabel.text = model.title
        if let salesPrice = model.salePrice {
            salesPriceLabel.isHidden = false
            salesPriceLabel.text = salesPrice
        } else {
            salesPriceLabel.isHidden = true
        }
        
        regularPriceLabel.text = model.regularPrice
        fulfilmentLabel.text = model.fulfillment
        productDescriptionView.text = model.description
    }
}
