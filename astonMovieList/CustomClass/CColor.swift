import UIKit

enum ColorsEnum: String {
    
    case primaryTen = "primary-10"
    case warningTen = "warning-10"
    case cyanTen = "cyan-10"
    case dangerTen = "danger-10"
    case infoTen = "info-10"
    case successTen = "success-10"
    case violetTen = "violet-10"
}


final class CColor: UIColor {
    
    static let custWhite = CColor(hex: "#FFFFFF")
    static let custBlack = CColor(hex: "#1a1a1a")
    static let custRed = CColor(hex: "#FF3044")
    static let custBlue = CColor(hex: "#2688EB")
    static let custDarkGray = CColor(hex: "#949494")
    static let custLightGray = CColor(hex: "#EFEFEF")
    
    static func getColorName(color: ColorsEnum) -> UIColor {
        switch color {
        case .primaryTen:
            return CColor(hex: "#1A81FA")
        case .warningTen:
            return CColor(hex: "#EB8C00")
        case .cyanTen:
            return CColor(hex: "#00919B")
        case .dangerTen:
            return CColor(hex: "#FF3D33")
        case .infoTen:
            return CColor(hex: "#008BCC")
        case .successTen:
            return CColor(hex: "#11A768")
        case .violetTen:
            return CColor(hex: "#452799")
        }
    }
    
    
    public convenience init(hex: String) {
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        if ((cString.count) == 8) {
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat((rgbValue & 0x0000FF)) / 255.0
            a = CGFloat((rgbValue & 0xFF000000)  >> 24) / 255.0
            
        } else if ((cString.count) == 6) {
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat((rgbValue & 0x0000FF)) / 255.0
            a = CGFloat(1.0)
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
