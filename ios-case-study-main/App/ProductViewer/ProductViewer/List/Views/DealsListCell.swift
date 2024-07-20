//
//  DealsListCell.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 18/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit
import Cartography

class DealsListCell: UITableViewCell {
    private let dealImageView = UIImageView()
    private let salesPriceLabel = UILabel()
    private let regularPriceLabel = UILabel()
    private let fulfilmentLabel = UILabel()
    private let titleLabel = UILabel()
    private let availabilityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func bind(to model: ProductViewModel) {
        dealImageView.loadImage(from: model.imageUrl ?? "")
        if let salesPrice = model.salePrice {
            salesPriceLabel.isHidden = false
            salesPriceLabel.text = salesPrice
        } else {
            salesPriceLabel.isHidden = true
        }
        regularPriceLabel.text = model.regularPrice
        
        fulfilmentLabel.text = model.fulfillment
        titleLabel.text = model.title
        
        if let availability = model.availability {
            let availabilityString = NSMutableAttributedString()
            let availabilityAttribute: [NSAttributedString.Key: Any] = [
                .font: UIFont.Deals.regular,
                .foregroundColor: UIColor.targetTextGreen]
            let availabilityAttributedString = NSAttributedString(string: availability, attributes: availabilityAttribute)
            
            let aisleAttribute: [NSAttributedString.Key: Any] = [
                .font: UIFont.Deals.regular,
                .foregroundColor: UIColor.lightGray]
            let aisleAttributedString = NSAttributedString(string: model.aisle, attributes: aisleAttribute)
            
            availabilityString.append(availabilityAttributedString)
            availabilityString.append(aisleAttributedString)
            availabilityLabel.attributedText = availabilityString
        }
    }
    
    private func setup() {
        // Design of the UI
        // ContentView -> H.StackView
        //             -> ImageView + V.StackView
        //                           -> H.StackView -> SalesPriceLabel + RegularPriceLabel
        //                           -> FulfilmentLabel
        //                           -> TitleLabel
        //                           -> AvailabilityLabel
        
        
        let contentHolderStackView = UIStackView()
        contentHolderStackView.axis = .horizontal
        contentHolderStackView.spacing = 16.0
        contentView.addSubview(contentHolderStackView)
        constrain(contentHolderStackView, contentView) { stackView, containerView in
            stackView.edges == containerView.edges.inseted(by: 16.0)
            stackView.centerX == containerView.centerX
        }
        
        contentHolderStackView.addArrangedSubview(dealImageView)
        constrain(dealImageView) { dealImageView in
            dealImageView.width == 140.0
            dealImageView.height == 140.0 ~ 999
        }
        dealImageView.layer.cornerRadius = 8.0
        dealImageView.contentMode = .scaleAspectFit
        
        let informationHolderStackView = UIStackView()
        informationHolderStackView.axis = .vertical

        contentHolderStackView.addArrangedSubview(informationHolderStackView)
        
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
        
        informationHolderStackView.addArrangedSubview(priceInfoHolderStackView)
        informationHolderStackView.setCustomSpacing(0.0, after: priceInfoHolderStackView)
        
        fulfilmentLabel.font = .Deals.regular
        fulfilmentLabel.textColor = .textLightGray
        informationHolderStackView.addArrangedSubview(fulfilmentLabel)
        informationHolderStackView.setCustomSpacing(4.0, after: fulfilmentLabel)
        
        let productInfoView = UIView()
        informationHolderStackView.addArrangedSubview(productInfoView)

        titleLabel.font = .Deals.medium
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 3
        productInfoView.addSubview(titleLabel)
        constrain(titleLabel, productInfoView) { titleLabel, productInfoView in
            titleLabel.top == productInfoView.top
            titleLabel.leading == productInfoView.leading
            titleLabel.trailing == productInfoView.trailing
        }
        

        availabilityLabel.font = .Deals.regular
        availabilityLabel.textColor = .darkGray
        productInfoView.addSubview(availabilityLabel)
        constrain(availabilityLabel, titleLabel) { availabilityLabel, titleLabel in
            availabilityLabel.top == titleLabel.bottom + 4.0
            availabilityLabel.leading == titleLabel.leading
            availabilityLabel.trailing == titleLabel.trailing
        }
    }
    
}
