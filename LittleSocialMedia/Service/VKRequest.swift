//
//  VKRequest.swift
//  Weather
//
//  Created by Olga Lidman on 09/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift

class Service {
        
    func loadUserInfo(completion: @escaping (User) -> Void) {
        Alamofire.request("https://api.vk.com/method/users.get?lang=0&fields=photo_50,city,bdate&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<UserResponse>) in
            let userResponse = response.result.value
            guard let user = userResponse?.response[0] else { return }
            
            completion(user)
        }
    }
    
//    Загрузка данных пользователя в Realm
    func saveUserInRLM(_ currentUser: User) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(currentUser)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    //    Звгрузка данных пользователя из базы Realm
    func loadUserDataFromRLM() -> Results<User> {
        let realm = try! Realm()
        let users = realm.objects(User.self)
        return users
    }
    
    func loadNews(completion: @escaping ([NewsPost], [NewsAuthor]) -> Void) {
        Alamofire.request("https://api.vk.com/method/newsfeed.get?&filters=post&source_ids=groups&count=60&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<NewsResponse>) in
            let newsResponse = response.result.value
            guard let newsList = newsResponse?.responseNews else { return }
            guard let authorsList = newsResponse?.responseAuthors else { return }
            completion(newsList, authorsList)
        }
    }
    
    func loadFriends(completion: @escaping ([Friend]) -> Void) {
        Alamofire.request("https://api.vk.com/method/friends.get?user_id=\(currentSession.userID)&fields=nickname,photo_50&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<FriendResponse>) in
            let friendResponse = response.result.value
            guard let friendList = friendResponse?.response else { return }
            completion(friendList)
        }
    }
    
    func saveFriendsInRLM(_ friendsToSave: [Friend]){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friendsToSave)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadPhoto(userID: Int, completion: @escaping ([Photo]) -> Void) {
        Alamofire.request("https://api.vk.com/method/photos.get?owner_id=\(userID)&album_id=wall&count=30&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<PhotoResponse>) in
            let photoResponse = response.result.value
            guard let photos = photoResponse?.response else { return }
            completion(photos)
        }
    }
    
    func loadCommunities(completion: @escaping ([Community]) -> Void) {
        Alamofire.request("https://api.vk.com/method/groups.get?extended=1&user_id=\(currentSession.userID)&fields=name,photo_50&count=30&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<CommunityResponse>) in
            let groupResp = response.result.value
            guard let myComm = groupResp?.response else { return }
            completion(myComm)
        }
    }
    
    func saveCommunitiesInRLM(_ communitiesToSave: [Community]){
        do {
            let realm = try! Realm()
            let oldCommunities = realm.objects(Community.self)
            realm.beginWrite()
            realm.delete(oldCommunities)
            realm.add(communitiesToSave)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    public func getTimeFromUNIXTime(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func getTodayString() -> String {
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
    }
}
