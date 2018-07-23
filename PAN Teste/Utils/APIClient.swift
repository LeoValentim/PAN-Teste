//
//  APIClient.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Alamofire

class APIClient {
    static let baseUrl = "https://api.twitch.tv/kraken"
    
    static func get<T: Codable>(_ url: String, model: T.Type, onSuccess: @escaping (T?) -> Void, onFailure: ((Error) -> Void)? = nil) {
        guard let _url = URL(string: url) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.twitchtv.v5+json",
            "Client-ID": Constants.Twitch.clientId
        ]
        
        request(_url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    return
                }
                
                do {
                    let resultObjc = try JSONDecoder().decode(model, from: data)
                    onSuccess(resultObjc)
                } catch {
                    onFailure?(error)
                }
            case .failure(let error):
                onFailure?(error)
            }
        }
    }
}
