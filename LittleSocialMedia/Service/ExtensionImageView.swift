//
//  ExtensionImageView.swift
//  Weather
//
//  Created by Olga Lidman on 06/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func downloaded(from url: URL, mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, mode: mode)
    }
    
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}

class CashImage {
    
    func saveImage(image: UIImage, url: URL) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directiry = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        
        let fileName = String(url.hashValue)
        
        do {
            guard let fileUrl = directiry.appendingPathComponent(fileName) else {
                return false
            }
            print(fileUrl)
            try data.write(to: fileUrl)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getImage(url: URL) -> UIImage? {
        let fileName = String(url.hashValue)
        if let directiry = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: url, create: false) {
            let fullUrl = URL(fileURLWithPath: directiry.absoluteString).appendingPathComponent(fileName).path
            return UIImage(contentsOfFile: fullUrl)
        }
        return nil
    }
}
