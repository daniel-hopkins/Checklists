//
//  DataModel.m
//  Checklists
//
//  Created by Daniel Hopkins on 5/6/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (void)registerDefaults
{
	NSDictionary *dictionary = @{ @"ChecklistIndex" : @-1 };
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (id)init
{
	if ((self = [super init]))
	{
		[self loadChecklists];
		[self registerDefaults];
	}
	return self;
}

- (NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [paths firstObject];
	return documentsDirectory;
	
}

- (NSString *)dataFilePath
{
	return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:self.lists forKey:@"Checklists"];
	[archiver finishEncoding];
	[data writeToFile:[self dataFilePath] atomically:YES];
}

-(void)loadChecklists
{
	NSString *path = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		NSData *data = [[NSData alloc] initWithContentsOfFile:path];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
		self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
		[unarchiver finishDecoding];
	} else {
		self.lists = [[NSMutableArray alloc] initWithCapacity:20];
	}
}

- (NSInteger)indexOfSelectedChecklist
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

- (void)setIndexOfSelectedChecklist:(NSInteger)index
{
	[[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

@end
