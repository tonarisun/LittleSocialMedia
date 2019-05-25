//
//  MyProfileViewController.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import FirebaseAuth
import RealmSwift


class MyProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myAvatarView: Avatar!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myAgeAndCityLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var newsTableView: UITableView!
    var users: Results<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserDataFromRLM()
        
        guard let currentUser = users?.first else { return }
        
        myNameLabel.text = currentUser.userFirstName + " " + currentUser.userLastName
        myAgeAndCityLabel.text = currentUser.userBDate + " " + currentUser.userCity
        myAvatarView.photoView.downloaded(from: currentUser.avaURL)
        
        
        let vkRequest = VKRequest()
        
        vkRequest.loadCommunities { myComm in
            vkRequest.saveCommunitiesInRLM(myComm)
        }
        
        vkRequest.loadFriends { friends in
            vkRequest.saveFriendsInRLM(friends)
        }
        
        let hideKeyboardGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func loadUserDataFromRLM() {
        do {
            let realm = try Realm()
            self.users = realm.objects(User.self)
        } catch {
            print(error)
        }
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
    
    @IBAction func logOut(_ sender: Any) {
        do {
         try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let newPost = newsList[indexPath.row]
        cell.authorLabel.text = newPost.authorName
        cell.timeLabel.text = newPost.currentTime
        cell.avatarView.photoView.image = newPost.authorPic
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
