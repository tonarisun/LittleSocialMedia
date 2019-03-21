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

class FriendListController: UITableViewController {

    
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
    var friendsForLetter = [Friend]()
    var groupedFriendList : Dictionary = [String : [Friend]]()
    var firstLetter : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortedFriendList = friendList.sorted { $0.friendName < $1.friendName }
        
        for friend in sortedFriendList {
            if !firstLetters.contains(String(friend.friendName.prefix(1))) {
                firstLetters.append(String(friend.friendName.prefix(1)))
            }
        }
        
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
        let letter = firstLetters[indexPath.section]
        let friend = groupedFriendList[letter]
        let friendData = friend![indexPath.row]
        let friendFotoController = segue.destination as! FriendFotoController
        friendFotoController.friendsToShow = [friendData]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return firstLetters
    }
}
