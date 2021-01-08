//
//  editProfileVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import Foundation

class EditProfileVM {
    
    var controller : editProfileVC?

    class var shared: EditProfileVM {
        struct Static {
            static let instance = EditProfileVM()
        }
        return Static.instance
    }
    
    func checkValidations(){
        
    }
    
//    func 
}
