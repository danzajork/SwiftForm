SwiftForm
=========

SwiftForm is a simple to use iOS library for creating forms. SwiftForm is written in Swift.

## Requirements

- iOS 7.0+
- Xcode 6.1

## Installation

1. Download (you can also git clone, or add as a git submodule) SwiftForm to your project folder.
2. Open the SwiftForm folder.  In Xcode, drag the SwiftForm.xcodeproj from Finder into the file navigator of your project.
3. In Xcode, navigate to the target configuration window by selecting the project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. In the tab bar at the top of that window, open the "Build Phases" panel.
5. Expand the "Link Binary with Libraries" group, and add SwiftForm.framework.
6. To start using SwiftForm, import SwiftForm in your project file to access the API.

* * *

## Usage

Create a view controller that derives from SwiftForm.  Add a UITableView view to the storyboard or nib.  Now that you have a swift form, create form groups and fields adding them to the datasource.  Here is an example:

```swift
import UIKit
import SwiftForm

class ViewController: SwiftForm {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Create form fields
        let textField = TextFormField(title: "Text field")
        let booleanField = BooleanFormField(title : "Boolean field")
        let dateField = DateFormField(title: "Date field")
        let buttonField = ButtonFormField(title : "Button")
        
        buttonField.setAction({
            
            var message = "Text field: \(textField.valueText())\n"
            message += "Boolean field: \(booleanField.valueText())\n"
            message += "Date field: \(dateField.valueText())"
            
            var alert = UIAlertView(title: "Message",
                message: message,
                delegate: self,
                cancelButtonTitle: "OK")
            
            alert.show()
        })
        
        // Form fields are organized by groups which can have optional header and footer text
        let fieldGroup = FieldGroup()
        fieldGroup.headerText = "Example Header"
        fieldGroup.fields.append(textField)
        fieldGroup.fields.append(dateField)
        fieldGroup.fields.append(booleanField)
        
        let buttonGroup = FieldGroup()
        buttonGroup.footerText = "Example footer text"
        buttonGroup.fields.append(buttonField)
        
        // Add groups to the data source to create the form
        dataSource.groups.append(fieldGroup)
        dataSource.groups.append(buttonGroup)
    }
}
```

Take a look at the example project for additional details and API uses.

* * *

## Contact

Follow Dan Zajork on Twitter ([@danzajork](https://twitter.com/danzajork))

## Creator

- [Daniel Zajork](http://github.com/danzajork) ([@danzajork](https://twitter.com/danzajork))

## License

SwiftForm is released under the MIT license. See LICENSE for details.
