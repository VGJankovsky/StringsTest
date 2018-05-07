//
//  StringPresenter.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import CoreGraphics
import UIKit
import Foundation

extension Notification.Name {
    static let recognizedWord = Notification.Name( rawValue: "recognizedWord")
}

let RecognizedWordKey = "RecognizedWordKey"

class StringPresenter{
    private let text: String
    lazy var attributedText: NSAttributedString = {
        let attributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),
                            NSAttributedStringKey.foregroundColor: UIColor.gray ]
        return NSAttributedString(string: self.text, attributes: attributes)
    }()
    
    lazy var words: [String] = {
        return text.components(separatedBy: CharacterSet(charactersIn:" "))
    }()
    
    init(text: String) {
        self.text = text
    }
    
    func recognizeWord(at point: CGPoint, inBoxOfSize size: CGSize, lineBreakMode: NSLineBreakMode){
        let words = self.words
        let text = self.text
        let attributedText = self.attributedText
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            let textStorage = NSTextStorage(attributedString: attributedText)
            let layoutManager = NSLayoutManager()
            textStorage.addLayoutManager(layoutManager)
            let textContainer = NSTextContainer(size: size)
            textContainer.lineFragmentPadding = 0
            textContainer.lineBreakMode = lineBreakMode
            layoutManager.addTextContainer(textContainer)
            
            for word in words{
                guard let rangeOfWord = text.range(of: word) else { continue }
                
                var actualGlyphRange = NSRange.init()
                let nsRangeOfWord = NSRange(rangeOfWord, in: text)
                layoutManager.characterRange(forGlyphRange: nsRangeOfWord, actualGlyphRange:&actualGlyphRange)
                let glyphRect = layoutManager.boundingRect(forGlyphRange: actualGlyphRange, in: textContainer)
                
                if glyphRect.contains(point){
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .recognizedWord, object: nil, userInfo: [RecognizedWordKey: word])
                    }
                    break
                }
            }
        }
        
    }
}
