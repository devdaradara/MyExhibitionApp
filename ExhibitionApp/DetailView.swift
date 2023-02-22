//
//  DetailView.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/22.
//

import SwiftUI

struct DetailView: View {
    var selectRow: Row
    
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
            showMoreDetail(infoTitle: "홈페이지 주소", information: selectRow.orgLink)
            showMoreDetail(infoTitle: "신청일", information: selectRow.rgstdate)
        }
        .padding([.top], 30)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let row = Row(codename: "전시/미술", guname: "구로구", title: "특별기획전 ‘공장도시: 팩토리타임즈’", date: "2023-12-28~2023-03-12", place: "서울시 구로구 디지털로26길 38, G-Tower 3층", orgName: "", useTrgt: "", useFee: "", player: "", program: "", etcDesc: "", orgLink: "https://blog.naver.com/PostView.naver?blogId=museumg&logNo=222953328006&categoryNo=1&parentCategoryNo=1&from=thumbnailList", mainImg: "https://culture.seoul.go.kr/cmmn/file/getImage.do?atchFileId=6096c5f6d5d2475081b48bcf280dbfb4&thumb=Y", rgstdate: "2023-01-12", ticket: "기관", strtdate: "2023-12-28 00:00:00.0", endDate: "2023-03-12 00:00:00.0", themecode: "기타")
        DetailView(selectRow: row)
    }
}
