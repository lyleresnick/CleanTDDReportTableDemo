//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

extension UIColor {

    convenience init( rgb: Int ) {
        self.init( rgb: rgb, alpha: 1.0 )
    }
    
    convenience init( rgb: Int, alpha: CGFloat )  {
        self.init(
            red:   ((CGFloat)((rgb & 0xFF0000) >> 16))/255.0,
            green: ((CGFloat)((rgb & 0x00FF00) >>  8))/255.0,
            blue:  ((CGFloat)((rgb & 0x0000FF) >>  0))/255.0,
            alpha: alpha )
    }
}
