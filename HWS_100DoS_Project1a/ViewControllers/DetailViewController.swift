//
//  DetailViewController.swift
//  HWS_100DoS_Project1
//
//  Created by Jeremy Fleshman on 7/8/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // Paul states on day 17, P2 that there is no difference between `weak` and `strong` for @IBOutlet
    // Is Apple's recommendation still to have outlets declared with `strong`?
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imageNumber: Int?
    var imageTotal: Int?

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
        // get image.imageview and scale jpeg at 0.8
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found")
            return
        }

        let imageTitle = selectedImage ?? "StormImage\(imageNumber ?? 0).jpg"

        // call UIActivityViewController
        //        #warning("TODO: Add string name to share item")
        // TODO: Add string name to share item
        /*
            - How do i add a string title to `activityItems: [Data]`?
                - can add the
         */
        let vc = UIActivityViewController(
            activityItems: [imageTitle, image],
            applicationActivities: nil
        )

        // iPad compatibility
        vc.popoverPresentationController?.barButtonItem =
            navigationItem.rightBarButtonItem

        // present vc
        present(vc, animated: true)
    }
}
