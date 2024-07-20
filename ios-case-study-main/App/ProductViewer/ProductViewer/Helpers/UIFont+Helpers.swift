//
//  Copyright © 2022 Target. All rights reserved.
//
import UIKit

extension UIFont {
    static var small: UIFont {
        UIFont(name: "helvetica", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }

    static var medium: UIFont {
        UIFont(name: "helvetica", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    }

    static var largeBold: UIFont {
        UIFont(name: "helvetica-bold", size: 21.0) ?? UIFont.boldSystemFont(ofSize: 21.0)
    }
    
    enum Details {
        static var title: UIFont {
            UIFont(name: "helvetica", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        }
        
        static var emphasis: UIFont {
            UIFont(name: "helvetica-bold", size: 18.0) ?? UIFont.boldSystemFont(ofSize: 18.0)
        }
        
        static var copy2: UIFont {
            UIFont(name: "helvetica", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        }
    }
    
    enum Deals {
        static var largeBold: UIFont {
            UIFont.boldSystemFont(ofSize: 21.0)
        }
        
        static var regular: UIFont {
            UIFont.systemFont(ofSize: 12.0)
        }
        
        static var medium: UIFont {
            UIFont.systemFont(ofSize: 14.0)
        }
        
        static var copy: UIFont {
            UIFont.systemFont(ofSize: 16.0)
        }
        
        static var title: UIFont {
            UIFont.systemFont(ofSize: 18.0)
        }
        
        static var boldTitle: UIFont {
            UIFont.boldSystemFont(ofSize: 18.0)
        }
    }
}
