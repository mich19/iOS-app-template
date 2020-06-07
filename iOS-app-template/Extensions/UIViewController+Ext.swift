//
//  UIViewController+Ext.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 06/06/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Shows an animated loader indicator with overlay
    func showSpinner() {
        let overlay: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            view.tag = .spinnerTag
            return view
        }()
        
        let spinner: Spinner = {
            let spinner = Spinner()
            spinner.translatesAutoresizingMaskIntoConstraints = false
            return spinner
        }()
        
        DispatchQueue.main.async {
            overlay.addSubview(spinner)
            self.view.addSubview(overlay)
            
            NSLayoutConstraint.activate([
                // Overlay Constraints
                overlay.topAnchor.constraint(equalTo: self.view.topAnchor),
                overlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                overlay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                overlay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                // Spinner View Constraints
                spinner.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
                spinner.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
                spinner.widthAnchor.constraint(equalToConstant: 70),
                spinner.heightAnchor.constraint(equalTo: spinner.widthAnchor, multiplier: 1.0)
            ])
        }
    }
    
    /// Remove loader indecator form the current view
    func hideSinner() {
        guard let overlay = view.viewWithTag(.spinnerTag) else { return }
        DispatchQueue.main.async {
            overlay.removeFromSuperview()
        }
    }
    
}
