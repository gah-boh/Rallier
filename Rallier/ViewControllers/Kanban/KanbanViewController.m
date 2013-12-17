//
//  KanbanViewController.m
//  Rallier
//
//  Created by Gabo Obregon on 12/13/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "KanbanViewController.h"
#import "DefinedTableManager.h"
#import "DefinedTaskItemSource.h"
#import "TaskItem.h"

@interface KanbanViewController ()

@property(nonatomic, strong) DefinedTableManager *sourceDragManager;
@property(nonatomic, strong) DefinedTableManager *destinationDragManager;
@property(nonatomic, strong) UITableViewCell *draggingCell;
@end

@implementation KanbanViewController

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
	CGPoint touch = [gr locationInView:[self view]];
	if ([gr state] == UIGestureRecognizerStateBegan) {
		[self draggedCellTableManager:touch];
	}
	else if ([gr state] == UIGestureRecognizerStateChanged) {
		[self dragCell:gr];
	}
	else if ([gr state] == UIGestureRecognizerStateEnded) {
		[self endDragging:touch];
	}
}

- (void)draggedCellTableManager:(CGPoint)touch
{
	DefinedTableManager *tableManager = [self findTouchedTableManager:touch];
	[self setupForDragStart:tableManager point:touch];
}

- (DefinedTableManager *)findTouchedTableManager:(CGPoint)touch
{
	for (DefinedTableManager *tableManager in [self tableManagers]) {
		BOOL isInView = [[tableManager view] pointInside:touch
											   withEvent:nil];
		if (isInView) {
			return tableManager;
		}
	}
	return nil;
}

- (void)setupForDragStart:(DefinedTableManager *)manager point:(CGPoint)point
{
	[self setSourceDragManager:manager];
	[self setupDraggingCell:[manager getCellForPoint:point]];
}

- (void)setupDraggingCell:(UITableViewCell *)cell
{
	[cell removeFromSuperview];
	[[self view] addSubview:cell];
	[self setDraggingCell:cell];
}

- (void)dragCell:(UIPanGestureRecognizer *)gr
{
	CGPoint cellCenter = [self translatedCellPoint:[gr translationInView:[self view]]];
	[[self draggingCell] setCenter:cellCenter];
	[gr setTranslation:CGPointZero inView:[self view]];
}

- (CGPoint)translatedCellPoint:(CGPoint)translation
{
	return CGPointMake([[self draggingCell] center].x + translation.x,
			[[self draggingCell] center].y + translation.y);
}

- (void)endDragging:(CGPoint)point
{
	NSLog(@"Finish me endDragging:");
	[self setDestinationDragManager:[self findTouchedTableManager:point]];
	[[self draggingCell] removeFromSuperview];
	[self setDraggingCell:nil];
}

- (void)createDefinedTableManager
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:[self getDefinedFrame] style:UITableViewStyleGrouped];
	DefinedTaskItemSource *source = [[DefinedTaskItemSource alloc] init];
	DefinedTableManager *definedManager = [[DefinedTableManager alloc] initWithTableView:tableView source:source];
	[self setDefinedTableManager:definedManager];
	[[self tableManagers] addObject:definedManager];

	NSMutableArray *items = [NSMutableArray array];
	[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up"]];
	[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests"]];
	[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit"]];
	[source setItems:items];
}

- (void)createInProgressTableManager
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:[self getInProgressFrame] style:UITableViewStyleGrouped];
	DefinedTaskItemSource *source = [[DefinedTaskItemSource alloc] init];
	DefinedTableManager *inProgress = [[DefinedTableManager alloc] initWithTableView:tableView source:source];
	[self setInProgressTableManager:inProgress];
	[[self tableManagers] addObject:inProgress];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
