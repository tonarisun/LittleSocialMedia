//
//  FriendListController.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class FriendListController: UITableViewController {
    
    struct Friend {
        let friendName : String
        var friendPic : UIImage
    }
    
    var friendList = [Friend(friendName: "SpongeBob SquarePants", friendPic: #imageLiteral(resourceName: "SpongeBob") ), Friend(friendName: "Patrick Star", friendPic: #imageLiteral(resourceName: "PatrickStar") ),Friend(friendName: "Squidward Tentacles", friendPic: #imageLiteral(resourceName: "SquidwardTentacles") )]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendNameCell", for: indexPath) as! FriendNameCell
        let friend = friendList[indexPath.row]
        cell.friendName.text = friend.friendName
        cell.friendUserpic?.image = friend.friendPic
        return cell
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
    
}
