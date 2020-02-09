//
//  DetailViewController.swift
//  Project1T
//
//  Created by Curtis Colly on 2/9/20.
//  Copyright © 2020 Snaap. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedImage: String?
    let imageView = UIImageView()
    
    override func loadView() {
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        view = imageView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

       
    }
    
    

}

