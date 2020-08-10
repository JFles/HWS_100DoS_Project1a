//
//  StormPicture.swift
//  HWS_100DoS_Project1a
//
//  Created by Jeremy Fleshman on 8/10/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

struct StormPicture: Comparable {
    static func < (lhs: StormPicture, rhs: StormPicture) -> Bool {
        return lhs.name < rhs.name
    }

    var name: String
    var image: UIImage
}
