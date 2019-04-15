//
//  NewsViewController.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

var newsList = [NewPost(author: Friend(friendName: "SpongeBob SquarePants", friendPic:  UIImage(named: "SpongeBob")!, friendFotos: []), currentTime : getTodayString(), content : #imageLiteral(resourceName: "Bob Patrick Squidward small")),
                NewPost(author: Friend(friendName: "Squidward Tentacles", friendPic:  UIImage(named: "SquidwardTentacles")!, friendFotos: []), currentTime : getTodayString(), content : #imageLiteral(resourceName: "SquidwardTentacles")),
                NewPost(author:  Friend(friendName: "Sandy Cheeks", friendPic:  UIImage(named: "Sandy")!, friendFotos: []), currentTime : getTodayString(), content : #imageLiteral(resourceName: "Sandy")),
                NewPost(author:  Friend(friendName: "Karen", friendPic:  UIImage(named: "Karen")!, friendFotos: []), currentTime : getTodayString(), content : #imageLiteral(resourceName: "Plankton")),
                NewPost(author: Friend(friendName: "SpongeBob SquarePants", friendPic:  UIImage(named: "SpongeBob")!, friendFotos: []), currentTime : getTodayString(), content : #imageLiteral(resourceName: "Diamond-Peak-Sunset-By-Robert-Bynum-iPad-Pro-Wallpaper-2732x2732"))]

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(hideKeyboardGesture)
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
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

func getTodayString() -> String {
    
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    let year = components.year
    let month = components.month
    let day = components.day
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
    return today_string
}
