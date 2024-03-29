//
//  KanbanViewController.m
//  Rallier
//
//  Created by Gabo Obregon on 12/13/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "KanbanViewController.h"
#import "KanbanTableManager.h"
#import "TaskItem.h"
#import "CellTransferHelper.h"
#import "DragController.h"
#import "KanbanTableFactory.h"

@interface KanbanViewController ()

@end

@implementation KanbanViewController
{
	DragController *dragController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_tableManagers = [NSMutableArray array];
    }
    return self;
}

- (void)loadView
{
	UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self setView:mainView];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self createDefinedTableManager];
	[self createInProgressTableManager];
	[self createCompletedTableManager];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[[self view] addSubview:[[self definedTableManager] view]];
	[[self view] addSubview:[[self inProgressTableManager] view]];
	[[self view] addSubview:[[self completedTableManager] view]];

	[[[self definedTableManager] view] reloadData];
	[[[self inProgressTableManager] view] reloadData];
	[[[self completedTableManager] view] reloadData];

	[self registerGestureRecognizers];
}

- (void)registerGestureRecognizers
{
	UIPanGestureRecognizer *panGestureRecognizer =
			[[UIPanGestureRecognizer alloc] initWithTarget:self
													action:@selector(cellDrag:)];
	[[self view] addGestureRecognizer:panGestureRecognizer];
}

- (void)cellDrag:(UIPanGestureRecognizer *)gr
{
	if ([gr state] == UIGestureRecognizerStateBegan) {
		[self createDragController:gr];
	}
	else if ([gr state] == UIGestureRecognizerStateChanged) {
		[self dragCell:gr];
	}
	else if ([gr state] == UIGestureRecognizerStateEnded) {
		[self endDragging:gr];
	}
}

- (void)createDragController:(UIPanGestureRecognizer *)gr
{
	KanbanTableManager *tableManager = [self findTouchedTableManager:gr];
	CellTransferHelper *transferHelper = [tableManager getCellTransferInfoForPoint:[gr locationInView:[tableManager view]]];
	UITableViewCell *draggedCell = [tableManager cellForIndexPath:[transferHelper position]];
	[self addCellToView:draggedCell]; // TODO: This should not be here.
	dragController = [[DragController alloc] initWithSource:tableManager helper:transferHelper draggedCell:draggedCell];
}

- (void)addCellToView:(UITableViewCell *)cell
{
	[cell removeFromSuperview];
	[[self view] addSubview:cell];
}

- (KanbanTableManager *)findTouchedTableManager:(UIPanGestureRecognizer *)gr
{
	for (KanbanTableManager *tableManager in [self tableManagers]) {
		UITableView *tableView = [tableManager view];
		CGPoint localizedPoint = [gr locationInView:tableView];
		BOOL isInView = [[tableManager view] pointInside:localizedPoint
											   withEvent:nil];
		if (isInView) {
			return tableManager;
		}
	}
	return nil;
}

- (void)dragCell:(UIPanGestureRecognizer *)gr
{
	[dragController dragCell:[gr translationInView:[self view]]];
	[gr setTranslation:CGPointZero inView:[self view]];
}


- (void)endDragging:(UIPanGestureRecognizer *)gr
{
	[dragController dragEndedAt:[self findTouchedTableManager:gr]];
	[[[self definedTableManager] view] reloadData];
	[[[self inProgressTableManager] view] reloadData];
	[[[self completedTableManager] view] reloadData];
	dragController = nil;
}

- (void)createDefinedTableManager
{
	KanbanTableManager *definedManager = [KanbanTableFactory createKanbanTableManager:[self getDefinedFrame] withName:@"Defined" ];
	[self setDefinedTableManager:definedManager];
	[[self tableManagers] addObject:definedManager];

	NSMutableArray *items = [NSMutableArray array];
	[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up" estimate:@0 toDo:@0]];
	[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests" estimate:@0 toDo:@0]];
	[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit" estimate:@0 toDo:@0]];
	[[definedManager dataSource] setItems:items];
}

- (void)createInProgressTableManager
{
	KanbanTableManager *inProgress = [KanbanTableFactory createKanbanTableManager:[self getInProgressFrame] withName:@"In Progress" ];
	[self setInProgressTableManager:inProgress];
	[[self tableManagers] addObject:inProgress];

	NSMutableArray *items = [NSMutableArray array];
	[items addObject:[[TaskItem alloc] initWithName:@"More refactor" estimate:@0 toDo:@0]];
	[items addObject:[[TaskItem alloc] initWithName:@"You messed up again ;)" estimate:@0 toDo:@0]];
	[[inProgress dataSource] setItems:items];
}

- (void)createCompletedTableManager
{
	KanbanTableManager *completedManager = [KanbanTableFactory createKanbanTableManager:[self getCompletedFrame] withName:@"Completed" ];
	[self setCompletedTableManager:completedManager];
	[[self tableManagers] addObject:completedManager];
}

- (CGRect)getInProgressFrame
{
	CGSize size = [self getTableSize];
	return CGRectMake(size.width, 0, size.width, size.height);
}

- (CGRect)getDefinedFrame
{
	CGSize size = [self getTableSize];
	return CGRectMake(0, 0, size.width, size.height);
}

- (CGRect)getCompletedFrame
{
	CGSize size = [self getTableSize];
	return CGRectMake(size.width * 2, 0, size.width, size.height);
}


- (CGSize)getTableSize
{
	UIView *mainView = [self view];
	CGFloat width = [mainView bounds].size.width / 3.0;
	CGFloat height = [mainView bounds].size.height;
	return CGSizeMake(width, height);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	// TODO: This is ugly and just temporary. Figure out the constraints.
	NSLog(@"This is horrible didRotateFromInterfaceOrientation KanbanViewController");
	[[[self definedTableManager] view] setFrame:[self getDefinedFrame]];
	[[[self inProgressTableManager] view] setFrame:[self getInProgressFrame]];
	[[[self completedTableManager] view] setFrame:[self getCompletedFrame]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
