//
//  LoadingFooterView.swift
//  fb-feed
//
//  Created by Viktor Smidl on 13/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

class LoadingFooterView: UITableViewHeaderFooterView {

    enum State {

        case readyToLoad
        case loading
        case nothingToLoad
        
    }

    static let identifier = String(describing: LoadingFooterView.self)

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var noMoreContentLabel: UILabel!

}

extension LoadingFooterView {

    func update(with state: State) {
        switch state {
        case .readyToLoad:
            activityIndicator.isHidden = false
            activityIndicator.stopAnimating()
            noMoreContentLabel.isHidden = true

        case .loading:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            noMoreContentLabel.isHidden = true

        case .nothingToLoad:
            activityIndicator.isHidden = true
            noMoreContentLabel.isHidden = false
        }
    }

}
