//
//  FormTableViewDatasource.swift
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

public class FormTableViewDataSource : NSObject {
    
    public var groups = [FieldGroup]()
    
    internal var datePickerIndexPath :  NSIndexPath?
    
    func enableEditForIndexPath(indexPath : NSIndexPath) {
        
        let formField = formFieldForIndexPath(indexPath)
        if !formFieldHasAssociatedEditor(formField) {
            
            return
        }
    
        var currentPickerBeforeIndexPath = false
        if let currentDatePickerIndexPath = datePickerIndexPath {
            
            currentPickerBeforeIndexPath = currentDatePickerIndexPath.row < indexPath.row && currentDatePickerIndexPath.section == indexPath.section
        }
        
        if !editingEnabledFor(indexPath) {
            
            datePickerIndexPath =  NSIndexPath(forItem: currentPickerBeforeIndexPath ? indexPath.row: indexPath.row + 1, inSection: indexPath.section)
        }
    }
    
    func editingEnabledFor(indexPath : NSIndexPath) -> Bool {
        
        if let currentDatePickerIndexPath = datePickerIndexPath {
        
            return (currentDatePickerIndexPath.row - 1) == indexPath.row && currentDatePickerIndexPath.section == indexPath.section
        }
        
        return false
    }
    
    func formFieldHasAssociatedEditor(formField : BaseFormField) -> Bool {
        
        return formField is DateFormField
    }
    
    func formFieldForIndexPath(indexPath : NSIndexPath) -> BaseFormField {
        
        let group = fieldGroupForSection(indexPath.section)
        var index = indexPath.row;
        if let pickerIndex = datePickerIndexPath {
            
            if pickerIndex.section == indexPath.section && pickerIndex.row <= indexPath.row {
                
                index--;
            }
        }
        
        return group.fields[index]
    }
    
    private func fieldGroupForSection(section: Int) -> FieldGroup {
    
        return groups[section]
    }
    
    private func dequeueCell(tableView : UITableView, formField : BaseFormField, forIndexPath: NSIndexPath) -> UITableViewCell {
        
        var identifer = formField.getType().rawValue
        if !(forIndexPath.row == datePickerIndexPath?.row) && formField.getType() == FormFieldType.Date {
                
            identifer = FormFieldType.Label.rawValue
        }
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(identifer) as UITableViewCell
        if let fieldTableViewCell = tableViewCell as? FormFieldTableViewCell {
            
            fieldTableViewCell.configureCell(formField)
            fieldTableViewCell.setValueChangedAction({ formField in
                
                if let dateFormField = formField as? DateFormField {
                    
                    if let associatedCell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: forIndexPath.row - 1, inSection: forIndexPath.section)) as? FormFieldTableViewCell {
                
                        associatedCell.configureCell(formField)
                    }
                }
            })
        }
        
        return tableViewCell
    }
}

extension FormTableViewDataSource : UITableViewDataSource{

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let group = fieldGroupForSection(section)
        var count = group.fields.count
        if datePickerIndexPath?.section == section {
            
            return ++count
        }
        
        return count
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return groups.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let formField = formFieldForIndexPath(indexPath)
        
        let cell = dequeueCell(tableView, formField: formField, forIndexPath: indexPath)
        
        return cell
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return fieldGroupForSection(section).headerText
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return fieldGroupForSection(section).footerText
    }
}