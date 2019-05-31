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
    var newsList = [NewsPost]()
    var authorsList = [NewsAuthor]()
    let segueID = "showPost"
    let vkRequest = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Получение из Realm и отображение данных пользователя
        guard let currentUser =  vkRequest.loadUserDataFromRLM().first else { return }
        myNameLabel.text = currentUser.userFirstName + " " + currentUser.userLastName
        myAgeAndCityLabel.text = currentUser.userBDate + ", " + currentUser.userCity
        myAvatarView.photoView.downloaded(from: currentUser.avaURL)
        
//        Загрузка списка новостей из ВК
        vkRequest.loadNews { [weak self] newsList, authorsList in
            for new in newsList {
                for author in authorsList {
                    if author.id == -new.sourceID {
                        new.author = author
                    }
                }
            }
            self?.newsList = newsList
            self?.authorsList = authorsList
            self?.newsTableView.reloadData()
        }
        
//        Загрузка списка моих групп из ВК, сохранение в базу Realm
        vkRequest.loadCommunities { myComm in
            self.vkRequest.saveCommunitiesInRLM(myComm)
        }
        
//      Загрузка списка друзей из ВК, сохранение в базу Realm
        vkRequest.loadFriends { friends in
            self.vkRequest.saveFriendsInRLM(friends)
        }
    }
    
//    Выход пользователя из системы, переход на экран авторизации
    @IBAction func logOut(_ sender: Any) {
        do {
         try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
//    Формирование таблицы новостей
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let newPost = newsList[indexPath.row]
        cell.authorLabel.text = newPost.author?.authorName
        cell.timeLabel.text = self.vkRequest.getTimeFromUNIXTime(date: newPost.time)
        cell.avatarView.photoView.downloaded(from: newPost.author!.authorPicURL)
        cell.contentLabel.text = newPost.content
        cell.viewsCountLabel.text = "\(newPost.viewsCount)"
//        Content Image
        if newPost.contentPicURL != "" {
            cell.contentImageView.downloaded(from: newPost.contentPicURL)
        } else if newPost.contentDocUrl != "" {
            cell.contentImageView.downloaded(from: newPost.contentDocUrl)
        } else if newPost.contentVideoURL != "" {
            cell.contentImageView.downloaded(from: newPost.contentVideoURL)
        } else if newPost.contentLinkURL != ""{
            cell.contentImageView.downloaded(from: newPost.contentLinkURL)
        } else {
            cell.contentImageView.image = #imageLiteral(resourceName: "kosmos")
        }
//      Like
        cell.likeShareControlView.likeCountLabel.text = "\(newPost.likesCount)"
        if newPost.didLike == 0 {
            cell.likeShareControlView.likeImage.image = UIImage(named: "dislike")
        } else {
            cell.likeShareControlView.likeImage.image = UIImage(named: "like")
            cell.likeShareControlView.likeCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
//      Share
        cell.likeShareControlView.shareCountLabel.text = "\(newPost.sharesCount)"
        if newPost.didShare == 0 {
            cell.likeShareControlView.shareImage.image = UIImage(named: "unshare")
        } else {
            cell.likeShareControlView.shareImage.image = UIImage(named: "share")
            cell.likeShareControlView.shareCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        cell.likeShareControlView.onTapLike = {
            self.likeOnNewsPost(cell.likeShareControlView, newPost)
        }
        cell.likeShareControlView.onTapShare = {
            self.shareOnNewsPost(cell.likeShareControlView, newPost)
        }
        return cell
    }
    
//    Переход на CommentNewsController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPost" else { return }
        guard let indexPath = newsTableView.indexPathForSelectedRow else { return }
        let post = newsList[indexPath.row]
        let controller = segue.destination as! CommentNewsController
        controller.postToShow = post
    }
    
//    Отметка Like под постом
    func likeOnNewsPost(_ likeShareControl: LikeShareControl, _ post: NewsPost) {
        if likeShareControl.likeImage.image == UIImage(named: "dislike") {
            post.likesCount += 1
            post.didLike = 1
            likeShareControl.likeCount = post.likesCount
            likeShareControl.likeImage.image = UIImage(named: "like")
            likeShareControl.like()
        } else {
            post.likesCount -= 1
            post.didLike = 0
            likeShareControl.likeCount = post.likesCount
            likeShareControl.likeImage.image = UIImage(named: "dislike")
            likeShareControl.dislike()
        }
    }
    
//    Репост новости
    func shareOnNewsPost(_ likeShareControl: LikeShareControl, _ post: NewsPost) {
        if likeShareControl.shareImage.image == UIImage(named: "unshare") {
            post.sharesCount += 1
            post.didShare = 1
            likeShareControl.shareCount = post.sharesCount
            likeShareControl.share()
        } else {
            post.sharesCount -= 1
            post.didShare = 0
            likeShareControl.shareCount = post.sharesCount
            likeShareControl.unshare()
        }
    }
}
