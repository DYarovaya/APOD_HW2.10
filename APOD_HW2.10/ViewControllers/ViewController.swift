//
//  ViewController.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 25.06.2021.
//

import UIKit

class ViewController: UIViewController, RequestManagerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var labelActivityIndicator: UIActivityIndicatorView!
    var requestManager = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.delegate = self
        requestManager.fetchRequest(date: "2021-06-25")
        labelActivityIndicator.startAnimating()
        labelActivityIndicator.hidesWhenStopped = true
        imageActivityIndicator.isHidden = true
        
    }

    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("did tap image view", sender)
    }
    
    func didUpdateData(responseData: ResponseData) {
        DispatchQueue.main.async{
            print(responseData.title)
            self.titleLabel.text = responseData.title
            self.explanationLabel.text = responseData.explanation
            self.requestManager.fetchImage(url: responseData.url)
            
            self.labelActivityIndicator.stopAnimating()
            
            self.imageActivityIndicator.isHidden = false
            self.imageActivityIndicator.startAnimating()
            self.imageActivityIndicator.hidesWhenStopped = true
        }
    }
    
    func didUpdateImage(image: Data) {
        if let image = UIImage(data: image) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageActivityIndicator.stopAnimating()
                }
            }
    }
}

