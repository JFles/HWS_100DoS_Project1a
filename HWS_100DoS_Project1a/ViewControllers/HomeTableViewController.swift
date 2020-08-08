//
//  HomeTableViewController.swift
//  HWS_100DoS_Project1
//
//  Created by Jeremy Fleshman on 7/5/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    // MARK: - Properties
    var pictures = [String]()

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Share",
            style: .plain,
            target: self,
            action: #selector(shareApp)
        )

        getPicturesFromAppBundle()
    }

    fileprivate func getPicturesFromAppBundle() {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }

            let fileManager = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fileManager.contentsOfDirectory(atPath: path)

            for item in items {
                if item.hasPrefix("nssl") { strongSelf.pictures.append(item) }
                // Sort array ascending
                strongSelf.pictures.sort()
            }
        }
    }

    /// Challenge 2 - https://www.hackingwithswift.com/read/3/3/wrap-up
    @objc func shareApp() {
        let appUrl = URL(
            string: "https://www.hackingwithswift.com/read/3/3/wrap-up"
        )!

        let activityController = UIActivityViewController(
            activityItems: [appUrl],
            applicationActivities: nil
        )

        present(activityController, animated: true)
    }
}

// MARK: - TableView methods
extension HomeTableViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { return pictures.count }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Picture",
            for: indexPath
        )
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // try loading the "Detail" view controller and cast to Detail VC
        if let viewController = storyboard?.instantiateViewController(
            identifier: "Detail"
            ) as? DetailViewController {
            // if successful, set the `selectedImage` prop
            viewController.selectedImage = pictures[indexPath.row]

            let imageNumber = indexPath.row + 1
            let imageTotal = pictures.count
            viewController.imageNumber = imageNumber
            viewController.imageTotal = imageTotal

            // push the detail VC onto the navigation view stack
            navigationController?.pushViewController(
                viewController,
                animated: true
            )
        }
    }
}