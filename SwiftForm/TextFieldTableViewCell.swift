//
//  TextFieldTableViewCell.swift
//
//  Copyright (c) 2015 Daniel Zajork. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import UIKit

public class TextFieldTableViewCell : UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    private var valueChangedAction : ((formField : BaseFormField) -> Void)?
    
    private var textFormField : TextFormField?
    
    public override func awakeFromNib() {
        
        textField.addTarget(self, action: Selector("textFieldValueChanged"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldValueChanged() {
        
        if let field = textFormField {
            
            field.value = textField.text
            
            if let action = valueChangedAction {
                
                action(formField: field)
            }
        }
    }
}

extension TextFieldTableViewCell : FormFieldTableViewCell {

    public func configureCell(formField : BaseFormField) {
    
        if let field = formField as? TextFormField {
        
            textFormField = field
            textField.placeholder = field.title
            textField.text = field.value
            textField.secureTextEntry = field.isSecure
        }
    }
    
    public func setValueChangedAction(valueChangedAction: (formField : BaseFormField) -> Void) {
        
        self.valueChangedAction = valueChangedAction;
    }
}