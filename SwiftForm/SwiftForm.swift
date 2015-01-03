//
//  SwiftForm.swift
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

public class SwiftForm : UITableViewController {
    
    public let dataSource = FormTableViewDataSource()
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TextFieldTableViewCell", bundle: NSBundle(forClass: SwiftForm.classForCoder())), forCellReuseIdentifier: FormFieldType.TextField.rawValue)
        tableView.registerNib(UINib(nibName: "BooleanFieldTableViewCell", bundle: NSBundle(forClass: SwiftForm.classForCoder())), forCellReuseIdentifier: FormFieldType.Boolean.rawValue)
        tableView.registerNib(UINib(nibName: "ButtonFieldTableViewCell", bundle: NSBundle(forClass: SwiftForm.classForCoder())), forCellReuseIdentifier: FormFieldType.Button.rawValue)
        tableView.registerNib(UINib(nibName: "DateFieldTableViewCell", bundle: NSBundle(forClass: SwiftForm.classForCoder())), forCellReuseIdentifier: FormFieldType.Date.rawValue)
        tableView.registerNib(UINib(nibName: "LabelFieldTableViewCell", bundle: NSBundle(forClass: SwiftForm.classForCoder())), forCellReuseIdentifier: FormFieldType.Label.rawValue)
        tableView.keyboardDismissMode = .OnDrag
        tableView.dataSource = dataSource
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let formField = dataSource.formFieldForIndexPath(indexPath)
        if let buttonFormField = formField as? ButtonFormField {
            
            buttonFormField.buttonAction()
        }
        
        if formField is DateFormField {
            
            toggleEditingForIndexPath(indexPath)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    public override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        let formField = dataSource.formFieldForIndexPath(indexPath)
        if formField is DateFormField || formField is ButtonFormField {
            
            return indexPath
        }
        
        return nil
    }
    
    private func toggleEditingForIndexPath(indexPath : NSIndexPath) {
        
        tableView.beginUpdates()
        
        let willEnableEditing = !dataSource.editingEnabledFor(indexPath)
        
        if let datePickerIndexPath = dataSource.datePickerIndexPath {
            
            tableView.deleteRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
            dataSource.datePickerIndexPath = nil
        }
        
        if (willEnableEditing) {
            
            dataSource.enableEditForIndexPath(indexPath)
            tableView.insertRowsAtIndexPaths([dataSource.datePickerIndexPath!], withRowAnimation: .Fade)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.endUpdates()
    }
}