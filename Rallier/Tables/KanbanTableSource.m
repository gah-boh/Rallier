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
	NSString *notificationName;
}

- (id)init
{
	@throw [NSException exceptionWithName:@"wrong initializer"
								   reason:@"use initWithNotificationName:"
								 userInfo:nil];
}

- (id)initWithNotificationName:(NSString*)notification
{
	NSParameterAssert(notification);
	self = [super init];
	if (self) {
		_items = [NSMutableArray array];
		notificationName = [notification copy];
		[self subscribeForNotifications];
	}
	return self;
}

- (void)subscribeForNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(modelChanged:)
												 name:notificationName
											   object:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:taskCellIdentifier forIndexPath:indexPath];
	TaskItem *currentItem = [self itemForPosition:(int)[indexPath row]];
	[cell configureWithTaskItem:currentItem indexPath:indexPath notificationName:notificationName];
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

- (void)modelChanged:(NSNotification *)notification
{
	TaskCell *taskCell = [notification object];
	NSIndexPath *indexPath = [self decypherTag:[taskCell tag]];
	TaskItem *item = [self itemForPosition:[indexPath row]];
	[self updateTaskItem:item withCell:taskCell];
}

- (void)updateTaskItem:(TaskItem *)item withCell:(TaskCell *)cell
{
	// TODO: Crap I'm sending the textField not the cell.
	// I'm going to have to pass the TaskItem object to the cell
	NSString *estimationStr = [[cell estimate] text];
	float estimate = [[[cell estimate] text] floatValue];
	[item setEstimate:[NSNumber numberWithFloat:estimate]];
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