//
//  Date.swift
//  TaskIt
//
//  Created by Jacky Poon on 2015-01-06.
//  Copyright (c) 2015 somedev. All rights reserved.
//

import Foundation

class Date
{
    class func from (#year : Int, month : Int, day: Int) -> NSDate
    {
        var components : NSDateComponents
        components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        // this is an optional and it might return null
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        // need to execute only if null is not returned - this is optional chaining
        var date = gregorianCalendar?.dateFromComponents(components)
        // force the unwrap
        return date!
    }
    
    class func toString(#date: NSDate) -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        return dateString
    }
}