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

class VKRequest {
        
    func loadUserInfo(completion: @escaping (User) -> Void) {
        Alamofire.request("https://api.vk.com/method/users.get?lang=0&user_ids=\(currentSession.userID)&fields=photo_50,city,bdate&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<UserResponse>) in
            let userResponse = response.result.value
            guard let user = userResponse?.response[0] else { return }
            let userData = UserDefaults.standard
            userData.set("\(user.userFirstName) \(user.userLastName)", forKey: "UserName")
            userData.set("\(user.userID)", forKey: "UserID")
            completion(user)
        }
    }
    
    func loadFriend(completion: @escaping ([Friend]) -> Void) {
        Alamofire.request("https://api.vk.com/method/friends.get?user_id=\(currentSession.userID)&fields=nickname,photo_50&access_token=\(currentSession.token)&v=5.95").responseObject {
            (response: DataResponse<FriendResponse>) in
            let friendResponse = response.result.value
            guard let friendList = friendResponse?.response else { return }
            completion(friendList)
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
}
