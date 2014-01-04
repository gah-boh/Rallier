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
	}
	return self;
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

@end