//
//  UIButton+Extension.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/13.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

      let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

      UIGraphicsBeginImageContext(minimumSize)

      if let context = UIGraphicsGetCurrentContext() {
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: minimumSize))
      }

      let colorImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      self.clipsToBounds = true
      self.setBackgroundImage(colorImage, for: forState)
    }
}
