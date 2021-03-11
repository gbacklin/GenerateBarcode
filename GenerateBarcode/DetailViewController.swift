//
//  DetailViewController.swift
//  GenerateBarcode
//
//  Created by Gene Backlin on 3/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let barcodeImage = image {
            imageView.image = barcodeImage
        }
    }
}
