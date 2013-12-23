//
// Created by Gabo Obregon on 12/22/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskCellManager.h"
#import "TaskItemUpdater.h"

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
	[[taskCell estimate] setDelegate:self];
}

- (void)updateEstimated:(UITextField *)sender
{
	[sender resignFirstResponder];
	NSDictionary *kvc = [NSDictionary dictionaryWithObject:[sender text] forKey:@"estimate"];
	TaskItemUpdater *updater = [[TaskItemUpdater alloc] initWithKVC:kvc field:sender];
	[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:updater];
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
	[[(TaskCell *) cell estimate] setDelegate:nil];
}

@end


