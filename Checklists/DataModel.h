//
//  DataModel.h
//  Checklists
//
//  Created by Daniel Hopkins on 5/6/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(NSInteger)index;
- (void)saveChecklists;
- (void)sortChecklists;


@end
