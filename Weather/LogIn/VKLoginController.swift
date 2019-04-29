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

class VKLoginController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var vkWebView: WKWebView! {
        didSet {
            vkWebView.navigationDelegate = self
        }
    }
   
    let currentSession = Session.session
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        currentSession.token = token!
        print(token ?? "No token")
        
        Alamofire.request("https://api.vk.com/method/users.get?user_ids=9539104&lang=ru&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print(response)
        }
        Alamofire.request("https://api.vk.com/method/friends.get?user_id=9539104&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print(response)
        }
        Alamofire.request("https://api.vk.com/method/photos.get?owner_id=9539104&album_id=wall&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print(response)
        }
        Alamofire.request("https://api.vk.com/method/groups.get?&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print(response)
        }
        Alamofire.request("https://api.vk.com/method/groups.search?q=science&count=5&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print(response)
        }
        
        decisionHandler(.cancel)
    }
}
