//
//  ViewController.swift
//  GenerateBarcode
//
//  Created by Gene Backlin on 3/11/21.
//

import UIKit

enum Descriptor: String {
    case code128 = "CICode128BarcodeGenerator"
    case pdf417 = "CIPDF417BarcodeGenerator"
    case aztec = "CIAztecCodeGenerator"
    case qr = "CIQRCodeGenerator"
}

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var entryTextField: UITextField!
    
    var selectedIndex: Descriptor = .code128
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let text = entryTextField.text {
            updateBarcodeImage(text: text, type: self.selectedIndex)
        }
    }
    @IBAction func selectBarcodeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedIndex = .code128
        case 1:
            self.selectedIndex = .pdf417
        case 2:
            self.selectedIndex = .aztec
        case 3:
            self.selectedIndex = .qr
        default:
            self.selectedIndex = .code128
        }
        if let text = entryTextField.text {
            updateBarcodeImage(text: text, type: self.selectedIndex)
        }
    }
    
    @IBAction func createBarcode(_ sender: Any) {
        if let text = entryTextField.text {
            updateBarcodeImage(text: text, type: self.selectedIndex)
        }
    }
    
    func updateBarcodeImage(text: String, type: Descriptor) {
        imageView.image = UIImage(barcode: text, type: type.rawValue)
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showBarcode" {
            let controller: DetailViewController = segue.destination as! DetailViewController
            controller.image = imageView.image
        }
    }


}

extension UIImage {
    convenience init(barcode: String, type: String) {
        let data = barcode.data(using: .ascii)
        
        if let filter = CIFilter(name: type) {
            //filter.setDefaults()
            filter.setValue(data, forKey: "inputMessage")
            if let ciImage = filter.outputImage {
                self.init(ciImage: ciImage)
                return
            }
        }
        self.init()
    }
}
