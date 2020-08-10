//
//  ThumbnailCollectionViewCell.swift
//  HWS_100DoS_Project1a
//
//  Created by Jeremy Fleshman on 8/8/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

// https://medium.com/@max.codes/programmatic-custom-collectionview-cell-subclass-in-swift-5-xcode-10-291f8d41fdb1

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    static var identifier = "ThumbnailCollectionViewCell"

    var picture: StormPicture? {
        didSet {
            guard let picture = picture else { return }
            backgroundImage.image = picture.image
        }
    }

    fileprivate let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.contentView.addSubview(backgroundImage)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            backgroundImage.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            backgroundImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            backgroundImage.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
}
