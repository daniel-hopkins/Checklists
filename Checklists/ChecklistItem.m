//
//  ChecklistItem.m
//  Checklists
//
//  Created by Daniel Hopkins on 4/27/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

- (void)toggleChecked
{
	self.checked = !self.checked;
}

@end
