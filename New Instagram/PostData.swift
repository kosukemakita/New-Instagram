//
//  PostData.swift
//  New Instagram
//
//  Created by 蒔田幸祐 on 2020/11/03.
//  Copyright © 2020 kousuke.makita. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
//    var comment: String?
    var comment: [String] = []
    var isCommented: Bool = false

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

//        self.comment = postDic["comment"] as? String
        if let comment = postDic["comment"] as? [String] {
            self.comment = comment
        }
        print("postDic[comment]=",postDic["comment"])
        print("self.comment=",self.comment)
        
        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        
//        if let myid = Auth.auth().currentUser?.uid {
//            if self.likes.firstIndex(of: myid) != niil {
//                self.isCommented = true 
//            }
//        }
    }
}
