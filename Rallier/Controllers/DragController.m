//
// Created by Gabo Obregon on 12/21/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "DragController.h"
#import "KanbanTableManager.h"
#import "CellTransferHelper.h"


@implementation DragController

- (id)initWithSource:(KanbanTableManager *)sourceDragManager helper:(CellTransferHelper *)helper draggedCell:(UITableViewCell *)cell
{
	self = [super init];
	if (self) {
		_sourceDragManager = sourceDragManager;
		_draggingInfo = helper;
		_draggedCell = cell;
		[self adjustDraggedCellFrame:cell];
	}
	return self;
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
	[[self draggedCell] setCenter:cellCenter];
}

- (CGPoint)translatedCellPoint:(CGPoint)translation
{
	UITableViewCell *draggingCell = [self draggedCell];
	return CGPointMake([draggingCell center].x + translation.x,
					   [draggingCell center].y + translation.y);
}

- (void)dragEndedAt:(KanbanTableManager *)destinationTableManager
{
	TaskItem *taskItem = [[self draggingInfo] taskItem];
	[[self sourceDragManager] removeCellAndDataFromPosition:[[self draggingInfo] position]];
	[destinationTableManager newItemDragged:taskItem];
	UITableViewCell *draggingCell = [self draggedCell];
	[draggingCell removeFromSuperview];
	[self setDraggedCell:nil];
}

@end