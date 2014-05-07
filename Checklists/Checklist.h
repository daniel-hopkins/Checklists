//
//  Checklist.h
//  Checklists
//
//  Created by Daniel Hopkins on 4/30/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;


@end
