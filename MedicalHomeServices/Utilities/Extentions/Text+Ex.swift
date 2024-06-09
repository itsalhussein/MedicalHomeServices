import SwiftUI

// I used string format to show english numbers in arabic language
extension Text {
    init(int: Int){
        self.init(String(format: "%d", int))
    }

    init(float: Float?){
        self.init((float ?? 0).max2FractionDigits())
    }
    init(double: Double?){
        self.init((double ?? 0).max2FractionDigits())
    }

    init(percentage: Float?){
        self.init("\((percentage ?? 0).max2FractionDigits())%")
    }

    init(percentage: Double?){
        self.init("\((percentage ?? 0).max2FractionDigits())%")
    }

    init(percentage: Double?, defaultValue: String){
        if let percentage = percentage {
            self.init("\(percentage.max2FractionDigits())%")
        } else {
            self.init(defaultValue)
        }
    }
}
