//
//  HomeMenu.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/05.
//

import SwiftUI
import Firebase

//MARK: ホーム画面
struct HomeMenu: View {
    @State var isOpenSideMenu: Bool = false //スライドバーのフラグ
    @State private var user = ""
    @State private var birthday = ""
    
    //databeseに接続
    let db = Firestore.firestore()
    // ログインしているユーザーのUIDを取得
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        ZStack {
            VStack{
                HStack {
                    Button(action:{
                        // ボタンをタップするとドロワーを開く
                        self.isOpenSideMenu.toggle()
                        //データベースアクセス。値を代入
                        db.collection("user").document("\(userID)").getDocument { (snap, error) in
                            if let error = error {
                                fatalError("\(error)")
                            }
                            guard let data = snap?.data() else { return }
                            print(data["name"]!)
                            print(data["birthday"]!)
                            user = data["name"]! as! String
                            birthday = data["birthday"] as! String
                        }
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
                Spacer().frame(height: 70)
            }
            FloatingButton()
            //スライドバーの表示・非表示を制御する
            SideMenu(isOpen: $isOpenSideMenu, username: $user, birthday: $birthday)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

//MARK: ホーム画面右下のボタン
struct FloatingButton: View {
    @State var addview = false
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    print("Tapped!!")
                    addview.toggle()
                    
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                })
                .frame(width: 60, height: 60)
                .background(Color(red: 66/255, green: 237/255, blue: 51/255, opacity: 0.5))
                .cornerRadius(30.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                .sheet(isPresented: $addview){
                    AddView()
                }
            }
        }
    }
}

//MARK: スライドバー実装
struct SideMenu: View{
    @Binding var isOpen:Bool        //サイドメニューが開いているか
    @Binding var username:String    //ユーザ名が格納
    @Binding var birthday:String    //誕生日が格納
    @State var settingview = false  //設定ビューを開くための設定
    //スライドバーのサイズ指定
    let width: CGFloat = 300
    
    var body: some View{
        ZStack{
            //背景部分
            GeometryReader { geometry in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .opacity(1.0)
            .animation(.easeIn(duration: 0.25))
            .onTapGesture {
                self.isOpen = false
            }
            // リスト部分
            HStack {
                VStack{
                    //ユーザ名及び設定ボタンデザイン
                    HStack {
                        Spacer().frame(width: 25)
                        VStack{
                            Spacer()
                            //ユーザ名
                            Text("\(username)")
                                .foregroundColor(Color.white)
                                .font(.system(size: 28))
                            //誕生日
                            Text("\(birthday)")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                            Spacer().frame(height: 7)
                        }
                        Spacer()
                        VStack{
                            Spacer()
                            Button(action: {
                                settingview.toggle()  //settingviewのflag変更
                            }, label: {
                                Image(systemName: "gearshape")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30))
                            }).sheet(isPresented: $settingview){
                                SettingView(username: $username, birthday: $birthday)
                            }.padding()
                        }
                        Spacer().frame(width:20)
                    }
                    .frame(width: width, height: 125)
                    .background(Color(red: 66/255, green: 237/255, blue: 51/255, opacity: 0.7))
                    Spacer().frame(height: 25)
                    //メモ帳を開くボタン
                    HStack{
                        Button(action: {
                            print("メモ帳ボタンクリック")
                        }, label: {
                            Text("メモ帳")
                            Spacer().frame(width: 30)
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 25))
                        }).foregroundColor(Color.black)
                    }
                    Spacer()
                    
                }
                .frame(width: width)
                .background(Color(UIColor.systemGray6))
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.easeIn(duration: 0.25))
                Spacer()
            }
        }
    }
}

//プレビュー
struct HomeMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
        SideMenu(isOpen: .constant(true), username: .constant("ユーザ名"), birthday: .constant("誕生日"))
    }
}
