//
//  CollectionViewCell.swift
//  HWS_100DoS_Project1a
//
//  Created by Jeremy Fleshman on 8/8/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    static var identifier = "Cell"

    weak var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor)
        ])
        self.textLabel = textLabel
        self.reset()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    func reset() {
        self.textLabel.textAlignment = .center
    }
}
