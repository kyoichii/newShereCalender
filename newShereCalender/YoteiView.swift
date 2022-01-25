//
//  YoteiView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2022/01/13.
//

import SwiftUI

//MARK:
struct YoteiView: View {
    //Sheetを閉じるために必要な変数
    @Environment(\.presentationMode) var presentationMode
    //送られてきた日付が格納されている
    @Binding var date:String
    @Binding var yotei:String
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    //Sheetを閉じる処理
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .font(.system(size:30))
                        .foregroundColor(Color.black)
                        .padding()
                })
                Text(date + "の予定")
                    .font(.system(size: 22))
                    .padding()
                Spacer()
            }
            List{
                Text(yotei)
            }
            //ここに登録している予定を掲載予定。
            Spacer()
        }
    }
}

struct YoteiView_Previews: PreviewProvider {
    static var previews: some View {
        YoteiView(date: .constant("◯◯◯◯年◯月◯日"), yotei: .constant("予定1"))
    }
}
