//
// Created by Gabo Obregon on 12/22/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskCellManager.h"


@implementation TaskCellManager

- (id)init
{
	self = [super self];
	if (self) {
		_managedCells = [[NSMutableSet alloc] init];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

@end