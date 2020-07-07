//
//  ViewController.swift
//  HWS_100DoS_Project1
//
//  Created by Jeremy Fleshman on 7/5/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    // MARK: - Properties
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // singleton for the shared file manager
        let fileManager = FileManager.default

        // path for current executables bundle's resources
        let path = Bundle.main.resourcePath!

        // shallow search (doesn't follow symb links or sub dirs)
        // returns [String] of paths found
        let items = try! fileManager.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
}


