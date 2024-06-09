
import UIKit

extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func makeShadowWithCornerRadius(radius: CGFloat)
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
        layer.cornerRadius = radius
    }
    
    
    func dropShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.1)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
}


@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
extension UITextField
{
    func setErrorStyle()
    {
        self.layer.cornerRadius = 20
        //   self.layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.red.cgColor
        
    }
    func removeErrorStyle()
    {
        self.layer.cornerRadius = 20
        //   self.layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
extension UIButton
{
    
//    func setRounded()
//    {
//        self.layer.cornerRadius = 20
//        //   self.layer.borderColor = UIColor.red.cgColor
//        self.clipsToBounds = true
//        self.layer.borderWidth = 0.2
//        self.layer.borderColor = UIColor.lightGray.cgColor
//    }
    
}
extension UICollectionViewCell {
    
    func makeTransformToTopAnimation()
    {
        transform = CGAffineTransform(translationX: 0, y: 200)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 10, height: 10)
        alpha = 0
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.5)
        transform = CGAffineTransform(translationX: 0, y: 0)
        alpha = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()
    }
    
    
    
    func homeListCellSHadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = 1.0
        contentView.layer.borderWidth = 0.2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true;
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.2)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
    }
    
    func invitationsListCellSHadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = 1.0
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true;
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.1)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}




extension UIColor {
    
    static func mainAppColor() -> UIColor {
        return UIColor(hexString: "F38300")
    }
    
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}






extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}


extension Date {
    
    static func getDate(customString: String) -> String {
        let time = Double(customString)
        let timeDate = NSDate(timeIntervalSince1970: time!)
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "dd MMM yyyy"
        return dateFormatterr.string(from: timeDate as Date)
    }
    static func getDate(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
    
    
    //period -> .WeekOfYear, .Day
    func rangeOfPeriod(period: Calendar.Component) -> (Date, Date) {
        
        var startDate = Date()
        var interval : TimeInterval = 0
        let _ = Calendar.current.dateInterval(of: period, start: &startDate, interval: &interval, for: self)
        let endDate = startDate.addingTimeInterval(interval - 1)
        
        return (startDate, endDate)
    }
    
    func calcStartAndEndOfDay() -> (Date, Date) {
        return rangeOfPeriod(period: .day)
    }
    
    func calcStartAndEndOfWeek() -> (Date, Date) {
        return rangeOfPeriod(period: .weekday)
    }
    
    func calcStartAndEndOfMonth() -> (Date, Date) {
        return rangeOfPeriod(period: .month)
    }
    
    func getSpecificDate(interval: Int) -> Date {
        var timeInterval = DateComponents()
        timeInterval.day = interval
        return Calendar.current.date(byAdding: timeInterval, to: self)!
    }
    
    func getStart() -> Date {
        let (start, _) = calcStartAndEndOfDay()
        return start
    }
    
    func getEnd() -> Date {
        let (_, end) = calcStartAndEndOfDay()
        return end
    }
    
    func isBigger(to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedDescending ? true : false
    }
    
    func isSmaller(to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedAscending ? true : false
    }
    
    func isEqual(to: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: to)
    }
    
    func isElement(of: [Date]) -> Bool {
        for element in of {
            if self.isEqual(to: element) {
                return true
            }
        }
        return false
    }
    
