//
//  WebService.swift
//  CryptoWatch
//
//  Created by Ashish Sharma on 12/27/2022.
//

import Foundation

class WebService {
    
    //escaping closures are executed after the function returns. First the function will fetch URL request and then the CryptoCurrency will start.
    func downloadCurrencies(url: URL, completion: @escaping([CryptoCurrency]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error getting data from URL \(error)")
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                print(cryptoList)
                if let cryptoList = cryptoList{
                    completion(cryptoList)
                }
                
            }
        }.resume()
        
    }
    
    
    
}
