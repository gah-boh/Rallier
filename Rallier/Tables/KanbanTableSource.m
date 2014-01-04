//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "KanbanTableSource.h"
#import "TaskItem.h"
#import "KanbanTableManager.h"
#import "TaskCell.h"

@interface KanbanTableSource()
@property (nonatomic, strong) NSString *notificationName;
@end

@implementation KanbanTableSource

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
	[self configureTaskCell:cell withTaskItem:currentItem];
	return cell;
}

- (void)configureTaskCell:(TaskCell *)cell
			 withTaskItem:(TaskItem *)taskItem
{
	[[cell taskName] setText:[taskItem taskName]];
	[[cell estimate] setText:[self formatTaskNumber:[taskItem estimate]]];
	[[cell toDo] setText:[self formatTaskNumber:[taskItem toDo]]];
}

- (NSString *)formatTaskNumber:(NSNumber *)number
{
	return [NSString stringWithFormat:@"%.2f", [number floatValue]];
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