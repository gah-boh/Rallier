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
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[[self view] addSubview:[[self definedTableManager] view]];
	[[self view] addSubview:[[self inProgressTableManager] view]];

	[[[self definedTableManager] view] reloadData];
	[[[self inProgressTableManager] view] reloadData];

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
}

- (void)createDefinedTableManager
{
	// TODO: Need to create a factory.
	UITableView *tableView = [[UITableView alloc] initWithFrame:[self getDefinedFrame] style:UITableViewStylePlain];
	KanbanTableSource *source = [[KanbanTableSource alloc] init];
	KanbanTableManager *definedManager = [[KanbanTableManager alloc] initWithTableView:tableView source:source];
	[self setDefinedTableManager:definedManager];
	[[self tableManagers] addObject:definedManager];

	NSMutableArray *items = [NSMutableArray array];
	[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up" estimate:@0 toDo:@0]];
	[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests" estimate:@0 toDo:@0]];
	[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit" estimate:@0 toDo:@0]];
	[source setItems:items];
}

- (void)createInProgressTableManager
{
	// TODO: This should be in a factory
	UITableView *tableView = [[UITableView alloc] initWithFrame:[self getInProgressFrame] style:UITableViewStylePlain];
	KanbanTableSource *source = [[KanbanTableSource alloc] init];
	KanbanTableManager *inProgress = [[KanbanTableManager alloc] initWithTableView:tableView source:source];
	[self setInProgressTableManager:inProgress];
	[[self tableManagers] addObject:inProgress];

	NSMutableArray *items = [NSMutableArray array];
	[items addObject:[[TaskItem alloc] initWithName:@"More refactor" estimate:@0 toDo:@0]];
	[items addObject:[[TaskItem alloc] initWithName:@"You messed up again ;)" estimate:@0 toDo:@0]];
	[source setItems:items];
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

- (CGSize)getTableSize
{
	UIView *mainView = [self view];
	CGFloat width = [mainView bounds].size.width / 2.0;
	CGFloat height = [mainView bounds].size.height;
	return CGSizeMake(width, height);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	// TODO: This is ugly and just temporary. Figure out the constraints.
	NSLog(@"This is horrible didRotateFromInterfaceOrientation KanbanViewController");
	[[[self definedTableManager] view] setFrame:[self getDefinedFrame]];
	[[[self inProgressTableManager] view] setFrame:[self getInProgressFrame]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
