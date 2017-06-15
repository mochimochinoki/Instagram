//
//  CommentsViewController.swift
//  Instagram
//
//  Created by yamamoto yasuhiro on 2017/06/10.
//  Copyright © 2017年 mochimochinoki. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase
import UIKit
import SVProgressHUD

class CommentsViewController: UIViewController{

    var postData: PostData!
    
    @IBOutlet weak var commentText: UITextField!

    @IBAction func sendComment(_ sender: Any) {
        let commenter = FIRAuth.auth()?.currentUser?.displayName
        // 辞書を作成してFirebaseに保存する
        let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id!)
        postData.comments.append("\(commenter!) : \(commentText.text!)")
        let comments = ["comments": postData.comments]
        postRef.updateChildValues(comments)

                if commentText.text != nil{
                    // HUDでコメント完了を表示する
                    SVProgressHUD.showSuccess(withStatus: "コメントしました")
                    dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancel(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
