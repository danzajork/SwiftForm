//
//  SwiftFormTests.swift
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

import UIKit
import XCTest

// System under test
import SwiftForm

class SwiftFormTests: XCTestCase {
    
    var sut : SwiftForm!
    
    override func setUp() {
        
        super.setUp()
        
        sut = SwiftForm()
    }
    
    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }
    
    func test__viewDidLoad__sets_tableView_dataSource() {
        
        sut.viewDidLoad()
        
        XCTAssert(sut.tableView.dataSource != nil, "dataSource is nil")
    }
    
    func test__viewDidLoad__sets_tableView_keyboardDismissMode() {
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.tableView.keyboardDismissMode, UIScrollViewKeyboardDismissMode.OnDrag, "viewDidLoad did not set expected keyboard dismiss mode")
    }
    
    func test__viewDidLoad__tableView_dataSource_is_type_of_FormTableViewDataSource() {
        
        sut.viewDidLoad()
        
        XCTAssert(sut.tableView.dataSource is FormTableViewDataSource, "dataSource is not type of FormTableViewDataSource")
    }
    
    func test__tableView_willSelectRowAtIndexPath__given_boolean_field_selected__expect_nil() {
    
        let formField = BooleanFormField(title: "test")
        let group = FieldGroup()
        group.fields.append(formField)
        
        sut.dataSource.groups.append(group)
        
        let result = sut.tableView(sut.tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))  
        
        XCTAssertNil(result, "result is not nil")
    }
    
    func test__tableView_willSelectRowAtIndexPath__given_label_field_selected__expect_nil() {
        
        let formField = LabelFormField(title: "test")
        let group = FieldGroup()
        group.fields.append(formField)
        
        sut.dataSource.groups.append(group)
        
        let result = sut.tableView(sut.tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        
        XCTAssertNil(result, "result is not nil")
    }
    
    func test__tableView_willSelectRowAtIndexPath__given_text_field_selected__expect_nil() {
        
        let formField = TextFormField(title: "test")
        let group = FieldGroup()
        group.fields.append(formField)
        
        sut.dataSource.groups.append(group)
        
        let result = sut.tableView(sut.tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        
        XCTAssertNil(result, "result is not nil")
    }
    
    func test__tableView_willSelectRowAtIndexPath__given_date_field_selected__expect_IndexPath() {
        
        let formField = DateFormField(title: "test")
        let group = FieldGroup()
        group.fields.append(formField)
        
        sut.dataSource.groups.append(group)
        
        let fieldIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        let result = sut.tableView(sut.tableView, willSelectRowAtIndexPath: fieldIndexPath)
        
        XCTAssertEqual(fieldIndexPath, result!, "result doesn't match expected index path")
    }
    
    func test__tableView_willSelectRowAtIndexPath__given_button_field_selected__expect_IndexPath() {
        
        let formField = ButtonFormField(title: "test")
        let group = FieldGroup()
        group.fields.append(formField)
        
        sut.dataSource.groups.append(group)
        
        let fieldIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        let result = sut.tableView(sut.tableView, willSelectRowAtIndexPath: fieldIndexPath)
        
        XCTAssertEqual(fieldIndexPath, result!, "result doesn't match expected index path")
    }
}