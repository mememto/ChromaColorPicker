//
//  UIColor+Utilities.swift
//
//  Copyright © 2016 Jonathan Cardasis. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
public extension UIColor {

    var hexCode: String {

        let colorComponents = self.cgColor.components!
        if colorComponents.count < 4 {

            return String(format: "%02x%02x%02x", Int(colorComponents[0]*255.0), Int(colorComponents[0]*255.0), Int(colorComponents[0]*255.0)).uppercased()
        }
        return String(format: "%02x%02x%02x", Int(colorComponents[0]*255.0), Int(colorComponents[1]*255.0), Int(colorComponents[2]*255.0)).uppercased()
    }

    //Amount should be between 0 and 1
    func lighterColor(_ amount: CGFloat) -> UIColor {

        return UIColor.blendColors(color: self, destinationColor: UIColor.white, amount: amount)
    }

    func darkerColor(_ amount: CGFloat) -> UIColor {

        return UIColor.blendColors(color: self, destinationColor: UIColor.black, amount: amount)
    }

    static func blendColors(color: UIColor, destinationColor: UIColor, amount: CGFloat) -> UIColor {

        var amountToBlend = amount
        if amountToBlend > 1 {

            amountToBlend = 1.0
        } else if amountToBlend < 0 {

            amountToBlend = 0
        }

        var red, green, blue, alpha: CGFloat
        red = 0
        green = 0
        blue = 0
        alpha = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) //gets the rgba values (0-1)

        //Get the destination rgba values
        var destRed, destGreen, destBlue, destAlpha: CGFloat
        destRed = 0
        destGreen = 0
        destBlue = 0
        destAlpha = 0
        destinationColor.getRed(&destRed, green: &destGreen, blue: &destBlue, alpha: &destAlpha)

        red = amountToBlend * (destRed * 255) + (1 - amountToBlend) * (red * 255)
        green = amountToBlend * (destGreen * 255) + (1 - amountToBlend) * (green * 255)
        blue = amountToBlend * (destBlue * 255) + (1 - amountToBlend) * (blue * 255)
        alpha = abs(alpha / destAlpha)

        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
