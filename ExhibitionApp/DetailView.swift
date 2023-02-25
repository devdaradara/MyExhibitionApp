//
//  DetailView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/22.
//

import SwiftUI

struct DetailView: View {
    @State var selectRow: Row
    @State var isFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                Spacer()
                
                GeometryReader { geo in
                    AsyncImage(url: URL(string: selectRow.mainImg)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width, height: geo.size.width * 1.33)
                    .cornerRadius(12)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 450, trailing: 20))
                
                Text(selectRow.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing], 10)

                Text(selectRow.date)
                    .font(.headline)
                
                Text(selectRow.place)
                    .font(.headline)
                    
                InformationView(selectRow: selectRow)
                
            }
        }
        .navigationBarItems(
            trailing: HStack {
                
                Button(action: {
                    isFavorite.toggle()
                    if isFavorite {
                        FavoriteManager.shared.saveFavorite(row: selectRow)
                    } else {
                        FavoriteManager.shared.removeFavorite(row: selectRow)
                    }
                    print("Favorite changed: \(selectRow.isFavorite)")
                }, label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                })
                
                Button(action: {
                    if let encodedString = "https://www.google.com/maps/search/?api=1&query=\(selectRow.place)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: encodedString) {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text("지도")
                        .font(.headline)
                        .foregroundColor(.blue)
                })
                
                Button(action: {
                    UIApplication.shared.open(URL(string: selectRow.orgLink)!)
                }, label: {
                    Text("홈페이지")
                        .font(.headline)
                        .foregroundColor(.blue)
                })
            }
        )
        .onAppear {
            isFavorite = FavoriteManager.shared.isFavorite(row: selectRow)
        }
    }
}


struct showMoreDetail: View {
    
    @State var canShow = false
    var infoTitle: String
    var information: String
    
    var body: some View {
        if information != "" {
            DisclosureGroup(infoTitle, isExpanded: $canShow) {
                Text(information)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(10)
                    .foregroundColor(.gray)
                    .padding([.top], 10)
                }
            .padding([.leading, .trailing], 30)
            .foregroundColor(.black)
        }
    }
}

struct InformationView: View {
    var selectRow: Row
    
    var body: some View {
        VStack {
            showMoreDetail(infoTitle: "기관명", information: selectRow.orgName)
            showMoreDetail(infoTitle: "이용 대상", information: selectRow.useTrgt)
            showMoreDetail(infoTitle: "이용 요금", information: selectRow.useFee)
            showMoreDetail(infoTitle: "출연자 정보", information: selectRow.player)
            showMoreDetail(infoTitle: "프로그램 소개", information: selectRow.program)
            showMoreDetail(infoTitle: "기타 내용", information: selectRow.etcDesc)
            showMoreDetail(infoTitle: "신청일", information: selectRow.rgstdate)
        }
        .padding([.top], 30)
    }
}
