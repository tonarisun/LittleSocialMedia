//
//  CommentNewsController.swift
//  LittleSocialMedia
//
//  Created by Olga Lidman on 30/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CommentNewsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var avatarView: Avatar!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var likeShareControl: LikeShareControl!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentTableView: UITableView!
    var comments = [String]()
    var postToShow : NewsPost!
    let service = Service()
    let newsVC = MyProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Отображение новости
        avatarView.photoView.downloaded(from: postToShow.author!.authorPicURL)
        authorLabel.text = postToShow.author!.authorName
        timeLabel.text = service.getTimeFromUNIXTime(date: postToShow.time)
        contentLabel.text = postToShow.content
        if postToShow.contentPicURL != "" {
            contentImageView.downloaded(from: postToShow.contentPicURL)
        } else if postToShow.contentDocUrl != "" {
            contentImageView.downloaded(from: postToShow.contentDocUrl)
        } else if postToShow.contentVideoURL != "" {
            contentImageView.downloaded(from: postToShow.contentVideoURL)
        } else if postToShow.contentLinkURL != ""{
            contentImageView.downloaded(from: postToShow.contentLinkURL)
        } else {
            contentImageView.image = #imageLiteral(resourceName: "kosmos")
        }
        likeShareControl.likeCountLabel.text = "\(postToShow.likesCount)"
        if postToShow.didLike == 0 {
            likeShareControl.likeImage.image = UIImage(named: "dislike")
        } else {
            likeShareControl.likeImage.image = UIImage(named: "like")
            likeShareControl.likeCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        likeShareControl.shareCountLabel.text = "\(postToShow.sharesCount)"
        if postToShow.didShare == 0 {
            likeShareControl.shareImage.image = UIImage(named: "unshare")
        } else {
            likeShareControl.shareImage.image = UIImage(named: "share")
            likeShareControl.shareCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        likeShareControl.onTapLike = {
            self.newsVC.likeOnNewsPost(self.likeShareControl, self.postToShow)
        }
        likeShareControl.onTapShare = {
            self.newsVC.shareOnNewsPost(self.likeShareControl, self.postToShow)
        }
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  comments.isEmpty {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            emptyCell.commentLabel = nil
            return emptyCell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            let comment = comments[indexPath.row]
            cell.commentLabel.text = comment
        return cell
        }
    }
    
    @IBAction func sendCommentKeyboard(_ sender: Any) {
        guard let comment = commentTextField.text else { return }
        comments.append(comment)
        commentTableView.reloadData()
    }
    
    @IBAction func sendComment(_ sender: Any) {
        guard let comment = commentTextField.text else { return }
        comments.append(comment)
        commentTableView.reloadData()
    }
    
//    Скрытие клавиатуры
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func hideKeyboard() {
        self.view?.endEditing(true)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {

    }
}
