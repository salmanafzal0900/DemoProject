//
//  Data.swift
//  talkMD-International-Provider
//
//  Created by Ahtazaz on 17/10/2020.
//  Copyright © 2020 Ahtazaz. All rights reserved.
//

import Foundation

extension Data {

    /// Append string to Data
    ///
    /// Rather than littering my code with calls to `data(using: .utf8)` to convert `String` values to `Data`, this wraps it in a nice convenient little extension to Data. This defaults to converting using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `Data`.

    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}


extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}



extension String{

  func allStringsBetween(start: String, end: String) -> [Any] {
            var strings = [Any]()
            var startRange: NSRange = (self as NSString).range(of: start)

            while true {
                if startRange.location != NSNotFound {
                    var targetRange = NSRange()
                    targetRange.location = startRange.location + startRange.length
                    targetRange.length = self.count - targetRange.location
                    let endRange: NSRange = (self as NSString).range(of: end, options: [], range: targetRange)
                    if endRange.location != NSNotFound {
                        targetRange.length = endRange.location - targetRange.location
                        strings.append((self as NSString).substring(with: targetRange))
                        var restOfString =  NSRange()
                        restOfString.location = endRange.location + endRange.length
                        restOfString.length = self.count - restOfString.location
                        startRange = (self as NSString).range(of: start, options: [], range: restOfString)
                    }
                    else {
                        break
                    }
                }
                else {
                    break
                }

            }
            return strings
        }

    }
