//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "KanbanTableSource.h"
#import "TaskItem.h"
#import "KanbanTableManager.h"
#import "TaskCell.h"
#import "TaskCellManager.h"


@implementation KanbanTableSource

- (id)init
{
	@throw [NSException exceptionWithName:@"Wrong initializer"
								   reason:@"use initWithCellManager:"
								 userInfo:nil];
}

- (id)initWithCellManager:(TaskCellManager *)cellManager
{
	self = [super init];
	if (self) {
		_items = [NSMutableArray array];
		_taskCellManager = cellManager;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:taskCellIdentifier forIndexPath:indexPath];
	[[self taskCellManager] manageCell:cell];
	TaskItem *currentItem = [self itemForPosition:(int)[indexPath row]];
	[[cell taskName] setText:[currentItem taskName]];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.items count];
}

- (TaskItem *)itemForPosition:(int)position
{
	return [[self items] objectAtIndex:(NSUInteger) position];
}

- (void)removeCell:(UITableViewCell *)cell path:(NSIndexPath *)indexPath
{
	[[self taskCellManager] stopManagingCell:cell];
	[[self items] removeObjectAtIndex:(NSUInteger)[indexPath row]];
}

- (void)addData:(TaskItem *)taskItem
{
	[[self items] addObject:taskItem];
}


@end