//
//  MyCommunityController.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MyCommunityController: UITableViewController {
    
    var myCommunities = ["Подслушано. БикиниБоттом", "Подводные байки", "Дома Ананасы"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCommunities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommCell", for: indexPath) as! MyCommunityCell
        
        let community = myCommunities[indexPath.row]
        cell.myCommunityName.text = community
        cell.myCommunityPic.backgroundColor = .blue

        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myCommunities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addCommunity(segue: UIStoryboardSegue) {
        if segue.identifier == "addCommunity" {
            let communitiesController = segue.source as! CommunitiesList
            if let indexPath = communitiesController.tableView.indexPathForSelectedRow {
                let community = communitiesController.allCommunities[indexPath.row]
                if !myCommunities.contains(community){
                    myCommunities.append(community)
                    tableView.reloadData()
                }
            }
        }
    }
}
