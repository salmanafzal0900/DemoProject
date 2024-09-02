//
//  String.swift
//  talkMD-International-Provider
//
//  Created by Ahtazaz on 03/10/2020.
//  Copyright © 2020 Ahtazaz. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    func isValidName()-> Bool {

           let RegEx = "^[A-Za-zء-ي ]+$" //"^\\w{7,18}$"
           let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
           return Test.evaluate(with: self)
        }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let emailRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#${'$'}${'*'}${'('}${')'}`~%^&+=]).{8,}$"
        //"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$" //  """^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#${'$'}${'*'}${'('}${')'}`~%^&+=]).{8,}$"""
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidUAEPhoneNumber() -> Bool {
        let emailRegEx = "^(?:\\+971|00971|971|0|)?(?:50|51|52|54|55|56|58)\\d{7}$" // for use number
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    
    static func isNilOrEmpty(string: String?) -> Bool {
           guard let value = string else { return true }
           return value.trimmingCharacters(in: .whitespaces).isEmpty
       }
    
    
    func getPhoneLength() -> Int {
        var mobileNumber = self
        mobileNumber = mobileNumber.replacingOccurrences(of: "(", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: ")", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "-", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "+", with: "")
        return mobileNumber.count
    }
    
    func getPhoneNo() -> String {
        var mobileNumber = self
        mobileNumber = mobileNumber.replacingOccurrences(of: "(", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: ")", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "-", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "+", with: "")
        return mobileNumber
    }
    
    
    func removeFormatCharactersFromPhoneNumber() -> String {
        var mobileNumber = self
        mobileNumber = mobileNumber.replacingOccurrences(of: "(", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: ")", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "-", with: "")
        mobileNumber = mobileNumber.replacingOccurrences(of: "+", with: "")
        
        let length = mobileNumber.count
        
        if length > 10 {
            var tempNumber = mobileNumber as NSString
            tempNumber = tempNumber.substring(to: length - 10) as NSString
            mobileNumber = tempNumber as String
        }
        
        return mobileNumber
    }
    
    func formatCellNo() -> String {
        let mutableString = NSMutableString(string: self)
        mutableString.insert("(", at: 0)
        mutableString.insert(")", at: 4)
        mutableString.insert(" ", at: 5)
        mutableString.insert("-", at: 9)
        return mutableString as String
    }
    
    func setAsSuperscript() -> NSMutableAttributedString
    {
        let font:UIFont? = UIFont(name: "Roboto-Regular", size: 22)
        let fontSuper:UIFont? = UIFont(name: "Roboto-Regular", size: 8)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: self, attributes: [.font:font!])
        let lastTwo = self.suffix(2)
        if lastTwo.uppercased() == "AM" || lastTwo.uppercased() == "PM" {
            attString.setAttributes([.font:fontSuper!, .baselineOffset:10], range: NSRange(location:self.count - 2,length:2))
        }
        return attString
    }
    
    var initials: String {
        return self.components(separatedBy: " ")
            .reduce("") {
                ($0.isEmpty ? "" : "\($0.first?.uppercased() ?? "")") +
                ($1.isEmpty ? "" : "\($1.first?.uppercased() ?? "")")
            }
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst().lowercased() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst().lowercased() }
    var onlyFirstCapitalized: String { return prefix(1).capitalized + dropFirst()}
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    
    var htmlToAttributedStringWithFontSize16: NSAttributedString? {
        guard var data = data(using: .utf8) else { return nil }
        do {
            data.append(String(format: "<style>body{font-family: 'Roboto-Regular'; font-size:16px; text-align: justify; line-height: 28px;}</style>"), using: .utf8)
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString
        } catch {
            return nil
        }
    }
    
    var htmlToAttributedStringWithFontSize16Alignment: NSAttributedString? {
        guard var data = data(using: .utf8) else { return nil }
        do {
            data.append(String(format: "<style>body{font-family: 'Roboto-Regular'; font-size:16px;; line-height: 28px;}</style>"), using: .utf8)
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString
        } catch {
            return nil
        }
    }
    
    var htmlToAttributedStringWithFontSize16AlignmentCenter: NSAttributedString? {
        guard var data = data(using: .utf8) else { return nil }
        do {
            data.append(String(format: "<style>body{font-family: 'Roboto-Regular'; font-size:15px;}</style>"), using: .utf8)
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString
        } catch {
            return nil
        }
    }
    
    
    var htmlToAttributedStringWithFont: NSAttributedString? {
        guard var data = data(using: .utf8) else { return nil }
        do {
            data.append(String(format: "<style>body{font-family: 'Roboto-Regular'; font-size:18px; text-align: justify; line-height: 28px;}</style>"), using: .utf8)
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString
        } catch {
            return nil
        }
    }
    var htmlToAttributedStringWithFontRightAllign: NSAttributedString? {
        guard var data = data(using: .utf8) else { return nil }
        do {
            data.append(String(format: "<style>body{font-family: 'Roboto-Regular'; font-size:18px; text-align: right; line-height: 28px;}</style>"), using: .utf8)
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString
        } catch {
            return nil
        }
    }
}

extension String {
    func getLinks() -> [NSTextCheckingResult] {
        let type: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: type.rawValue)

        guard let detect = detector else {
            return []
        }

        let matches = detect.matches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.count))
        
        return matches
    }
}

extension NSMutableAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) -> NSMutableAttributedString {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return self
        }
        return NSMutableAttributedString()
    }
}

extension NSAttributedString {

    /** Will Trim space and new line from start and end of the text */
    public func trimWhiteSpace() -> NSAttributedString {
        let invertedSet = CharacterSet.whitespacesAndNewlines.inverted
        let startRange = string.utf16.description.rangeOfCharacter(from: invertedSet)
        let endRange = string.utf16.description.rangeOfCharacter(from: invertedSet, options: .backwards)
        guard let startLocation = startRange?.upperBound, let endLocation = endRange?.lowerBound else {
            return NSAttributedString(string: string)
        }

        let location = string.utf16.distance(from: string.startIndex, to: startLocation) - 1
        let length = string.utf16.distance(from: startLocation, to: endLocation) + 2
        let range = NSRange(location: location, length: length)
        return attributedSubstring(from: range)
    }

}
