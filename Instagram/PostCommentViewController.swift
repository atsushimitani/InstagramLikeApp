//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by 三谷淳史 on 2018/11/24.
//  Copyright © 2018年 atsushi.mitani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostCommentViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var postData: PostData!
    
    @IBAction func handlePostButton(_ sender: Any) {
        if textField.text == "" {
            SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
            return
        }
        
        // postDataに必要な情報を取得しておく
        let name = Auth.auth().currentUser?.displayName
        
        // 新しいコメントをcomments配列に追加
        let newComment = ["comment": textField.text!, "name": name!]
        postData.comments.append(newComment)
        
        // commentsをFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        let comments = ["comments": postData.comments]
        postRef.updateChildValues(comments)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
