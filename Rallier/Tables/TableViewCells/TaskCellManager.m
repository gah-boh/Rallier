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
	[taskCell setDelegate:self];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)stopManagingCell:(UITableViewCell *)cell
{
	[[self managedCells] removeObject:cell];
	[(TaskCell *) cell setDelegate:nil];
}

@end


