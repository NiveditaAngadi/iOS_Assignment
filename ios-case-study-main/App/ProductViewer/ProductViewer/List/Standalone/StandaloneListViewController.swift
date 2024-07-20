//
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

final class StandaloneListViewController: UIViewController {
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        item.edgeSpacing = .init(
            leading: nil,
            top: .fixed(8),
            trailing: nil,
            bottom: .fixed(8)
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(
            group: group
        )
        
        let layout = UICollectionViewCompositionalLayout(
            section: section
        )
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.backgroundColor = UIColor.background
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            StandaloneListItemViewCell.self,
            forCellWithReuseIdentifier: StandaloneListItemViewCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    private var sections: [ListSection] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)

        collectionView.contentInset = UIEdgeInsets(
            top: 20.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0
        )
        
        title = "checkout"
        
        view.addAndPinSubview(collectionView)
        
        sections = [
            ListSection(
                index: 1,
                items: (1..<10).map { index in
                    ListItem(
                        title: "Puppies!!!",
                        price: "$9.99",
                        image: UIImage(named: "\(index)"),
                        index: index
                    )
                }
            ),
        ]
    }
}

extension StandaloneListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard
            sections.indices.contains(indexPath.section),
            sections[indexPath.section].items.indices.contains(indexPath.row)
        else {
            return
        }
        
        let productListItem = sections[indexPath.section].items[indexPath.row]
        
        let alert = UIAlertController(
            title: "Item \(productListItem.index) selected!",
            message: "🐶",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        
        present(alert, animated: true, completion: nil)
    }
}

extension StandaloneListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard
            sections.indices.contains(section)
        else {
            return 0
        }
        
        return sections[section].items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            sections.indices.contains(indexPath.section),
            sections[indexPath.section].items.indices.contains(indexPath.row),
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StandaloneListItemViewCell.reuseIdentifier,
                for: indexPath
            ) as? StandaloneListItemViewCell
        else {
            return UICollectionViewCell()
        }
        
        let listItem = sections[indexPath.section].items[indexPath.row]
        
        cell.listItemView.configure(for: listItem)
        
        return cell
    }
}

private extension StandaloneListItemView {
    func configure(for listItem: ListItem) {
        titleLabel.text = listItem.title
        priceLabel.text = listItem.price
        productImage.image = listItem.image
    }
}
