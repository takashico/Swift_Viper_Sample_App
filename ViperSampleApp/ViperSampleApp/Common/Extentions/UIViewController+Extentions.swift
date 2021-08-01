//
//  UIViewController+Extentions.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import Foundation
import UIKit

protocol StoryBoardHelper {}

extension StoryBoardHelper where Self: UIViewController {
    static func instantiate() -> Self {
        // Storyboardの名前は"XXXViewController"の場合"XXX"のため"ViewController"部分の文字列を除去
        let storyboardName = (self.className).replacingOccurrences(of: "ViewController", with: "")
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as! Self
    }
}

extension UIViewController: StoryBoardHelper {}
