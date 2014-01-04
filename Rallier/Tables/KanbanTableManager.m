//
//  KanbanTableManager.m
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "KanbanTableManager.h"
#import "CellTransferHelper.h"
#import "TaskItem.h"

NSString * const taskCellIdentifier = @"TaskCell";

CGFloat const rowHeight = 75.0;

@interface KanbanTableManager ()
@end

@implementation KanbanTableManager
{
	NSString *notificationName;
}

- (id)initWithTableView:(UITableView *)tableView source:(id <KanbanTableViewDataSource>)dataSource notificationName:(NSString *)nameForNotification
{
	NSParameterAssert(nameForNotification);
	self = [super init];
	if (self) {
		_view = tableView;
		_dataSource = dataSource;
		[self setUpCellReuseIdentifiers];
		[_view setDelegate:self];
		[_view setDataSource:dataSource];
		notificationName = [nameForNotification copy];
		[tableView setRowHeight:rowHeight];
		[self registerForNotifications];
	}
	return self;
}

- (void)registerForNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(modelChanged:)
												 name:notificationName
											   object:nil];
}

- (void)modelChanged:(NSNotification *)notification
{
//	UIView *modifiedView = [notification object];
//	CGPoint pointInTable = [modifiedView convertPoint:[modifiedView bounds].origin toView:[self view]];
//	NSIndexPath *indexPath = [[self view] indexPathForRowAtPoint:pointInTable];
	// TODO: Finish this, this will recieve the point and then update the cell
	NSLog(@"Finish me");
}

- (void)setUpCellReuseIdentifiers
{
	UINib *taskCellNib = [UINib nibWithNibName:taskCellIdentifier bundle:nil];
	[_view registerNib:taskCellNib forCellReuseIdentifier:taskCellIdentifier];
}

- (CellTransferHelper *)getCellTransferInfoForPoint:(CGPoint)point
{
	NSIndexPath *indexPath = [[self view] indexPathForRowAtPoint:point];
	return [self getDataForSelectedCell:indexPath];
}

- (CellTransferHelper *)getDataForSelectedCell:(NSIndexPath *)indexPath
{
	TaskItem *taskItem = [[self dataSource] itemForPosition:(int)[indexPath row]];
	CellTransferHelper *cellInfo = [[CellTransferHelper alloc] initWithTaskItem:taskItem position:indexPath];
	return cellInfo;
}

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath
{
	return [[self dataSource] tableView:[self view] cellForRowAtIndexPath:indexPath];
}

- (void)removeCell:(UITableViewCell *)cell data:(NSIndexPath *)path
{
	[[self dataSource] removeCell:cell path:path];
	[[self view] reloadData];
}

- (void)newItemDragged:(TaskItem *)item
{
	[[self dataSource] addData:item];
}

- (void)dealloc
{
	[_view setDelegate:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
