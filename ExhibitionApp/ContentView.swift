//
//  ContentView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//
import SwiftUI

struct ContentView: View {
    @StateObject var exhibitionService = ExhibitionService()
    
    enum Categories: String, CaseIterable, Identifiable {
        case 전체 = "전체"
        case 전시 = "전시/미술"
        case 국악 = "국악"
        case 뮤지컬 = "뮤지컬/오페라"
        case 콘서트 = "콘서트"
        case 문화교양 = "문화교양/강좌"
        case 무용 = "무용"
        case 영화 = "영화"
        case 클래식 = "클래식"
        case 독주 = "독주/독창회"
        case 기타 = "기타"
        
        var id: Self { self }
      }
    @State var categoryType = Categories.전체

    var body: some View {
        VStack {
            if let exhibition = exhibitionService.exhibition {
                NavigationView {
                    VStack {
                        Text("Seoul Cultural Events")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        HStack {
                            Text("Category")
                                .padding([.leading], 40)
                            
                            Picker(selection: $categoryType, label: Text("Category")) {
                                ForEach(Categories.allCases) { category in
                                    Text(category.rawValue)
                                        .tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .listRowInsets(EdgeInsets())
                            
                        }
                        
                        List(exhibition.culturalEventInfo.row.filter({
                            if categoryType == Categories.전체 {
                                return true
                            } else {
                                return $0.codename.contains(categoryType.rawValue)
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


