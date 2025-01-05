//
//  HamburgerVC.swift
//  ActionsTests
//
//  Created by Abdusalom on 05/01/2025.
//

import UIKit

class HamburgerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        let container = UIView()
        
        container.backgroundColor = .green
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.heightAnchor.constraint(equalToConstant: 200),
            container.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    


}
