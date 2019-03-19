//
//  FriendListController.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class FriendListController: UITableViewController {
    
    struct Friend : Comparable {
        
        static func < (lhs: FriendListController.Friend, rhs: FriendListController.Friend) -> Bool {
            return lhs.friendName < rhs.friendName
        }
        let friendName : String
        var friendPic : UIImage
    }
    
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
    var firstLetters = [String]()
    var friends = [Friend]()
    var groupedFriendList : Dictionary = [String : [Friend]]()
    var firstLetter : String!
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortedFriendList = friendList.sorted { $0.friendName < $1.friendName }
        
        for friend in sortedFriendList {
            if !firstLetters.contains(String(friend.friendName.prefix(1))) {
                firstLetters.append(String(friend.friendName.prefix(1)))
            }
        }
        
        for letter in firstLetters {
            friends.removeAll()
            for friend in sortedFriendList {
                if letter == friend.friendName.prefix(1) {
                    friends.append(friend)
                    groupedFriendList.updateValue(friends, forKey: letter)
                }
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        firstLetter = firstLetters[section]
        return firstLetters[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstLetters.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groupedFriendList[firstLetter]?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendNameCell", for: indexPath) as! FriendNameCell
        let letter = firstLetters[indexPath.section]
        let friend = groupedFriendList[letter]
        cell.avatarView.image = friend![indexPath.row].friendPic
        cell.friendName.text = friend![indexPath.row].friendName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowFriendFoto" else {
            return
        }
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let friendData = friendList[indexPath.row]
        let friendFotoController = segue.destination as! FriendFotoController
        friendFotoController.friends = [friendData]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return firstLetters
    }
}
