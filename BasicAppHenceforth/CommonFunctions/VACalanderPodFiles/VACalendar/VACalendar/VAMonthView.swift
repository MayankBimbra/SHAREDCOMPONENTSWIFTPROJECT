//
//  VAMonthView.swift
//  VACalendar
//
//  Created by Anton Vodolazkyi on 20.02.18.
//  Copyright © 2018 Vodolazkyi. All rights reserved.
//

import UIKit

protocol VAMonthViewDelegate: class {
    func dayStateChanged(_ day: VADay, in month: VAMonth)
    func didSelectAllTheDays(_ days:[VADay])
    func didDeselectAll(_ day: VADay)
}

@objc
public protocol VAMonthViewAppearanceDelegate: class {
    @objc optional func leftInset() -> CGFloat
    @objc optional func rightInset() -> CGFloat
    @objc optional func verticalMonthTitleFont() -> UIFont
    @objc optional func customFont() -> UIFont
    @objc optional func customColor() -> UIColor
    @objc optional func verticalMonthTitleColor() -> UIColor
    @objc optional func verticalCurrentMonthTitleColor() -> UIColor
    @objc optional func verticalMonthDateFormater() -> DateFormatter
}

class VAMonthView: UIView {
    
    var numberOfWeeks: Int {
        return month.numberOfWeeks
    }
    
    var isDrawn: Bool {
        return !weekViews.isEmpty
    }
    
    var scrollDirection: VACalendarScrollDirection {
        return (superview as? VACalendarView)?.scrollDirection ?? .horizontal
    }
    
    var monthVerticalHeaderHeight: CGFloat {
        return (superview as? VACalendarView)?.monthVerticalHeaderHeight ?? 0.0
    }
    
    var superviewWidth: CGFloat {
        return superview?.frame.width ?? 0
    }
    
    weak var monthViewAppearanceDelegate: VAMonthViewAppearanceDelegate? {
        return (superview as? VACalendarView)?.monthViewAppearanceDelegate
    }
    
    weak var dayViewAppearanceDelegate: VADayViewAppearanceDelegate? {
        return (superview as? VACalendarView)?.dayViewAppearanceDelegate
    }
    
    weak var delegate: VAMonthViewDelegate?

    let month: VAMonth
    
    private let showDaysOut: Bool
    private var monthLabel = UILabel()
    private var blockButton = UIButton()
    private var weekViews = [VAWeekView]()
    private let weekHeight: CGFloat
    private var viewType: VACalendarViewType
    
