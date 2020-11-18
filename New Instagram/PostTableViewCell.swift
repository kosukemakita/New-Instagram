//
//  PostTableViewCell.swift
//  New Instagram
//
//  Created by 蒔田幸祐 on 2020/11/03.
//  Copyright © 2020 kousuke.makita. All rights reserved.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        print("DEBUG_PRINT_NAME: \(postData.name!)")
        print("DEBUG_PRINT_CAPTION: \(postData.caption!)")
        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        // コメントの表示
//        self.commentLabel.text = "\(postData.name!) : \(postData.comment!)"
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        //コメントの表示
        let commentText = postData.comment
//        print("DEBUG_PRINT_COMMENT: \(commentText ?? "comment is nil")")
//        
//        for commentText in foo {
//            print(commentText)
//        }
        
        
        commentLabel.text = "\(commentText)"
//        self.commentLabel.text = commentText  
    
        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
}
