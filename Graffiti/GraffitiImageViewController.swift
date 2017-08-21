//
//  GraffitiImageViewController.swift
//  Graffiti
//
//  Created by Rafael Navarro on 24/3/17.
//  Copyright © 2017 Rafael Navarro. All rights reserved.
//

import UIKit

class GraffitiImageViewController: UIViewController {

    @IBOutlet weak var graffitiImage: UIImageView!
    var selectedCallout : UIImage?
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedCallout = selectedCallout {
            graffitiImage.image = selectedCallout
        }
    }

  
}
