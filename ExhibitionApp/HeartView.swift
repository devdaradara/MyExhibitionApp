//
//  HeartView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/24.
//

import SwiftUI

struct HeartView: View {
    @ObservedObject var exhibitionService = ExhibitionService()

    var body: some View {
        VStack {
            if let exhibition = exhibitionService.exhibition {
                NavigationView {
                    VStack {
                        Text("Seoul Cultural Events")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        List(exhibition.culturalEventInfo.row.filter({ $0.isFavorite }), id: \.title) { row in
                            NavigationLink(destination: DetailView(selectRow: row)) {
                                HStack {
                                    AsyncImage(url: URL(string: row.mainImg))
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                    
                                    VStack(alignment: .leading) {
                                        Text(row.title)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                                        
                                        Text(row.place)
                                            .font(.subheadline)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                                        
                                        Text(row.date)
                                            .font(.subheadline)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                ProgressView()
                    .onAppear {
                        exhibitionService.getInformation()
                    }
            }
        }
        .scrollContentBackground(.hidden)
    }
}


struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView()
    }
}
