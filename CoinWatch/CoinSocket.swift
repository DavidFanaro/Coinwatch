//
//  CoinSocket.swift
//  CoinWatch
//
//  Created by David Fanaro on 8/3/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//
import SwiftUI
import Combine


class CoinSocket: ObservableObject{
    
    @Published var coin: Coin?
    
    
    let urlString = "wss://ws.coincap.io/prices?assets=bitcoin"
    
    
    func recieve(){
        
        guard let url = URL(string:urlString) else {return}
        
        
        let task = URLSession(configuration: .default).webSocketTask(with: url)
        
        task.receive{ res in
            
            switch res{
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let mess):
                
                switch mess {
                case .string(let message):
                    guard let data = message.data(using: .utf8) else {return}
                    var json = try? JSONDecoder().decode(Coin.self, from: data)
                    DispatchQueue.main.async {
                        self.coin = json
                    }
                case .data(let data):
                    print("data")
                    
                    
                    
                @unknown default:
                    fatalError()
                }
                
                //print(mess)
            }
            
            self.recieve()
        }
        
        task.resume()
        
    }
    
}

struct Coin: Codable {
    let bitcoin: String
}
