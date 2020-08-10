//
//  DetailViewController.swift
//  HWS_100DoS_Project1
//
//  Created by Jeremy Fleshman on 7/8/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    var selectedImage: String?
    var imageNumber: Int?
    var imageTotal: Int?

    override func loadView() {
        super.loadView()

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageNumber = imageNumber, let imageTotal = imageTotal {
            title = "Picture \(imageNumber) of \(imageTotal)"
        } else {
            title = selectedImage
        }
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped)
        )

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found")
            return
        }

        let imageTitle = selectedImage ?? "StormImage\(imageNumber ?? 0).jpg"

        let vc = UIActivityViewController(
            activityItems: [imageTitle, image],
            applicationActivities: nil
        )

        // iPad compatibility
        vc.popoverPresentationController?.barButtonItem =
            navigationItem.rightBarButtonItem

        present(vc, animated: true)
    }
}
