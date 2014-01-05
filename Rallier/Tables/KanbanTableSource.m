//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "KanbanTableSource.h"
#import "TaskItem.h"
#import "KanbanTableManager.h"
#import "TaskCell.h"

@interface KanbanTableSource()
@end

@implementation KanbanTableSource
{
}

- (id)init
{
	self = [super init];
	if (self) {
		_items = [NSMutableArray array];
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:taskCellIdentifier forIndexPath:indexPath];
	TaskItem *currentItem = [self itemForPosition:(int)[indexPath row]];
	[cell setTaskItem:currentItem];
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
	[[self items] removeObjectAtIndex:(NSUInteger)[indexPath row]];
}

- (void)addData:(TaskItem *)taskItem
{
	[[self items] addObject:taskItem];
}

- (NSIndexPath *)decypherTag:(int)tag
{
	NSString *formatted = [NSString stringWithFormat:@"%.3f", tag / 1000.0];
	NSArray *separated = [formatted componentsSeparatedByString:@"."];
	int row = [[separated lastObject] intValue];
	int section = [[separated firstObject] intValue];
	return [NSIndexPath indexPathForRow:row inSection:section];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end