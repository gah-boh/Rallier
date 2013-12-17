//
// Created by Gabo Obregon on 12/16/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "CellTransferHelper.h"
#import "TaskItem.h"


@implementation CellTransferHelper
{

}

- (id)init
{
	@throw [NSException exceptionWithName:@"Wrong initializer for CellTransferHelper"
								   reason:@"Use initWithTaskItem:cell:arrayPositon:"
								 userInfo:nil];
}

- (id)initWithTaskItem:(TaskItem *)aTaskItem
				  cell:(UITableViewCell *)aCell
		 arrayPosition:(int)position
{
	self = [super init];
	if (self) {
		_taskItem = aTaskItem;
		_arrayPosition = position;
		_cell = aCell;
	}

	return self;
}
@end