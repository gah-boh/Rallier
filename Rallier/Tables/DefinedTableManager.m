//
//  DefinedTableManager.m
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "DefinedTableManager.h"
#import "CellTransferHelper.h"
#import "TaskItem.h"
#import "TaskCell.h"

NSString * const taskCellIdentifier = @"TaskCell";

@implementation DefinedTableManager
{
	UITableViewCell *draggedCell;
}

- (id)initWithTableView:(UITableView *)tableView
				 source:(id <TaskItemSourceProtocol>)dataSource
{
	self = [super init];
	if (self) {
		_view = tableView;
		_dataSource = dataSource;
		[self setUpCellReuseIdentifiers];
		[_view setDelegate:self];
		[_view setDataSource:dataSource];
	}
	return self;
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

- (void)dealloc
{
	[_view setDelegate:nil];
}

- (void)removeCellAndDataFromPosition:(NSIndexPath *)path
{
	[[self dataSource] removeDataForPosition:path];
}

- (void)newItemDragged:(TaskItem *)item
{
	[[self dataSource] addData:item];
}
@end
