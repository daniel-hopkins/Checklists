//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by Daniel Hopkins on 4/26/14.
//  Copyright (c) 2014 niestudio. All rights reserved.
//

#import "ChecklistsViewController.h"
#import "ChecklistItem.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController
{
	NSMutableArray *_items;
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

- (void)saveChecklistItems
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[archiver encodeObject:_items forKey:@"ChecklistItems"];
	[archiver finishEncoding];
	[data writeToFile:[self dataFilePath] atomically:YES];
							  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSLog(@"Documents folder is %@", [self documentsDirectory]);
	NSLog(@"Data file is %@", [self dataFilePath]);
	
	_items = [[NSMutableArray alloc] initWithCapacity:20];

	ChecklistItem *item;

	item = [[ChecklistItem alloc] init];
	item.text = @"Walk the Dog";
	item.checked = NO;
	[_items addObject:item];

	item = [[ChecklistItem alloc] init];
	item.text = @"Brush Teeth";
	item.checked = YES;
	[_items addObject:item];

	item = [[ChecklistItem alloc] init];
	item.text = @"Learn iOS development";
	item.checked = YES;
	[_items addObject:item];

	item = [[ChecklistItem alloc] init];
	item.text = @"Soccer Practice";
	item.checked = NO;
	[_items addObject:item];

	item = [[ChecklistItem alloc] init];
	item.text = @"Eat cookies";
	item.checked = YES;
	[_items addObject:item];
	
	item = [[ChecklistItem alloc] init];
	item.text = @"Watch Harry Potter";
	item.checked = NO;
	[_items addObject:item];
	
	item = [[ChecklistItem alloc] init];
	item.text = @"Go to bed";
	item.checked = NO;
	[_items addObject:item];

	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_items count];
	
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
	
	
	UILabel *label = (UILabel *)[cell viewWithTag:1001];
	
	if (item.checked) {
		label.text = @"√";
	}else {
		label.text = @"";
	}

}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
	UILabel *label  = (UILabel *)[cell viewWithTag:1000];
	label.text = item.text;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
	
	ChecklistItem *item = _items[indexPath.row];
		
	[self configureCheckmarkForCell:cell withChecklistItem:item];
	[self configureTextForCell:cell withChecklistItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	ChecklistItem *item = _items[indexPath.row];
	[item toggleChecked];
	
	[self configureCheckmarkForCell:cell withChecklistItem:item];
	
	[self saveChecklistItems];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.row];
    
	[self saveChecklistItems];
	
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
	
	NSInteger newRowIndex = [_items count];
	[_items addObject:item];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
	
	NSArray *indexPaths = @[indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
	
	[self saveChecklistItems];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
	NSInteger index = [_items indexOfObject:item];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
	[self configureTextForCell:cell withChecklistItem:item];
	
	[self saveChecklistItems];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddItem"]) {
		
		//1
		UINavigationController *navigationController = segue.destinationViewController;
		
		//2
		ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
		
		//3
		controller.delegate = self;
		
	} else if ([segue.identifier isEqualToString:@"EditItem"]){
		
		UINavigationController *navigationController = segue.destinationViewController;
		
		ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
		
		controller.delegate = self;
		
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		
		controller.itemToEdit = _items[indexPath.row];
	}
}

@end













