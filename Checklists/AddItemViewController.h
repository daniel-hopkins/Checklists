//
//  AddItemViewController.h
//  Checklists
//
//  Created by Daniel Hopkins on 4/27/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

- (IBAction)cancel;

- (IBAction)done;

@end
