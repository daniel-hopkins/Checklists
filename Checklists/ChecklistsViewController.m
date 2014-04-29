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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
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
	
	if (item.checked) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
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
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
	
	NSInteger newRowIndex = [_items count];
	[_items addObject:item];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
	
	NSArray *indexPaths = @[indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddItem"]) {
		
		//1
		UINavigationController *navigationController = segue.destinationViewController;
		
		//2
		AddItemViewController *controller = (AddItemViewController *)navigationController.topViewController;
		
		//3
		controller.delegate = self;
	}
}

@end













