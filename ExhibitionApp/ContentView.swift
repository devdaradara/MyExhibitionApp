//
//  ContentView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//
import SwiftUI

struct ContentView: View {
    @StateObject var exhibitionService = ExhibitionService()

    var body: some View {
        VStack {
            if let exhibition = exhibitionService.exhibition {
                Text("Seoul Cultural Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                List(exhibition.culturalEventInfo.row, id: \.title) { row in
                    VStack(alignment: .leading) {
                        Text(row.title)
                            .font(.headline)
                        Text(row.place)
                            .font(.subheadline)
                        Text(row.date)
                            .font(.subheadline)
                    }
                }
            } else {
                ProgressView()
                    .padding()
            }
        }
        .onAppear {
            exhibitionService.getInformation()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
