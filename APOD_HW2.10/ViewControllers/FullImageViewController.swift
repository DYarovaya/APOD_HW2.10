//
//  FullImageViewController.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 25.06.2021.
//

import UIKit

class FullImageViewController: UIViewController,  RequestImageManagerDelegate {

    var requestManager = RequestManager()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.requestImageManagerDelegate = self
        if let imageUrl = imageUrl {
            requestManager.fetchImage(url: imageUrl)
        }

        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    @IBAction func tappedCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didUpdateImage(image: Data) {
        if let image = UIImage(data: image) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
    }


    
}
