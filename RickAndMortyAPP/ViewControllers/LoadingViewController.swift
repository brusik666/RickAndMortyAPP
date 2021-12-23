//
//  LoadingViewController.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 26.11.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .medium
        activityIndicator.color = .myGreen
        
        activityIndicator.startAnimating()
        
        activityIndicator.autoresizingMask = [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
        
        return activityIndicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let bluerEffectView = UIVisualEffectView(effect: blurEffect)
        
        bluerEffectView.alpha = 0.1
        bluerEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return bluerEffectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        
        loadingActivityIndicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(loadingActivityIndicator)

    }
    


}
