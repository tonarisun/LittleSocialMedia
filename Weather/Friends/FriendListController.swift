//
//  FriendListController.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

struct Friend : Comparable {
    
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.friendName < rhs.friendName
    }
    let friendName : String
    var friendPic : UIImage
}

class FriendListController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var friendListSearchBar: UISearchBar!
    
    var friendList = [Friend(friendName: "SpongeBob SquarePants", friendPic:  UIImage(named: "SpongeBob")!),
                      Friend(friendName: "Patrick Star", friendPic:  UIImage(named: "PatrickStar")!),
                      Friend(friendName: "Squidward Tentacles", friendPic:  UIImage(named: "SquidwardTentacles")!),
                      Friend(friendName: "Mr. Krabs", friendPic:  UIImage(named: "MrKrabs")!),
                      Friend(friendName: "Sandy Cheeks", friendPic:  UIImage(named: "Sandy")!),
                      Friend(friendName: "Plankton", friendPic:  UIImage(named: "Plankton")!),
                      Friend(friendName: "Karen", friendPic:  UIImage(named: "Karen")!),
                      Friend(friendName: "Mrs. Puff", friendPic:  UIImage(named: "Puff")!),
                      Friend(friendName: "Pearl Krabs", friendPic:  UIImage(named: "Pearl Krabs")!),
                      Friend(friendName: "Gary the Snail", friendPic:  UIImage(named: "Gary")!)]
    
    var sortedFriendList = [Friend]()
    var friendsForLetter = [Friend]()
    var firstLetters = [String]()
    var filteredFirstLetters = [String]()
    var groupedFriendList : Dictionary = [String : [Friend]]()
    var filteredFriendList : Dictionary = [String : [Friend]]()
    var firstLetter : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(hideKeyboardGesture)
        
        sortedFriendList = friendList.sorted { $0.friendName < $1.friendName }
        
        getFirstLetters()
        groupFriends()
        setUpSearchBar()
        filteredFriendList = groupedFriendList
        filteredFirstLetters = firstLetters
    }
    
    func getFirstLetters(){
        for friend in sortedFriendList {
            if !firstLetters.contains(String(friend.friendName.prefix(1))) {
                firstLetters.append(String(friend.friendName.prefix(1)))
            }
        }
    }
    
    func groupFriends(){
        for letter in firstLetters {
            friendsForLetter.removeAll()
            for friend in sortedFriendList {
                if letter == friend.friendName.prefix(1) {
                    friendsForLetter.append(friend)
                    groupedFriendList.updateValue(friendsForLetter, forKey: letter)
                }
            }
        }
    }
    
    private func setUpSearchBar(){
        friendListSearchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        firstLetter = filteredFirstLetters[section]
        return filteredFirstLetters[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFirstLetters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (filteredFriendList[firstLetter]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendNameCell", for: indexPath) as! FriendNameCell
        let letter = filteredFirstLetters[indexPath.section]
        let friend = filteredFriendList[letter]
        cell.avatarView.image = friend![indexPath.row].friendPic
        cell.friendName.text = friend![indexPath.row].friendName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filteredFirstLetters
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowFriendFoto" else {
            return
        }
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let letter = filteredFirstLetters[indexPath.section]
        let friend = filteredFriendList[letter]
        let friendData = friend![indexPath.row]
        let friendFotoController = segue.destination as! FriendFotoController
        friendFotoController.friendsToShow = [friendData]
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredFirstLetters = firstLetters
            filteredFriendList = groupedFriendList
            tableView.reloadData()
            return }
        filteredFriendList.removeAll()
        filteredFirstLetters.removeAll()
        for key in firstLetters {
            friendsForLetter.removeAll()
            for friend in sortedFriendList {
                if friend.friendName.lowercased().contains(searchText.lowercased()) && friend.friendName.prefix(1) == key{
                    friendsForLetter.append(friend)
                    filteredFriendList.updateValue(friendsForLetter, forKey: key)
                    if !filteredFirstLetters.contains(key){
                    filteredFirstLetters.append(key)
                    }
                }
            }
            tableView.reloadData()
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
        self.tableView?.endEditing(true)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        tableView?.contentInset = contentInsets
        tableView?.scrollIndicatorInsets = contentInsets
    }
}
