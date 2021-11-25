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
                        db.collection("user").document("\(userID)").getDocument { (snap, error) in
                            if let error = error {
                                fatalError("\(error)")
                            }
                            guard let data = snap?.data() else { return }
                            print(data["name"]!)
                            user = data["name"]! as! String
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
            //スライドバーの表示・非表示を制御する
            SideMenu(isOpen: $isOpenSideMenu, username: $user)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct HomeMenu_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenu()
    }
}

//MARK: スライドバー実装
struct SideMenu: View{
    @Binding var isOpen:Bool    //サイドメニューが開いているか
    @Binding var username:String
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
                    Spacer().frame(height: 5)
                    Text(username)
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
