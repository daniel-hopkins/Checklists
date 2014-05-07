//
//  AllListsViewController.h
//  Checklists
//
//  Created by Daniel Hopkins on 4/29/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate>

- (void)saveChecklists;

@end
