//
//  CommentNewsController.swift
//  LittleSocialMedia
//
//  Created by Olga Lidman on 30/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import RealmSwift

class CommentNewsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentsTableView: UITableView!
    var token: NotificationToken?
//    var comments : Results<Comment>?
    var commentsToShow = [Comment]()
    var postToShow : NewsPost!
    var currentUser : User!
    let service = Service()
    let newsVC = MyProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 5
        commentTextView.layer.borderColor = #colorLiteral(red: 0.2392156863, green: 0.6470588235, blue: 0.4980392157, alpha: 1)
        commentTextView.layer.borderWidth = 0.4
        
//        Получение данных текущего пользователя из базы Realm
        guard let user = service.loadUserDataFromRLM().first else { return }
        currentUser = user
        
        commentsToShow = postToShow.comments
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        commentsTableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsToShow.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
//            Новость
            let newCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            let newPost = postToShow!
            newCell.authorLabel.text = newPost.author?.authorName
            newCell.timeLabel.text = self.service.getTimeFromUNIXTime(date: newPost.time)
            newCell.avatarView.photoView.downloaded(from: newPost.author!.authorPicURL)
            newCell.contentLabel.text = newPost.content
            newCell.viewsCountLabel.text = "\(newPost.viewsCount)"
//          Content Image
            if newPost.contentPicURL != "" {
                newCell.contentImageView.downloaded(from: newPost.contentPicURL)
            } else if newPost.contentDocUrl != "" {
                newCell.contentImageView.downloaded(from: newPost.contentDocUrl)
            } else if newPost.contentVideoURL != "" {
                newCell.contentImageView.downloaded(from: newPost.contentVideoURL)
            } else if newPost.contentLinkURL != ""{
                newCell.contentImageView.downloaded(from: newPost.contentLinkURL)
            } else {
                newCell.contentImageView.image = #imageLiteral(resourceName: "kosmos")
            }
//          Like
            newCell.likeShareControlView.likeCountLabel.text = "\(newPost.likesCount)"
            if newPost.didLike == 0 {
                newCell.likeShareControlView.likeImage.image = UIImage(named: "dislike")
            } else {
                newCell.likeShareControlView.likeImage.image = UIImage(named: "like")
                newCell.likeShareControlView.likeCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            }
//          Share
            newCell.likeShareControlView.shareCountLabel.text = "\(newPost.sharesCount)"
            if newPost.didShare == 0 {
                newCell.likeShareControlView.shareImage.image = UIImage(named: "unshare")
            } else {
                newCell.likeShareControlView.shareImage.image = UIImage(named: "share")
                newCell.likeShareControlView.shareCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            }
            newCell.likeShareControlView.onTapLike = {
                self.newsVC.likeOnNewsPost(newCell.likeShareControlView, newPost)
            }
            newCell.likeShareControlView.onTapShare = {
                self.newsVC.shareOnNewsPost(newCell.likeShareControlView, newPost)
            }
            return newCell
        }
        else {
//            Комментарии к новости
            let comment = commentsToShow[indexPath.row - 1]
            let commCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            commCell.authorNameLabel.text = comment.authorName
            commCell.authorAvatarView.photoView.downloaded(from: comment.authorPicURL)
            commCell.timeLabel.text = comment.time
            commCell.commentLabel.text = comment.text
            return commCell
        }
    }
    
//    Отправка коммента по нажатию на кнопку
    @IBAction func sendComment(_ sender: Any) {
        guard commentTextView.text != "",
        let commentText = commentTextView.text else { return }
        let comment = Comment()
        comment.authorName = currentUser.userFirstName + " " + currentUser.userLastName
        comment.authorPicURL = currentUser.avaURL
        comment.time = service.getTodayString()
        comment.text = commentText
        comment.post = postToShow.content
        postToShow.comments.append(comment)
        commentsToShow.append(comment)
        commentsTableView.reloadData()
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(comment)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        commentTextView.text = nil
    }
    
//    Скрытие клавиатуры
    @objc func hideKeyboard() {
        commentsTableView?.endEditing(true)
    }
}
