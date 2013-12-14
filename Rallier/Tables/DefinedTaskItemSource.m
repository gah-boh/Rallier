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

	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

	TaskItem *currentItem = [self.items objectAtIndex:[indexPath row]];
	[[cell textLabel] setText:[currentItem taskName]];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.items count];
}

@end