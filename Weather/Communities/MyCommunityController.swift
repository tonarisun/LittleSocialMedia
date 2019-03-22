//
//  MyCommunityController.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MyCommunityController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var myCommunitySearchBar: UISearchBar!
    
    var myCommunities = ["Подслушано. БикиниБоттом", "Подводные байки", "Дома Ананасы"]
    var filteredMyCommunities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMyCommunities = myCommunities
        setUpSearchBar()
    }
    
    private func setUpSearchBar(){
        myCommunitySearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filteredMyCommunities = myCommunities
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMyCommunities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommCell", for: indexPath) as! MyCommunityCell
        let community = filteredMyCommunities[indexPath.row]
        cell.myCommunityName.text = community
        cell.avatarView.backgroundColor = #colorLiteral(red: 0.08869794756, green: 0.28105551, blue: 0.4478540421, alpha: 1)

        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filteredMyCommunities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//    Распознавание контроллера CommunitiesList
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? CommunitiesList {
            vc.myCommunityVC = self
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredMyCommunities = myCommunities
            tableView.reloadData()
            return }
        filteredMyCommunities = myCommunities.filter({community -> Bool in
            return community.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
}

// Добавление группы по нажатию на ячейку с возвратом на страницу MyCommunityController
//    @IBAction func addCommunity(segue: UIStoryboardSegue) {
//        if segue.identifier == "addCommunity" {
//            let communitiesController = segue.source as! CommunitiesList
//            if let indexPath = communitiesController.tableView.indexPathForSelectedRow {
//                let community = communitiesController.allCommunities[indexPath.row]
//                if !myCommunities.contains(community){
//                myCommunities.append(community)
//                tableView.reloadData()
//                }
//            }
//        }
//    }

