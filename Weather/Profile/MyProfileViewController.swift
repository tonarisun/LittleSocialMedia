//
//  MyProfileViewController.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit


class MyProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myAvatarView: Avatar!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myAgeAndCityLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(hideKeyboardGesture)
        
        myAvatarView.image = user1.userPic
        myNameLabel.text = user1.userName
        myAgeAndCityLabel.text = "\(user1.userAge) years, \(user1.userCity)"
//        profileView.layer.cornerRadius = 10
//        profileView.layer.shadowOffset = .zero
//        profileView.layer.shadowOpacity = 1
//        profileView.layer.borderWidth = 1
//        profileView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    @objc func hideKeyboard() {
        self.view?.endEditing(true)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        newsTableView?.contentInset = contentInsets
        newsTableView?.scrollIndicatorInsets = contentInsets
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let newPost = newsList[indexPath.row]
        cell.authorLabel.text = newPost.author.friendName
        cell.timeLabel.text = newPost.currentTime
        cell.avatarView.image = newPost.author.friendPic
        cell.contentImageView.image = newPost.content
        cell.likeShareControlView.likeImage.image = UIImage(named: "like")
        cell.likeShareControlView.likeCountLabel.text = "\(newPost.likeCount)"
        cell.likeShareControlView.shareImage.image = UIImage(named: "share")
        cell.likeShareControlView.shareCountLabel.text = "\(newPost.shareCount)"
        cell.likeShareControlView.onTapLike = {
            if cell.likeShareControlView.likeImage.image == UIImage(named: "like") {
                newPost.likeCount += 1
                cell.likeShareControlView.likeCount = newPost.likeCount
                cell.likeShareControlView.likeImage.image = UIImage(named: "like-2")
                cell.likeShareControlView.like()
            } else {
                newPost.likeCount -= 1
                cell.likeShareControlView.likeCount = newPost.likeCount
                cell.likeShareControlView.likeImage.image = UIImage(named: "like")
                cell.likeShareControlView.dislike()
            }
        }
        cell.likeShareControlView.onTapShare = {
            if cell.likeShareControlView.shareImage.image == UIImage(named: "share") {
                newPost.shareCount += 1
                cell.likeShareControlView.shareCount = newPost.shareCount
                cell.likeShareControlView.share()
            } else {
                newPost.shareCount -= 1
                cell.likeShareControlView.shareCount = newPost.shareCount
                cell.likeShareControlView.unshare()
            }
        }
        return cell
    }
}
