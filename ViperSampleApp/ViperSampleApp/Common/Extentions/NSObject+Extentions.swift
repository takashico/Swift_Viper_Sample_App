//
//  NSObject+Extentions.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
