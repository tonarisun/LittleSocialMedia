//
//  CommunitiesList.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//Olga Lidman, [24.03.19 17:44]

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
import FirebaseFirestore

class CommunitiesList: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var serchView: UIStackView!
    @IBOutlet weak var communitySearchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    var allCommunities = [Community]()
    var myCommunityVC : MyCommunityController?
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.borderWidth = 0.5
        searchButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        searchButton.layer.cornerRadius = 3
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(hideKeyboardGesture)
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
        cell.communityNameLabel.text = community.communityName
        cell.avatarView.photoView.downloaded(from: "\(community.pictureURL)")
        cell.configure(community: community)
        cell.addCommunityTapped = { community in
            guard let myCommunityVC = self.myCommunityVC else {
                return
            }
            if !myCommunityVC.myCommunities!.contains(community){
                do {
                    let realm = try! Realm()
                    realm.beginWrite()
                    realm.add(community)
                    try realm.commitWrite()
                }
                catch {
                    print(error)
                }
                self.db.collection("communities").document("\(community.communityID)").setData([
                    "communityName": "\(community.communityName)",
                    "pictureURL": "\(community.pictureURL)"
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
        return cell
    }

    @IBAction func searchCommunity(_ sender: UIButton) { // Почему-то не работает поиск русских слов, хотя если запрос к ВК проверить, то результат есть. И ещё пока не ищет фразы с пробелами, только по одному слову или с + вместо пробела.

        guard let searchText = self.communitySearchBar.text?.lowercased() else { return }
        Alamofire.request("https://api.vk.com/method/groups.search?q=\(searchText.lowercased())&type=group&count=50&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<CommunityResponse>) in
            
            let groupResp = response.result.value
            guard let allComm = groupResp?.response else { return }
            self.allCommunities = allComm
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
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
