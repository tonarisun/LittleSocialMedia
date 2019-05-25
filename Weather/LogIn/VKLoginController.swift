//
//  VKLoginController.swift
//  Weather
//
//  Created by Olga Lidman on 29/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftKeychainWrapper
import RealmSwift

class VKLoginController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var circleIndicator: CircleIndicator!
    @IBOutlet weak var toNewsButton: UIButton!
    @IBOutlet weak var vkWebView: WKWebView! {
        didSet {
            vkWebView.navigationDelegate = self
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toNewsButton.isHidden = true
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6964982"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.95")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        vkWebView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        if token != nil {
            circleIndicator.isHidden = true
            toNewsButton.isHidden = false
        }

        KeychainWrapper.standard.set("\(token!)", forKey: "access token")
        currentSession.token = KeychainWrapper.standard.string(forKey: "access token")!
        currentSession.userID = currentUserID
        print(token ?? "No token")
        
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.deleteAll()
            try! realm.commitWrite()
            print(realm.configuration.fileURL ?? "No fileURL")
        }
            catch {
                print(error)
            }
        
        let vkRequest = VKRequest()
        vkRequest.loadCommunities { myComm in
            vkRequest.saveCommunitiesInRLM(myComm)
        }
        
        vkRequest.loadFriends { friends in
            vkRequest.saveFriendsInRLM(friends)
        }

        decisionHandler(.cancel)
    }
}
