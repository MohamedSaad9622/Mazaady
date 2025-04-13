//
//  UIColor+Extensions.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit

extension UIColor {
    
    static var appMainColorForLightTheme = #colorLiteral(red: 0.8235294118, green: 0.02352941176, blue: 0.3254901961, alpha: 1) //#D20653
    static var appMainColorForDarkTheme = #colorLiteral(red: 0.6078431373, green: 0.01568627451, blue: 0.2392156863, alpha: 1) //#9B043D
    static var appMainBackgroundColorForLightTheme = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //#FFFFFF
    static var appMainBackgroundColorForDarkTheme = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1) //#121212
    static var appSecondaryTextColorForLightTheme = #colorLiteral(red: 0.6588235294, green: 0.6431372549, blue: 0.6431372549, alpha: 1) //#A8A4A4
    static var appSecondaryTextColorForDarkTheme = #colorLiteral(red: 0.368627451, green: 0.3568627451, blue: 0.3568627451, alpha: 1) //#A8A4A4
    static var appSecondBackgroundColorForLightTheme = #colorLiteral(red: 0.999037683, green: 0.9594329, blue: 0.9125903249, alpha: 1) //#FDF5EA
    static var appOrangeColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0.1137254902, alpha: 1) //#FF951D
    static var appLightOrangeColor = #colorLiteral(red: 0.999037683, green: 0.9594329, blue: 0.9125903249, alpha: 1) //#FDF5EA
    static var appMainTextColorForLightTheme = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1098039216, alpha: 1) //#1B1B1C
    static var appMainTextColorForDarkTheme = #colorLiteral(red: 0.8784313798, green: 0.8784313798, blue: 0.8784313798, alpha: 1) //#E0E0E0
    static var appSecondaryBackgroundColor =  #colorLiteral(red: 0.9664588571, green: 0.956530869, blue: 0.9610145688, alpha: 1) //#F6F4F5
    static var appBoarderColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1) //#E0E0E0
    
    static var appMainColor: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? appMainColorForDarkTheme : appMainColorForLightTheme
        }
    }
    
    static var appSecondaryTextColor: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? appSecondaryTextColorForDarkTheme : appSecondaryTextColorForLightTheme
        }
    }

    static var appMainBackgroundColor: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? appMainBackgroundColorForDarkTheme : appMainBackgroundColorForLightTheme
        }
    }
    
    static var appMainBackgroundColorReversed: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? appMainBackgroundColorForLightTheme :  appMainBackgroundColorForDarkTheme
        }
    }
    
    static var appMainTextColor: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? appMainTextColorForDarkTheme : appMainTextColorForLightTheme
        }
    }
    
    static var appMainTextColorReversed: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? appMainTextColorForLightTheme :  appMainTextColorForDarkTheme
        }
    }
    
}
