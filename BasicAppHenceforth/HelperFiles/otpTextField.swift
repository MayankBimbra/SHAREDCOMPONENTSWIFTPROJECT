//
//  otpTextField.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit

protocol MyTextFieldDelegate: AnyObject {
    func textFieldDidDelete(_ tf: UITextField)
}

class otpTextField: UITextField {

    weak var otpDelegate: MyTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        otpDelegate?.textFieldDidDelete(self)
    }
}
