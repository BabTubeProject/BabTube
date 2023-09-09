//
//  UITextView.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/08.
//

import UIKit

extension UITextView {
    var numLines: Int {
        guard let font else { return 1 }
        return Int(self.contentSize.height / (font.lineHeight))
    }
}