    init(month: VAMonth, showDaysOut: Bool, weekHeight: CGFloat, viewType: VACalendarViewType) {
        self.month = month
        self.showDaysOut = showDaysOut
        self.weekHeight = weekHeight
        self.viewType = viewType
        
        super.init(frame: .zero)
        blockButton.isHidden = true
        backgroundColor = .clear
        blockButton.setTitle("Block this month", for: .normal)
        monthsData = self.month
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWeeksView(with type: VACalendarViewType) {
        guard isDrawn == false else { return }
    
        self.viewType = type
        
        if scrollDirection == .vertical {
            setupMonthLabel()
            setupBlockMonthBtn()
        }

        self.weekViews = []

        month.weeks.enumerated().forEach { index, week in
            let weekView = VAWeekView(week: week, showDaysOut: showDaysOut)
            weekView.delegate = self
            self.weekViews.append(weekView)
            self.addSubview(weekView)
        }
        
        draw()
    }
    
    func clean() {
        //monthLabel = nil
        weekViews = []
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func week(with date: Date) -> VAWeekView? {
        return weekViews.first(where: { $0.contains(date: date) })
    }

    private func draw() {
        let leftInset = monthViewAppearanceDelegate?.leftInset?() ?? 0
        let rightInset = monthViewAppearanceDelegate?.rightInset?() ?? 0
        let initialOffsetY = self.monthLabel.frame.maxY ?? 0
        let weekViewWidth = self.frame.width - (leftInset + rightInset)
        
        var x: CGFloat = leftInset
        var y: CGFloat = initialOffsetY

        weekViews.enumerated().forEach { index, week in
            switch viewType {
            case .month:
                week.frame = CGRect(
                    x: leftInset,
                    y: y,
                    width: weekViewWidth,
                    height: self.weekHeight
                )
                y = week.frame.maxY
                
            case .week:
                let width = self.superviewWidth - (leftInset + rightInset)

                week.frame = CGRect(
                    x: x,
                    y: initialOffsetY,
                    width: width,
                    height: self.weekHeight
                )
                x = week.frame.maxX + (leftInset + rightInset)
            }
            week.setupDays()
        }
    }
    
    private func setupMonthLabel() {
        let textColor = month.isCurrent ? monthViewAppearanceDelegate?.verticalCurrentMonthTitleColor?() :
            monthViewAppearanceDelegate?.verticalMonthTitleColor?()
				let textFormatter = monthViewAppearanceDelegate?.verticalMonthDateFormater?() ?? VAFormatters.monthFormatter
        
        //monthLabel = UILabel()
        let kDate = month.date// + 86400
        monthLabel.text = textFormatter.string(from: kDate)
        monthLabel.textColor = textColor ?? monthLabel.textColor
        monthLabel.font = monthViewAppearanceDelegate?.verticalMonthTitleFont?() ?? monthLabel.font
        monthLabel.sizeToFit()
        monthLabel.center.x = center.x
        addSubview(monthLabel ?? UIView())
    }
    
    private func setupBlockMonthBtn(){
        let textColor = month.isCurrent ? monthViewAppearanceDelegate?.verticalCurrentMonthTitleColor?() :
        monthViewAppearanceDelegate?.verticalMonthTitleColor?()
        blockButton.setTitleColor(textColor, for: .normal)
        blockButton.titleLabel?.font = monthViewAppearanceDelegate?.customFont?()
        blockButton.setTitleColor(monthViewAppearanceDelegate?.customColor?(), for: .normal)
        blockButton.frame = CGRect(x: (monthLabel.frame.midX)+60, y: (monthLabel.frame.midY)-14, width: 140, height: 30)
        let monthInt = Calendar.current.dateComponents([.month], from: month.date)
        //Calendar.current.date(byAdding: .year, value: 1, to: Date())
        print(monthInt.month!)
        blockButton.tag = monthInt.month ?? 0
        blockButton.addTarget(self, action: #selector(btnActBlockThisMonth(_:)), for: .touchUpInside)
        addSubview(blockButton ?? UIView())
    }
    
}

extension VAMonthView: VAWeekViewDelegate {
    
    func dayStateChanged(_ day: VADay, in week: VAWeek) {
        delegate?.dayStateChanged(day, in: month)
    }
    
}

extension VAMonthView{
    public func changeBtnTitle(_ day: VADay, months: VAMonth){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            
            print(Date().startOfMonth())     // "2018-02-01 08:00:00 +0000\n"
            print(Date().endOfMonth())
            
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
            let startOfMonth = Calendar.current.date(from: comp)!
            print(dateFormatter.string(from: startOfMonth))
            
            var comps2 = DateComponents()
            comps2.month = 1
            comps2.day = -1
            let endOfMonth = Calendar.current.date(byAdding: comps2, to: startOfMonth)
            print(dateFormatter.string(from: endOfMonth!))
            
            let components = Calendar.current.dateComponents([.day], from: Date(), to: endOfMonth!)
            let numberOfDays = components.day ?? 0
            let dates = (0...numberOfDays).compactMap {
                return Calendar.current.date(byAdding: .day, value: $0, to: Date())
            }
            var allMonths = months.allDays()
            var valuseOfselected : [VADay] = [VADay]()

//            let availability = DaysAvailability.some(dates)
            
            for indValue in dates{
                valuseOfselected.append(contentsOf: self.month.days(for: [indValue]))
            }
            
            if dateFormatter.string(from:months.lastMonthDay) == dateFormatter.string(from: endOfMonth!){
                allMonths = valuseOfselected
            }
            
            if self.month.allDays() == months.allDays(){
                var allSelected = true

                for indvalue in allMonths{
                    
                    if !indvalue.isSelected{
                        allSelected = false
                    }
                }
                
                if allSelected{
                    self.blockButton.setTitle("Unblock this month", for: .normal)
                }else{
                    self.blockButton.setTitle("Block this month", for: .normal)
                }
            }
        })
    }

    
    @objc func btnActBlockThisMonth(_ sender : UIButton){
        let currentMnth = Calendar.current.date(byAdding: .month, value: 0, to: Date())
        _ = month.allDays()
        _ = month.days(for: [currentMnth!])
        var date = month.date // first date 5-2-2019
        let endDate = month.lastMonthDay // last date 10-2-2019
        var selectedDates: [Date] = [Date]()
        
        var valuseOfselected : [VADay] = [VADay]()
        
        selectedDates.append(date)
        while date < endDate {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            selectedDates.append(date)
        }
        
        for indValue in selectedDates{
            valuseOfselected.append(contentsOf: month.days(for: [indValue]))
        }
        
        if sender.currentTitle == "Block this month"{
            self.delegate?.didSelectAllTheDays(valuseOfselected)
            sender.setTitle("Unblock this month", for: .normal)
        }else{
            for dt in valuseOfselected{
                self.delegate?.didDeselectAll(dt)
                sender.setTitle("Block this month", for: .normal)
            }
           
        }
        
    }
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: 0), to: self.startOfMonth())!
    }
    

}

 