    func getElement(of: [Date]) -> Date {
        for element in of {
            if self.isEqual(to: element) {
                return element
            }
        }
        return Date()
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}




extension String
{
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
    
    
    func base64ToImage() -> UIImage?
    {
        if  self.count > 0
        {
            if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
                return image
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func base64ToImageWIthPreficRemove() -> UIImage?
    {
        let result = self.removeBase64Prefix()
        if  result.count > 0
        {
            if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
                return image
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func removeBase64Prefix() -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: "data:image\\/([a-zA-Z]*);base64,([^\\\"]*)")
            let results = regex.matches(in: self, range:  NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
//    func timeAgoDisplay() -> String
//    {
//        let date = DateFormatterManager.getFormattedDate(invitationDate: self, dateInputFormate: "d/M/yyyy h:mm:ss a", dateOutputFormate: "d/M/yyyy h:mm:ss a")
//        let timee =  Date().timeIntervalSince(date)
//        let secondsAgo = Int(timee)
//        
//        let minute = 60
//        let hour = 60 * minute
//        let day = 24 * hour
//        let week = 7 * day
//        let month = 4 * week
//        let year = 12 * month
//        
//        let quotient: Int
//        let unit: String
//        if secondsAgo < minute {
//            quotient = secondsAgo
//            unit = "second"
//        } else if secondsAgo < hour {
//            quotient = secondsAgo / minute
//            unit = "min"
//        } else if secondsAgo < day {
//            quotient = secondsAgo / hour
//            unit = "hour"
//        } else if secondsAgo < week {
//            quotient = secondsAgo / day
//            unit = "day"
//        } else if secondsAgo < month {
//            quotient = secondsAgo / week
//            unit = "week"
//        }
//        else if secondsAgo < year {
//            quotient = secondsAgo / month
//            unit = "month"
//        }
//        else {
//            quotient = secondsAgo / year
//            unit = "year"
//        }
//        
//        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
//    }
    
    
    func isNumeric() -> Bool {
        guard !self.isEmpty else { return false }
        return !self.contains { Int(String($0)) == nil }
    }
    
    func IsValidString() -> Bool {
        if trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }else { return true }
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidStringLenght(Length: Int) -> Bool {
        let string = trimmingCharacters(in: .whitespaces)
        if string.count >= Length { return true}
        else { return false }
    }
    
    func isValidStringLimitedLenght(Length: Int) -> Bool {
        let string = trimmingCharacters(in: .whitespaces)
        if string.count == Length { return true}
        else { return false }
    }
    
    func isStringHaveCapitalLetter() -> Bool {
        let regex = try! NSRegularExpression(pattern: ".*[A-Z]+.*")
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}



extension UIButton {
    
    func makeShadow(radius: CGFloat)
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
        layer.cornerRadius = radius
    }
}



extension UIApplication {
    func topViewController() -> UIViewController? {
         var topViewController: UIViewController? = nil
         if #available(iOS 13, *) {
             for scene in connectedScenes {
                 if let windowScene = scene as? UIWindowScene {
                     for window in windowScene.windows {
                         if window.isKeyWindow {
                             topViewController = window.rootViewController
                         }
                     }
                 }
             }
         } else {
             topViewController = keyWindow?.rootViewController
         }
         while true {
             if let presented = topViewController?.presentedViewController {
                 topViewController = presented
             } else if let navController = topViewController as? UINavigationController {
                 topViewController = navController.topViewController
             } else if let tabBarController = topViewController as? UITabBarController {
                 topViewController = tabBarController.selectedViewController
             } else {
                 // Handle any other third party container in `else if` if required
                 break
             }
         }
         return topViewController
     }
}



extension UserDefaults {
    
    
//    func getLoggedInUserName() -> String {
//        return string(forKey: LocalizableWords.privateMesseges.loggedInUserName) ?? ""
//    }
//    func deleteLoggedInUserName() {
//        removeObject(forKey: LocalizableWords.privateMesseges.loggedInUserName)
//    }
//    func getUserData() -> [String: Any]{
//        return object(forKey: "userData") as! [String : Any]
//    }
//    func deleteUserData() {
//        removeObject(forKey: "userData")
//    }
//    func getUserId() -> String {
//        return string(forKey: "Id") ?? ""
//    }
//    func deleteUserId(){
//        removeObject(forKey: "Id")
//    }
//    func getUserProfileImageURL() -> String {
//        return string(forKey: "UserProfileImageURL") ?? ""
//    }
}


extension UIImage {
    
    public var base64: String {
        return self.jpegData(compressionQuality: 1.0)!.base64EncodedString()
    }
    
    convenience init?(base64: String, withPrefix: Bool) {
        var finalData: Data?
        
        if withPrefix {
            guard let url = URL(string: base64) else { return nil }
            finalData = try? Data(contentsOf: url)
        } else {
            finalData = Data(base64Encoded: base64)
        }
        
        guard let data = finalData else { return nil }
        self.init(data: data)
    }
    
    
    var pngRepresentationData: Data? {
        let compressedImage = self.resized(withPercentage: 0.7)
        return compressedImage?.pngData()
    }
    
    var jpegRepresentationData: Data? {
        return self.jpegData(compressionQuality: 0.7)
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

