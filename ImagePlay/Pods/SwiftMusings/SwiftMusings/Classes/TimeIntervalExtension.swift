import Foundation

extension TimeInterval {
    
    /**
     convert the NSTimeInterval to minute and second format
     
     - returns: miute and second format string
     */
    func convertToMinuteSecondWithSecond() -> String{
        
        let minutes = Int(self / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        
        if minutes < 10 {
            return String(format: "%02d:%02d", minutes, seconds)
        }
        
        return String(format: "%d%:02d", minutes, seconds)
    }
}
