//
//  ImageDetailViewController.swift
//  TestAVFoundation
//
//  Created by Kosuke Nishimura on 2019/05/19.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var imageDetailView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        imageDetailView = UIImageView(frame: self.view.bounds)
        imageDetailView.backgroundColor = .black
        imageDetailView.contentMode = .scaleAspectFit
        self.view.addSubview(imageDetailView)
    }

}
