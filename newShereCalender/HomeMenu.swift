//
//  HomeMenu.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/05.
//

import SwiftUI

struct HomeMenu: View {
    var body: some View {
        VStack{
            HStack {
                Button(action:{
                    // ボタンをタップするとドロワーを開く
                }) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(Color.init(red: 68/255, green: 210/255, blue: 115/255))
                        .font(.system(size:17))
                }
                Spacer()
                Text("カレンダー").padding().font(.system(size:20))
                Spacer()
            }.padding()
            Spacer()
            CalenderView()
            Spacer().frame(height: 50)
            //下に配置するボタンの表示
            HStack{
                
                common_homebutton(imagename: "calendar", textname: "カレンダー", fontred: 68, fontblue: 115, fontgreen: 210, backred: 172, backblue: 199, backgreen: 254)
                    
                common_homebutton(imagename: "square.and.pencil", textname: "メモ", fontred: 68, fontblue: 115, fontgreen: 210, backred: 172, backblue: 199, backgreen: 254)
                common_homebutton(imagename: "plus", textname: "作成", fontred: 244, fontblue: 244, fontgreen: 244, backred: 26, backblue: 103, backgreen: 203)
                common_homebutton(imagename: "globe", textname: "検索", fontred: 68, fontblue: 115, fontgreen: 210, backred: 172, backblue: 199, backgreen: 254)
                common_homebutton(imagename: "gearshape", textname: "設定", fontred: 68, fontblue: 115, fontgreen: 210, backred: 172, backblue: 199, backgreen: 254)
            }
        }
    }
}

struct HomeMenu_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenu()
    }
}
