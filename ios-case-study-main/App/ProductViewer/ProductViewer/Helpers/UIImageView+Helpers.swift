//
//  UIImageView+Helpers.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 18/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from urlString: String,
                   fallbackUrlString: String? = nil,
                   placeHolderImage: UIImage? = nil,
                   onFailureImage: UIImage? = nil,
                   activityIndicator: IndicatorType = .none,
                   renderingMode: UIImage.RenderingMode? = .alwaysOriginal) {
        
        var alternativeSource = [Source]()
        if let validFallbackUrl = fallbackUrlString, let url = URL(string: validFallbackUrl) {
            alternativeSource.append(.network(url))
        }
        
        kf.indicatorType = activityIndicator
        kf.setImage(with: URL(string: urlString),
                    options: [.onFailureImage(onFailureImage ?? placeHolderImage),
                              .alternativeSources(alternativeSource),
                              .diskCacheExpiration(.days(30))],
                    completionHandler: { result in
            switch result {
            case let .success(retrieveResult):
                let image = retrieveResult.image.withRenderingMode(renderingMode ?? .alwaysOriginal)
                self.image = image
            case let .failure(error):
                self.image = placeHolderImage
                print("Error occurred while loading an image = \(error)")
            }
        })
    }
}
