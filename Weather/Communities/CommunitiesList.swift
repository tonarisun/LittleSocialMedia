//
//  CommunitiesList.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CommunitiesList: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var communitySearchBar: UISearchBar!
    
    var allCommunities = ["Новости 24/7", "Записываемся на реснички", "Лучшие мемы", "Красота природы", "Секретные рецепты", "Вакансии Krusty Krabs", "Путешествия на сушу", "Бикини Боттом night life", "Красивые фотографии", "Истории", "Находки c AliExpress"]
    
    var filteredCommunities = [String]()
    
    var myCommunityVC : MyCommunityController?

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredCommunities = allCommunities
        setUpSearchBar()
    }
    
    private func setUpSearchBar(){
        communitySearchBar.delegate = self
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCommunities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell", for: indexPath) as! CommunityCell
        let community = filteredCommunities[indexPath.row]
        cell.communityName.text = community
        cell.avatarView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        cell.addCommunityTapped = { communityName in
            guard let myCommunityVC = self.myCommunityVC else {
                return
            }
            if !myCommunityVC.filteredMyCommunities.contains(communityName){
            myCommunityVC.filteredMyCommunities.append(communityName)
            }
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredCommunities = allCommunities
            tableView.reloadData()
            return }
        filteredCommunities = allCommunities.filter({community -> Bool in
        return community.lowercased().contains(searchText.lowercased())
    })
        tableView.reloadData()
    }
}
