//
//  ContentView.swift
//  CoinWatch
//
//  Created by David Fanaro on 8/3/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var socket = CoinSocket()
    
    var body: some View {
        VStack {
            Text("\(socket.coin?.bitcoin ?? "Error")")
        }.onAppear{
            self.socket.recieve()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
