//
//  ContentView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            MainView()
                .tabItem {
                    Image(systemName: "film.circle.fill")
                    Text("Main")
                }
            
            HeartView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Heart")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


