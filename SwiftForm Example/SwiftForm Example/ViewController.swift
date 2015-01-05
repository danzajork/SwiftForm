//
//  ViewController.swift
//  SwiftForm Example
//
//  Copyright (c) 2014 Daniel Zajork. All rights reserved.
//

import UIKit
import SwiftForm

class ViewController: SwiftForm {

    override init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let textField = TextFormField(title: "Text field")
        let passwordTextField = TextFormField(title: "Password text field")
        let booleanField = BooleanFormField(title : "Boolean field")
        let dateField = DateFormField(title: "Date field")
        let anotherDateField = DateFormField(title: "Date field")
        let buttonField = ButtonFormField(title : "Button")

        passwordTextField.isSecure = true
        dateField.value = NSDate().dateByAddingTimeInterval(86400 * -100) // forms can be created with existing or default values
        dateField.dateStyle = .LongStyle // updating the date and time styles will change the underlying date picker mode
        dateField.timeStyle = .NoStyle
        buttonField.setAction({
            
            var message = "Text field: \(textField.valueText())\n"
            message += "Password text field: \(passwordTextField.valueText())\n"
            message += "Boolean field: \(booleanField.valueText())\n"
            message += "Date field: \(dateField.valueText())"
            
            let alert = UIAlertView(title: "Message",
                message: message,
                delegate: self,
                cancelButtonTitle: "OK")
            
            alert.show()
        })
        
        // Form fields are organized by groups which can have optional header and footer text
        let fieldGroup = FieldGroup()
        fieldGroup.headerText = "Example Header"
        fieldGroup.fields.append(textField)
        fieldGroup.fields.append(passwordTextField)
        fieldGroup.fields.append(dateField)
        fieldGroup.fields.append(booleanField)
        
        let anotherGroup = FieldGroup()
        anotherGroup.fields.append(anotherDateField)
        
        let buttonGroup = FieldGroup()
        buttonGroup.footerText = "Example footer text"
        buttonGroup.fields.append(buttonField)
        
        // Groups are added to the data source which is used to create the form
        dataSource.groups.append(fieldGroup)
        dataSource.groups.append(anotherGroup)
        dataSource.groups.append(buttonGroup)
    }
}