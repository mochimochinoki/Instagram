//
//  PostData.swift
//  Instagram
//
//  Created by yamamoto yasuhiro on 2017/06/08.
//  Copyright © 2017年 mochimochinoki. All rights reserved.
//

//送られてきた投稿データもとに投稿データ用のクラスを作成して配列に追加
import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String] = []
//    var commenter: String?
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        self.id = snapshot.key
        let valueDictionary = snapshot.value as! [String: AnyObject]
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64Encoded: imageString!, options: .ignoreUnknownCharacters)! as Data)
        
        self.name = valueDictionary["name"] as? String
        self.caption = valueDictionary["caption"] as? String
        if let comments = valueDictionary["comments"] as? [String]{
            self.comments = comments
        }
//        self.commenter = valueDictionary["commenter"] as? String
        let time = valueDictionary["time"] as? String
        self.date = NSDate(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
    }
}
    


//        for commentId in self.comments {
//            if commentId == myId {
//                self.commented = true
//                break
//            }
//        }
