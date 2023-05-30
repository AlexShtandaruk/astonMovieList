//
//  String.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import Foundation

extension String {
    
    func localized() -> String {
        
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
    
    static func getGroupName(group: GroupType) -> String {
        
        switch group {
        case .danger:
            return Constant.GroupName.danger.localized()
        case .violet:
            return Constant.GroupName.violet.localized()
        case .info:
            return Constant.GroupName.info.localized()
        case .cyan:
            return Constant.GroupName.cyan.localized()
        case .primary:
            return Constant.GroupName.primary.localized()
        case .success:
            return Constant.GroupName.success.localized()
        case .warning:
            return Constant.GroupName.warning.localized()
        case .all:
            return Constant.GroupName.all.localized()
        }
    }
    
    
    private func appPredicateOnRegex(regex: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
    
    func validateEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return appPredicateOnRegex(regex: regex)
    }
    
    func validateLogin() -> Bool {
        let regex = "^[A-Za-z0-9]{3,30}$"
        return appPredicateOnRegex(regex: regex)
    }
    
    func validateName() -> Bool {
        let regex = "^[A-Za-z]{3,30}$"
        return appPredicateOnRegex(regex: regex)
    }
    
    func validatePassword() -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,30}$"
        return appPredicateOnRegex(regex: regex)
    }
}
