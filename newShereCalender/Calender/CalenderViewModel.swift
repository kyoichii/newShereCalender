//
//  CalenderViewModel.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/11/04.
//

import Foundation

class CalendarModel :ObservableObject {
    // うるう年判定(trueがうるう年)
    func LeapYear(year:Int) -> Bool {
        let result =  (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0 )) ? true : false
        print(result)
        return result
    }
    
    // 曜日の計算(ツェラーの公式使用)
    func DayofWeekCalc(year:Int,month:Int,day:Int) -> Int{
        var result : Int = 0
        //monthが1,2の時は前年として計算をする
        if month == 1 || month ==  2 {
            var changeyear : Int = year
            var changemonth : Int = month
            changeyear -= 1
            changemonth += 12
            result  = (day + (26 * (changemonth + 1))/10 + changeyear + (changeyear / 4) + (5 * (changeyear / 100)) + ((changeyear / 100)/4) + 5) % 7 as Int
        }else{
            result  = (day + (26 * (month + 1))/10 + year + (year / 4) + (5 * (year / 100)) + ((year / 100)/4) + 5) % 7 as Int
        }
         print("\(result)")
        return result
    }
    
    
    // 週数計算
    func GetWeekNumber(year:Int,month:Int) -> Int {
        var result : Int = 0
        if CaseFourWeek(year: year, month: month){
            result = 4
        }else if CaseSixWeek(year: year, month: month){
            result = 6
        }else{
            result = 5
        }
        return result
    }
    
    // 週数4の場合
    private func CaseFourWeek(year:Int,month:Int) -> Bool {
        let firstdayofweek = DayofWeekCalc(year: year, month: month, day: 1)
        let result = (!LeapYear(year: year) && month == 2 && (firstdayofweek == 0)) ? true : false
        return result
    }
    
    // 週数6の場合
    private func CaseSixWeek(year:Int,month:Int) -> Bool{
        let firstdayofweek = DayofWeekCalc(year: year, month: month, day: 1)
        let days = DayNumber(year: year, month: month)
        let result = ((firstdayofweek == 6 && days == 30) || (firstdayofweek >= 5 && days == 31)) ? true : false
        return result
    }
    
    // 日数取得
    func DayNumber(year:Int,month:Int) -> Int{
        var result : Int = 0
        
        switch month {
        case 1,3,5,7,8,10,12:
            result = 31
        case 4,6,9,11:
            result = 30
        case 2:
            if LeapYear(year: year){
                result = 29
            }else{
                result = 28
            }
        default: break
        }
        
        return result
    }
}
