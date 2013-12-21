//
// Created by Gabo Obregon on 12/21/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "DragController.h"
#import "DefinedTableManager.h"
#import "CellTransferHelper.h"


@implementation DragController

- (id)initWithSource:(DefinedTableManager *)sourceDragManager helper:(CellTransferHelper *)helper draggingView:(UIView *)draggingView
{
	self = [super init];
	if (self) {
		_sourceDragManager = sourceDragManager;
		_draggingInfo = helper;
		[self moveCellToDraggingView:draggingView];
	}
	return self;
}

- (void)moveCellToDraggingView:(UIView *)draggingView
{
	UITableViewCell *cell = [[self draggingInfo] cell];
	[cell removeFromSuperview];
	[draggingView addSubview:cell];
	[self adjustDraggedCellFrame:cell];
}

- (void)adjustDraggedCellFrame:(UITableViewCell *)cell
{
	CGRect parentViewFrame = [[[self sourceDragManager] view] frame];
	CGPoint newCellOrigin = [cell frame].origin;
	newCellOrigin.x += parentViewFrame.origin.x;
	newCellOrigin.y += parentViewFrame.origin.y;
	[cell setFrame:CGRectMake(newCellOrigin.x, newCellOrigin.y, [cell frame].size.width, [cell frame].size.height)];
}


- (void)dragCell:(CGPoint)translation
{
	CGPoint cellCenter = [self translatedCellPoint:translation];
	// TODO: Breaking law of demeter here.
	[[[self draggingInfo] cell] setCenter:cellCenter];
}

- (CGPoint)translatedCellPoint:(CGPoint)translation
{
	// TODO: Breaking law of demeter here.
	UITableViewCell *draggingCell = [[self draggingInfo] cell];
	return CGPointMake([draggingCell center].x + translation.x,
					   [draggingCell center].y + translation.y);
}

- (void)dragEndedAt:(DefinedTableManager *)destinationTableManager
{
	TaskItem *taskItem = [[self draggingInfo] taskItem];
	[[destinationTableManager dataSource] addData:taskItem
											forPosition:[[self draggingInfo] position]];
	[[[self sourceDragManager] dataSource] removeDataForPosition:[[self draggingInfo] position]];
	// TODO: Breaking law of demeter here.
	UITableViewCell *draggingCell = [[self draggingInfo] cell];
	[draggingCell removeFromSuperview];
//	draggingCell = nil;
}

@end