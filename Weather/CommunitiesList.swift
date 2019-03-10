//
//  CommunitiesList.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CommunitiesList: UITableViewController {
    
    var allCommunities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCommunities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell", for: indexPath) as! CommunityCell
        let community = allCommunities[indexPath.row]
        cell.communityName.text = community
        cell.communityPic.backgroundColor = .yellow

        return cell
    }
    
    
    @IBAction func addCommunity(_ sender: UIButton) {
        print("Нажатие кнопки")
    }
}
