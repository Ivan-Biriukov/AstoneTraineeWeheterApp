import UIKit.UIImage

extension UIImage {
    
    struct Common {
        static var baackground: UIImage? {
            return UIImage(named: "background")
        }
    }
    
    struct Launch {
        static var clouds: UIImage? {
            return UIImage(named: "Cloud")
        }
        
        static var weatherCondition: UIImage? {
            return UIImage(named: "weatherCondition")
        }
    }
    
    struct Main {

    }
    
    struct Alert {
        static var closeIcon: UIImage? {
            return UIImage(named: "closeAlertIcon")
        }
        
        static var predictTemp: UIImage? {
            return UIImage(named: "predictionalTemp")
        }
        
        static var feelsTemp: UIImage? {
            return UIImage(named: "feelsLikeTemp")
        }
        
        static var airPressure: UIImage? {
            return UIImage(named: "pressure")
        }
        
        static var humidity: UIImage? {
            return UIImage(named: "humidity")
        }
        
        static var windSpeed: UIImage? {
            return UIImage(named: "windSpeed")
        }
        
        static var windDirection: UIImage? {
            return UIImage(named: "windDirection")
        }
    }
}
