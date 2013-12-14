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

@end

@implementation KanbanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
	UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self setView:mainView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[[self view] addSubview:[[self definedTableManager] view]];
	[[self view] addSubview:[[self inProgressTableManager] view]];

	[[[self definedTableManager] view] reloadData];
	[[[self inProgressTableManager] view] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self createDefinedTableManager];
	[self createInProgressTableManager];
}

- (void)createDefinedTableManager
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:[self getDefinedFrame] style:UITableViewStyleGrouped];
	DefinedTaskItemSource *source = [[DefinedTaskItemSource alloc] init];
	DefinedTableManager *definedManager = [[DefinedTableManager alloc] initWithTableView:tableView source:source];
	[self setDefinedTableManager:definedManager];

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
