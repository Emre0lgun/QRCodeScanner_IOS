//
//  FirstViewController.swift
//  QR Codes
//
//  Created by Kyle Howells on 31/12/2019.
//  Copyright © 2019 Kyle Howells. All rights reserved.
//

import UIKit
import CoreImage

class GeneratorViewController: UIViewController, UITextViewDelegate {
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        UIApplication.shared.isIdleTimerDisabled = false
		
		refreshQRCode()
	}
	
	
	func refreshQRCode() {
		//let text:String = self.textView.text
		
		// Generate the image
		guard let qrCode:CIImage = createQRCodeForString("Emre OLGUN") else {
			print("Failed to generate QRCode")
			self.imageView.image = nil
			return
		}
		
		// Rescale to fit the view (otherwise it is only something like 100px)
		let viewWidth = self.imageView.bounds.size.width;
        print(viewWidth)
		let scale = viewWidth/qrCode.extent.size.width;
        print(scale)
		let scaledImage = qrCode.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
		
		// Display
		self.imageView.image = UIImage(ciImage: scaledImage)
	}
	func createQRCodeForString(_ text: String) -> CIImage?{
		let data = text.data(using: .isoLatin1)
		
		let qrFilter = CIFilter(name: "CIQRCodeGenerator")
		// Input text
		qrFilter?.setValue(data, forKey: "inputMessage")
		// Error correction
		/*let values = ["L", "M", "Q", "H"]
		// Trick to limit the result to the bounds (0, array.maxIndex) - max(_MIN_, min(_value_, _MAX_))
		let index = max(0, min(correctionLevelSegmentControl.selectedSegmentIndex, (values.count-1)))
		let correctionLevel = values[index]
		qrFilter?.setValue(correctionLevel, forKey: "inputCorrectionLevel")*/
		
		return qrFilter?.outputImage
	}
}

