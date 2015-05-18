//
//  Double+Format.swift
//  Calculator
//
//  Created by Todd Laney on 5/7/15.
//  Copyright (c) 2015 Todd Laney. All rights reserved.
//

import Foundation

extension Double
{
    func format(min:Int, max:Int) -> String
    {
        let nf = NSNumberFormatter()
        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        nf.minimumFractionDigits = min
        nf.maximumFractionDigits = max
        return nf.stringFromNumber(self) ?? "?"
    }
    
    func format(min:Int) -> String
    {
        return self.format(min, max: Int(DBL_DIG))
    }
    
    func format(fmt:String) -> String
    {
        return String(format:fmt, self)
    }
}
