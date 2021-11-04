//
//  CalenderView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/26.
//

import SwiftUI

import Firebase

struct CalenderView: View {
    //各曜日が格納された配列
    let dayofweek = ["日","月","火","水","木","金","土"]
    //日付、年、月が格納されている変数
    @State var year : Int = AppDelegate().year
    @State var month : Int = AppDelegate().month
    
    
    var body: some View{
        VStack {
            //トップ(今月の表示と先月、次月のリンクの表示)
            HStack {
                Spacer()
                Button(action: {
                    self.LastMonth()
                }, label: {
                    if(self.month != 1){
                        Text("\(self.month - 1)月")
                    }else{
                        Text("12月")
                    }
                })
                Spacer()
                Text("\(String(self.year))年\(self.month)月")
                    .font(.system(size: 20))
                Spacer()
                Button(action: {
                    self.NextMonth()
                }, label: {
                    if(self.month != 12){
                        Text("\(self.month + 1)月")
                    }else{
                        Text("1月")
                    }
                })
                Spacer()
            }
            //曜日の表示
            HStack {
                ForEach(0..<self.dayofweek.count){ index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width:50,height:40)
                            .foregroundColor(Color.clear)
                        Text(dayofweek[index])
                            .font(.system(size:16))
                    }
                }
            }
            Divider()       // 仕切り線の挿入
            //今月の日付の表示
            VStack (){
                CalendarList(year: $year, month: $month, week: CalendarModel().GetWeekNumber(year: self.year, month: self.month), start: CalendarModel().DayofWeekCalc(year: self.year, month: self.month, day: 1), days: CalendarModel().DayNumber(year: self.year, month: self.month))
            }
        }
    }
    func NextMonth(){
        if self.month != 12{
            self.month += 1
        }else if self.month == 12{
            self.year += 1
            self.month = 1
        }
    }
    
    func LastMonth(){
        if self.month != 1{
            self.month -= 1
        }else if self.month == 1{
            self.year -= 1
            self.month = 12
        }
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}

//日付を取得するためのclass
class AppDelegate: UIResponder, UIApplicationDelegate {
    // 年のみを取得
    let year : Int = Calendar.current.component(.year, from: Date())
    // 月のみを取得
    let month : Int = Calendar.current.component(.month, from: Date())
}
