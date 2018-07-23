//
//  ImageView.swift
//  188app
//
//  Created by Mac on 02/12/17.
//  Copyright © 2017 Megaleios. All rights reserved.
//

import UIKit
import Cartography

let imageCache = NSCache<NSString, UIImage>()

class ImageView: UIImageView {
    
    @IBInspectable open var borderWith : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable open var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable open var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    var activityIndicator = UIActivityIndicatorView()
    var imageUrlString: String?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        initViews()
        setupConstraints()
    }
    
    func initViews() {
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.activityIndicator.hidesWhenStopped = true
        
        self.addSubview(self.activityIndicator)
    }
    
    func setupConstraints() {
        constrain(activityIndicator, self) { indicator, view in
            indicator.center == view.center
        }
    }
    
    func loadAndCacheImage(from urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            return
        }
        imageUrlString = urlString
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            completion?()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let er = error {
                print(er)
                return
            }
            
            DispatchQueue.main.async {
                if let da = data, let imageToCache = UIImage(data: da) {
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                    completion?()
                }
            }
        }).resume()
    }

}
