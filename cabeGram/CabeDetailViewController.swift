//
//  CabeDetailViewController.swift
//  cabeGram
//
//  Created by Harrie Santoso on 26/09/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class CabeDetailViewController: UIViewController {

    var cabe: Cabe = Cabe(name: "",
                          imageURLS: [])
    
    private var container = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        snitch()
        view.autoresizingMask = .flexibleHeight
    }
    
    private func snitch() {
        snitchContainer()
    }
    
    private func snitchContainer() {
        
        let navBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        container.frame = view.frame
        container.contentSize = CGSize(width: container.frame.width * CGFloat(cabe.imageURLS.count),
                                       height: container.frame.height - navBarHeight - 40)
        container.isScrollEnabled = true
        container.isPagingEnabled = true
        
        for (index, imageURL) in cabe.imageURLS.enumerated() {
            let xPosition: CGFloat = container.frame.size.width * CGFloat(index)
            
            let name: UILabel = UILabel(frame: CGRect(x: 20 + xPosition,
                                                      y: 20,
                                                      width: 300,
                                                      height: 30))
            name.text = cabe.name
            
            let imageView: UIImageView = UIImageView()
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: container.frame.width,
                                     height: container.frame.height)
            
            imageView.downloaded(from: imageURL)
            
            container.addSubview(imageView)
            container.addSubview(name)
        }
        
        
        view.addSubview(container)
    }
}
