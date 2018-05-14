//
//  ArticleCell.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit
import Kingfisher
import FBAudienceNetwork

class FeedItemCell: UITableViewCell {

    @IBOutlet private var imageViewImage: UIImageView!
    @IBOutlet private var fbMediaView: FBMediaView!
    @IBOutlet private var labelTitle: UILabel!
    @IBOutlet private var labelDescription: UILabel!
    @IBOutlet private var labelAuthor: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageViewImage.kf.cancelDownloadTask()
        imageViewImage.image = nil
    }

}

extension FeedItemCell {
    
    func update(with item: FeedItem) {
        labelTitle.text = item.title
        labelDescription.text = item.subtitle
        labelAuthor.text = item.author
        
        if let imageUrl = item.urlToImage,
            let url = URL(string: imageUrl) {
            imageViewImage.kf.setImage(with: url)
        }

        if let adItem = item as? Ad {
            fbMediaView.nativeAd = adItem.fbNativeAd
            fbMediaView.isHidden = false
        } else {
            fbMediaView.isHidden = true
        }
    }

}
