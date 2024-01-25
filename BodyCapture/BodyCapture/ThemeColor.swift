import UIKit

struct ThemeColor {
    //어두운 정도에 비례해서 숫자 증가
    static let blue1 = UIColor(hex: "#F0F5FF")
    static let blue2 = UIColor(hex: "#BCD3FF")
    static let blue3 = UIColor(hex: "#518CFF")
    static let blue4 = UIColor(hex: "#4484FF")
    //어두운 정도에 비례해서 숫자 증가
    static let gray1 = UIColor(hex: "#F7F7F7")
    static let gray2 = UIColor(hex: "#6E6E6E")
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}



