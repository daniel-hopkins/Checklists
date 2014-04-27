//
//  ChecklistItem.h
//  Checklists
//
//  Created by Daniel Hopkins on 4/27/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end
