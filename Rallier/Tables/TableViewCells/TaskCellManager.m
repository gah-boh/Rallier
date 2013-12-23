//
// Created by Gabo Obregon on 12/22/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskCellManager.h"


@implementation TaskCellManager
{
	NSString *notificationName;
}

- (id)init
{
	@throw [NSException exceptionWithName:@"Wrong initializer"
								   reason:@"Use initWithNotification:"
								 userInfo:nil];
}

- (id)initWithNotification:(NSString *)stringForNotification
{
	NSParameterAssert(stringForNotification);

	self = [super self];
	if (self) {
		_managedCells = [[NSMutableSet alloc] init];
		notificationName = stringForNotification;
	}
	return self;
}

- (void)manageCell:(TaskCell *)taskCell
{
	if ([[self managedCells] containsObject:taskCell]) {
		return;
	}
	[[self managedCells] addObject:taskCell];
	[[taskCell estimate] setDelegate:self];
	[[taskCell toDo] setDelegate:self];
}

- (void)stopManagingCell:(UITableViewCell *)cell
{
	[[self managedCells] removeObject:cell];
	[[(TaskCell *) cell estimate] setDelegate:self];
	[[(TaskCell *) cell toDo] setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:textField];
	return YES;
}

@end