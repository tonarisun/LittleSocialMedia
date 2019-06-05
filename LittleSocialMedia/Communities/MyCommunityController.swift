//
//  MyCommunityController.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift

class MyCommunityController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var myCommunitySearchBar: UISearchBar!
    
    var myCommunities : Results<Community>?
    var filteredMyCommunities : Results<Community>?
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Загрузка списка групп из базы Realm
        loadCommunitiesFromRLM()

//        Добавление наблюдателя за списком групп
        addRealmObserve()

//        Установка строки поиска
        setUpSearchBar()
        
//        Распознавание жеста для скрытия клавиатуры
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
//        Загрузка списка групп из базы Realm
    func loadCommunitiesFromRLM() {
        do {
            let realm = try Realm()
            self.myCommunities = realm.objects(Community.self).sorted(byKeyPath: "communityID")
            self.filteredMyCommunities = self.myCommunities

        } catch {
            print(error)
        }
    }
    
//    Наблюдатель за списком отображаемых групп
    func addRealmObserve() {
        self.token = filteredMyCommunities?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .middle)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .middle)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .middle)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
//    Установка SerchBar
    private func setUpSearchBar(){
        myCommunitySearchBar.delegate = self
    }
    
//    Форирование таблицы
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMyCommunities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommCell", for: indexPath) as! MyCommunityCell
        let community = filteredMyCommunities![indexPath.row]
        cell.myCommunityNameLabel.text = community.communityName
        cell.avatarView.photoView.downloaded(from: community.pictureURL)

        return cell
    }
  
//    Удаление группы из списка
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(filteredMyCommunities![indexPath.row])
                try realm.commitWrite()
            }
            catch {
                print(error)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredMyCommunities = myCommunities
            tableView.reloadData()
            return }
        filteredMyCommunities = myCommunities?.filter("communityName CONTAINS '\(searchText.lowercased())'") // Как сделать, чтобы communityName был тоже lowercased?
        tableView.reloadData()
    }
    
//    Скрытие клавиатуры
    @objc func hideKeyboard() {
        self.tableView?.endEditing(true)
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
