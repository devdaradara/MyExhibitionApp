//
//  ContentView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//
import SwiftUI

struct ContentView: View {
    @StateObject var exhibitionService = ExhibitionService()
    @State var categoryType: String = ""
    @State var titleName: String = ""

    var body: some View {
        VStack {
            if let exhibition = exhibitionService.exhibition {
                NavigationView {
                    VStack {
                        Text("Seoul Cultural Events")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        Picker(selection: $categoryType, label: Text("Category")) {
                            Text("전체").tag("")
                            Text("전시").tag("전시")
                            Text("국악").tag("국악")
                            Text("뮤지컬").tag("뮤지컬")
                            Text("콘서트").tag("콘서트")
                            Text("기타").tag("기타")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                        
                        List(exhibition.culturalEventInfo.row.filter({
                            if categoryType == "" {
                                return true
                            } else {
                                return $0.codename.contains(categoryType)
                            }
                        }), id: \.title) { row in
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
            }
        }
        .onAppear {
            exhibitionService.getInformation()
        }
        .scrollContentBackground(.hidden)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


