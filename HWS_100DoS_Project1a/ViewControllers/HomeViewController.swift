//
//  HomeViewController.swift
//  HWS_100DoS_Project1
//
//  Created by Jeremy Fleshman on 7/5/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    var pictures = [StormPicture]()

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    // MARK: - View methods
    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()

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

    fileprivate func configureCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ThumbnailCollectionViewCell.identifier)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }

    fileprivate func getPicturesFromAppBundle() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let strongSelf = self else { return }

            let fileManager = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fileManager.contentsOfDirectory(atPath: path)

            for item in items {
                if item.hasPrefix("nssl") {
                    if let image = UIImage(named: item) {
                        let picture = StormPicture(name: item, image: image)
                        strongSelf.pictures.append(picture)
                    }
                }
                strongSelf.pictures.sort()
            }

            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }

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

//// MARK: - TableView methods
//extension HomeViewController {
//    override func tableView(
//        _ tableView: UITableView,
//        numberOfRowsInSection section: Int
//    ) -> Int { return pictures.count }
//
//    override func tableView(
//        _ tableView: UITableView,
//        cellForRowAt indexPath: IndexPath
//    ) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: "Picture",
//            for: indexPath
//        )
//        cell.textLabel?.text = pictures[indexPath.row]
//        return cell
//    }
//
//    override func tableView(
//        _ tableView: UITableView,
//        didSelectRowAt indexPath: IndexPath
//    ) {
//        // try loading the "Detail" view controller and cast to Detail VC
//        if let viewController = storyboard?.instantiateViewController(
//            identifier: "Detail"
//            ) as? DetailViewController {
//            // if successful, set the `selectedImage` prop
//            viewController.selectedImage = pictures[indexPath.row]
//
//            let imageNumber = indexPath.row + 1
//            let imageTotal = pictures.count
//            viewController.imageNumber = imageNumber
//            viewController.imageTotal = imageTotal
//
//            // push the detail VC onto the navigation view stack
//            navigationController?.pushViewController(
//                viewController,
//                animated: true
//            )
//        }
//    }
//}

// MARK: - CollectionView Data Source methods
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.identifier, for: indexPath) as? ThumbnailCollectionViewCell else { fatalError("Failed to create CollectionView Cells") }

        cell.picture = pictures[indexPath.row]

        return cell
    }
}

// MARK: - CollectionView Delegate methods
extension HomeViewController: UICollectionViewDelegate {

}

// MARK: - CollectionView Flow Layout methods
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareSide = collectionView.frame.width / 2.1
        return CGSize(width: squareSide, height: squareSide)
    }
}
