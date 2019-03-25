//
//  CommunitiesList.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//Olga Lidman, [24.03.19 17:44]


import UIKit

class CommunitiesList: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var communitySearchBar: UISearchBar!
    
    var allCommunities = [Community(communityName: "News 24/7", communityPic: #imageLiteral(resourceName: "flower-pot")),
                          Community(communityName: "Memes", communityPic: #imageLiteral(resourceName: "circle")),
                          Community(communityName: "That's wonderfull world", communityPic: #imageLiteral(resourceName: "like-2")),
                          Community(communityName: "Secret recipes", communityPic: #imageLiteral(resourceName: "user")),
                          Community(communityName: "Traveling", communityPic: #imageLiteral(resourceName: "flower-pot")),
                          Community(communityName: "Bikini Bottom night life", communityPic: #imageLiteral(resourceName: "users-1")),
                          Community(communityName: "True stories", communityPic: #imageLiteral(resourceName: "MrKrabs")),
                          Community(communityName: "Look what I found", communityPic: #imageLiteral(resourceName: "SpongeBob"))]
    
    
    var filteredCommunities = [Community]()
        
    var myCommunityVC : MyCommunityController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        filteredCommunities = allCommunities
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(hideKeyboardGesture)
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
        cell.communityNameLabel.text = community.communityName
        cell.avatarView.image = community.communityPic
        cell.addCommunityTapped = { community in
            guard let myCommunityVC = self.myCommunityVC else {
                return
            }
            if !myCommunityVC.myCommunities.contains(community){
            myCommunityVC.myCommunities.append(community)
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
        return community.communityName.lowercased().contains(searchText.lowercased())
    })
        tableView.reloadData()
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
