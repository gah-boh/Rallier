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
	[_view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}


- (CellTransferHelper *)getCellTransferInfoForPoint:(CGPoint)point
{
	NSIndexPath *indexPath = [[self view] indexPathForRowAtPoint:point];
	return [self getDataForSelectedCell:indexPath];
}

- (CellTransferHelper *)getDataForSelectedCell:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[self view] cellForRowAtIndexPath:indexPath];
	TaskItem *taskItem = [[self dataSource] itemForPosition:[indexPath row]];
	CellTransferHelper *cellInfo = [[CellTransferHelper alloc] initWithTaskItem:taskItem
																		   cell:cell
																	   position:[indexPath row]];
	return cellInfo;
}

- (void)dealloc
{
	[_view setDelegate:nil];
}

@end
