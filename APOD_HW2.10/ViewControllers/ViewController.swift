//
//  ViewController.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 25.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var calendar: UIDatePicker! {
        didSet {
            calendar.maximumDate = date
        }
    }
    
    var requestManager = RequestManager()
    let customDateFormatter = CustomDateFormatter()
    
    var date = Date()
    var imageHDUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.mainRequestManagerDelegate = self
        requestManager.imageRequestManagerDelegate = self
        //стоило создать переменную для даты, которую я получила в формате String?
        requestManager.fetchMainRequest(date: customDateFormatter.formatDate(date: date))
        
        labelActivityIndicator.startAnimating()
        labelActivityIndicator.hidesWhenStopped = true
        imageActivityIndicator.isHidden = true
        
    }

//    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
//        print("did tap image view", sender)
//    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        requestManager.fetchMainRequest(date: customDateFormatter.formatDate(date: sender.date))
        labelActivityIndicator.startAnimating()
        labelActivityIndicator.hidesWhenStopped = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToFullImageScreen" else {
            return
        }
        let vc = segue.destination as! FullImageViewController
        vc.imageUrl = imageHDUrl
    }
}

extension ViewController: MainRequestManagerDelegate {
    func didUpdateData(responseData: ResponseData) {
        DispatchQueue.main.async{
            self.titleLabel.text = responseData.title
            self.explanationLabel.text = responseData.explanation
            self.imageHDUrl = responseData.hdurl
            self.requestManager.fetchImage(url: responseData.url)
            
            
            self.labelActivityIndicator.stopAnimating()
            
            self.imageActivityIndicator.isHidden = false
            self.imageActivityIndicator.startAnimating()
            self.imageActivityIndicator.hidesWhenStopped = true
        }
    }
}

extension ViewController: ImageRequestManagerDelegate {
    func didUpdateImage(image: Data) {
        if let image = UIImage(data: image) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageActivityIndicator.stopAnimating()
                }
            }
    }
}
