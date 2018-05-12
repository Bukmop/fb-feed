//
//  ArticleCell.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet private var imageViewImage: UIImageView!
    @IBOutlet private var labelTitle: UILabel!
    @IBOutlet private var labelDescription: UILabel!
    @IBOutlet private var labelAuthor: UILabel!

    func update(with article: Article) {
        labelTitle.text = article.title
        labelDescription.text = article.description
        labelAuthor.text = article.author
    }

}
