//
//  PostTableViewCell.swift
//  ObjC
//
//  Created by Deniz Tutuncu on 2/13/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var upsLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var post: DSTPost? {
        didSet {
            updateViews()
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else { return }
        authorLabel.text = post.author
        titleLabel.text = post.title
        likeCountLabel.text = "\(post.commentsCount) 💬"
        upsLabel.text = "\(post.ups) ♥️"
        thumbnailImageView.image = thumbnail
    }
}
