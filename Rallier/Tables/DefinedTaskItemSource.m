//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "DefinedTaskItemSource.h"
#import "TaskItem.h"


@implementation DefinedTaskItemSource


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
	NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

	TaskItem *currentItem = [self itemForPosition:(int)[indexPath row]];
	[[cell textLabel] setText:[currentItem taskName]];
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

- (void)removeDataForPosition:(NSIndexPath *)indexPath
{
	[[self items] removeObjectAtIndex:(NSUInteger)[indexPath row]];
}

- (void)addData:(TaskItem *)taskItem
{
	[[self items] addObject:taskItem];
}


@end