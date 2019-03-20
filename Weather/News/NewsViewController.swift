//
//  NewsViewController.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.authorLabel.text = "Sandy Cheeks"
        cell.timeLabel.text = "17.03.2019 14:15"
        cell.avanarView.image = #imageLiteral(resourceName: "Sandy")
        cell.contentImageView.image = #imageLiteral(resourceName: "Diamond-Peak-Sunset-By-Robert-Bynum-iPad-Pro-Wallpaper-2732x2732")
        return cell
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
    }
}



