//
//  Copyright © 2022 Target. All rights reserved.
//
import UIKit

extension UIColor {
    static let grayDarkest = UIColor(hex: 0x333333)
    static let grayMedium = UIColor(hex: 0x888888)
    static let targetRed = UIColor(hex: 0xCC0000)
    static let targetTextGreen = UIColor(hex: 0x008300)
    static let textLightGray = UIColor(hex: 0x666666)
    static let thinBorderGray = UIColor(hex: 0xD6D6D6)
    static let background = UIColor(hex: 0xF7F7F7)
    static let black = UIColor(hex: 000000)
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
