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

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

}
