//
//  DefinedTableManager.m
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "DefinedTableManager.h"

@implementation DefinedTableManager
{
	UITableViewCell *draggedCell;
}

- (id)initWithTableView:(UITableView *)tableView
				 source:(id <TaskItemSourceProtocol>)dataSource
{
	self = [super init];
	if (self) {
		_view = tableView;
		_dataSource = dataSource;
		[self setUpCells];
		[_view setDelegate:self];
		[_view setDataSource:dataSource];
		[self registerGestureRecognizers];
	}
	return self;
}

- (void)setUpCells
{
	[_view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)registerGestureRecognizers
{
	UIPanGestureRecognizer *panGestureRecognizer =
			[[UIPanGestureRecognizer alloc] initWithTarget:self
													action:@selector(checkForCell:)];
	[_view addGestureRecognizer:panGestureRecognizer];
}

- (void)checkForCell:(UIPanGestureRecognizer *)gr
{
	if ([gr state] == UIGestureRecognizerStateBegan) {
		[self getCellForGesture:gr];
	}
	else if ([gr state] == UIGestureRecognizerStateChanged) {
		[self dragCell:gr];
	}
}

- (void)getCellForGesture:(UIPanGestureRecognizer *)gr
{
	NSIndexPath *indexPath = [[self view] indexPathForRowAtPoint:[gr locationInView:[self view]]];
	draggedCell = [[self view] cellForRowAtIndexPath:indexPath];
}

- (void)dragCell:(UIPanGestureRecognizer *)gr
{
	CGPoint cellCenter = [self translatedCellPoint:[gr translationInView:[self view]]];
	[draggedCell setCenter:cellCenter];
	[gr setTranslation:CGPointZero inView:[self view]];
}

- (CGPoint)translatedCellPoint:(CGPoint)translation
{
	return CGPointMake([draggedCell center].x + translation.x,
					   [draggedCell center].y + translation.y);
}

- (void)dealloc
{
	[_view setDelegate:nil];
}

@end
