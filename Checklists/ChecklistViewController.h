//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by Daniel Hopkins on 4/26/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end
