//
//  CalendarViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2019/03/23.
//  Copyright © 2019年 剱物蒼太. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic

class CalendarViewController: UIViewController,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    var datenumber: Int = 0
    @IBOutlet var day1: UILabel!
    @IBOutlet var day2: UILabel!
    @IBOutlet var day3: UILabel!
    var dates = [String]()
    var post = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar!.delegate = self
        self.calendar!.dataSource = self

    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func judgeHoliday(_ date : Date) -> Bool {
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectDay = Calendar(identifier: .gregorian)
        let year = selectDay.component(.year, from: date)
        let month = selectDay.component(.month, from: date)
        let day = selectDay.component(.day, from: date)
        if datenumber == 0 {
            day1.text = "\(year)/\(month)/\(day)"
            datenumber = datenumber + 1
            dates.append("\(year)/\(month)/\(day)")
        } else if datenumber == 1 {
            day2.text = "\(year)/\(month)/\(day)"
            datenumber = datenumber + 1
            dates.append("\(year)/\(month)/\(day)")
        } else if datenumber == 2 {
            day3.text = "\(year)/\(month)/\(day)"
            dates.append("\(year)/\(month)/\(day)")
        }
    }
    
    @IBAction func cancel() {
        day1.text = "Day1"
        day2.text = "Day2"
        day3.text = "Day3"
        dates = []
        datenumber = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostViewController" {
            let PostVC: PostViewController = segue.destination as! PostViewController
            let castedSender = sender as! ([Any], [String])
            PostVC.post = castedSender.0
            PostVC.dates = castedSender.1
        }
    }
    
    @IBAction func ok() {
        self.performSegue(withIdentifier: "toPostViewController", sender: (post,dates))
    }
}
