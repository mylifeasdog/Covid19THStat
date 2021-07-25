//
//  TimeInterval+Utility.swift
//  TimeInterval+Utility
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import Foundation

extension TimeInterval
{
    var minutes: TimeInterval
    {
        return 60.0 * self
    }
    
    var hours: TimeInterval
    {
        return 60.0 * minutes
    }
    
    var days: TimeInterval
    {
        return 24.0 * hours
    }
    
    var weeks: TimeInterval
    {
        return 7.0 * days
    }
    
    var months: TimeInterval
    {
        return 30.44 * days
    }
    
    var years: TimeInterval
    {
        return 365.24 * days
    }
}

extension IntegerLiteralType
{
    var minutes: TimeInterval
    {
        return TimeInterval(self).minutes
    }
    
    var hours: TimeInterval
    {
        return TimeInterval(self).hours
    }
    
    var days: TimeInterval
    {
        return TimeInterval(self).days
    }
    
    var weeks: TimeInterval
    {
        return TimeInterval(self).weeks
    }
    
    var months: TimeInterval
    {
        return TimeInterval(self).months
    }
    
    var years: TimeInterval
    {
        return TimeInterval(self).years
    }
}
