//
//  CommentViewController.swift
//  New Instagram
//
//  Created by 蒔田幸祐 on 2020/11/05.
//  Copyright © 2020 kousuke.makita. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    // 更新データを作成する
    var postData: PostData!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var commenterNameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func handleCancelButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    //    var comment = textField.text!
    @IBAction func handleCommentButton(_ sender: Any) {
        
        let comment = textField.text!
        // 更新データを作成する
        var updateValue: FieldValue
        
        updateValue = FieldValue.arrayUnion([comment])
        
        // 更新データを書き込む
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
//        postRef.updateData(["comment": updateValue])
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // FireStoreに投稿データを保存する
//        let name = Auth.auth().currentUser?.displayName
        postRef.updateData(["comment": updateValue])
        
        
        //メモ：　明日はfirebaseが問題なく連携されているかも確認
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 先頭画面(TabBarController)に戻るメソッド
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}


