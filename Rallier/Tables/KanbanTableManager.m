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
}

- (id)initWithTableView:(UITableView *)tableView source:(id <KanbanTableViewDataSource>)dataSource title:(NSString *)title
{
	self = [super init];
	if (self) {
		_view = tableView;
		_dataSource = dataSource;
		[self setUpCellReuseIdentifiers];
		[_view setDelegate:self];
		[_view setDataSource:dataSource];
		[tableView setRowHeight:rowHeight];
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
