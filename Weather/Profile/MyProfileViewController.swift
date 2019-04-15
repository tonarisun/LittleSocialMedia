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
    @IBOutlet weak var newsNableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAvatarView.image = user1.userPic
        myNameLabel.text = user1.userName
        myAgeAndCityLabel.text = "\(user1.userAge) years, \(user1.userCity)"
//        profileView.layer.cornerRadius = 10
//        profileView.layer.shadowOffset = .zero
//        profileView.layer.shadowOpacity = 1
        profileView.layer.borderWidth = 1.2
        profileView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
        return cell
    }
}
