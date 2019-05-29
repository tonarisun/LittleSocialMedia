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
    var newsList = [NewsPost]()
    var authorsList = [NewsAuthor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserDataFromRLM()
        
        guard let currentUser = users?.first else { return }
        
        myNameLabel.text = currentUser.userFirstName + " " + currentUser.userLastName
        myAgeAndCityLabel.text = currentUser.userBDate + " " + currentUser.userCity
        myAvatarView.photoView.downloaded(from: currentUser.avaURL)
        
        let vkRequest = VKRequest()
        
        vkRequest.loadNews { [weak self] newsList, authorsList in
            self?.newsList = newsList
            self?.authorsList = authorsList
            for new in newsList {
                for author in authorsList {
                    if author.id == -new.sourceID {
                        new.author = author
                    }
                }
            }
            self?.newsTableView.reloadData()
        }
        
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
        cell.authorLabel.text = newPost.author?.authorName
        cell.timeLabel.text = getTimeFromUNIXTime(date: newPost.time)
        cell.avatarView.photoView.downloaded(from: newPost.author!.authorPicURL)
        cell.contentLabel.text = newPost.content
        cell.contentImageView.downloaded(from: newPost.contentPicURL)
        if newPost.didLike == 0 {
            cell.likeShareControlView.likeImage.image = UIImage(named: "dislike")
        } else {
            cell.likeShareControlView.likeImage.image = UIImage(named: "like")
            cell.likeShareControlView.likeCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        cell.likeShareControlView.likeCountLabel.text = "\(newPost.likesCount)"
        if newPost.didShare == 0 {
            cell.likeShareControlView.shareImage.image = UIImage(named: "unshare")
        } else {
            cell.likeShareControlView.shareImage.image = UIImage(named: "share")
            cell.likeShareControlView.shareCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        cell.likeShareControlView.shareCountLabel.text = "\(newPost.sharesCount)"
        cell.likeShareControlView.onTapLike = {
            self.likeOnNewsPost(cell: cell, post: newPost)
            self.shareOnNewsPost(cell: cell, post: newPost)
        }
        return cell
    }
    
    func likeOnNewsPost(cell: NewsCell, post: NewsPost) {
        if cell.likeShareControlView.likeImage.image == UIImage(named: "dislike") {
            post.likesCount += 1
            post.didLike = 1
            cell.likeShareControlView.likeCount = post.likesCount
            cell.likeShareControlView.likeImage.image = UIImage(named: "like")
            cell.likeShareControlView.like()
        } else {
            post.likesCount -= 1
            post.didLike = 0
            cell.likeShareControlView.likeCount = post.likesCount
            cell.likeShareControlView.likeImage.image = UIImage(named: "dislike")
            cell.likeShareControlView.dislike()
        }
    }
    
    func shareOnNewsPost(cell: NewsCell, post: NewsPost) {
        cell.likeShareControlView.onTapShare = {
            if cell.likeShareControlView.shareImage.image == UIImage(named: "unshare") {
                post.sharesCount += 1
                post.didShare = 1
                cell.likeShareControlView.shareCount = post.sharesCount
                cell.likeShareControlView.share()
            } else {
                post.sharesCount -= 1
                post.didShare = 0
                cell.likeShareControlView.shareCount = post.sharesCount
                cell.likeShareControlView.unshare()
            }
        }
    }
    
    func getTimeFromUNIXTime(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}
