//
//  TextTapTableViewCell.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import UIKit

typealias TapHandler = (CGPoint, CGSize)->()

class TextTapTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel?
    var stringPresenter: StringPresenter?{
        didSet{
            label?.attributedText = stringPresenter?.attributedText
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(gestureRecognizer:)))
        self.label?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func didTap(gestureRecognizer: UITapGestureRecognizer){
        guard let label = self.label else { return }
        self.stringPresenter?.recognizeWord(at: gestureRecognizer.location(ofTouch: 0, in: label), inBoxOfSize: label.frame.size, lineBreakMode: label.lineBreakMode)
    }
}
