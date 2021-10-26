//
//  common-homebutton.swift
//  ShareCalender
//
//  Created by 田野恭一 on 2021/07/14.
//

import SwiftUI

struct common_homebutton: View {
    //ボタンの画像や文字の変更させるための変数
    var imagename : String
    var textname : String
    //画像の色を変える変数
    var fontred : Double
    var fontblue : Double
    var fontgreen : Double
    //画像のバックカラーを変える変数
    var backred : Double
    var backblue : Double
    var backgreen : Double
    //sheetを使うための変数
    @State var calenderpage = false
    @State var memopage = false
    @State var addpage = false
    @State var searchpage = false
    @State var setpage = false
    
    var body: some View {
        VStack{
            Button(action: {
                //各項目で分岐してそれに応じたsheetを表示する
                if(textname == "カレンダー"){
                    self.calenderpage = true
                }else if(textname == "メモ"){
                    self.memopage = true
                }else if(textname == "作成"){
                    self.addpage = true
                }else if(textname == "検索"){
                    self.searchpage = true
                }else if(textname == "設定"){
                    self.setpage = true
                }
                
            }) {
                HStack{
                    Image(systemName: imagename)
                        .padding(.all)
                        .foregroundColor(Color.init(red: fontred/255, green: fontgreen/255, blue: fontblue/255))
                        .background(Color.init(red: backred/255, green: backgreen/255, blue: backblue/255))
                        .cornerRadius(60)
                }
            }
            .frame(width: 10, height: 10, alignment: .center)
            .padding(20)
            .sheet(isPresented: $calenderpage){
                CalenderView()  //カレンダーページを表示
            }
            .sheet(isPresented: $memopage){
                MemoView()      //メモページを表示
            }
            .sheet(isPresented: $addpage){
                AddView()       //作成ページを表示
            }
            .sheet(isPresented: $searchpage){
                SearchView()    //検索ページを表示
            }
            .sheet(isPresented: $setpage){
                SettingView()    //設定ページを表示
            }
            
            Text(textname)
                .font(.system(size: 12))
            
        }.frame(width: 75, height: 50)
    }
}
