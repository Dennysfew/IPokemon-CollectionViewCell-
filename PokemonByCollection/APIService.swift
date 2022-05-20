//
//  APIServices.swift
//  IPokemon
//
//  Created by Denys on 26.04.2022.
//

import Foundation
import UIKit

final class APIService: NSObject {
    
    func fetchData(urlString: String, completion: ((Data?) -> Void)?) {
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask = defaultSession.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if (error != nil) {
                print(error!)
                return
            }
            completion?(data)
        }
        dataTask.resume()
    }
    
    func fetchImage(urlString: String, completion: ((UIImage?) -> Void)?) {
        guard let url = URL(string: urlString) else {
            print("url invalid")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            completion?(UIImage(data: data!))
        }
        task.resume()
    }
    
}
