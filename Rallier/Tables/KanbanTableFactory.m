//
// Created by Gabo Obregon on 1/4/14.
// Copyright (c) 2014 Gabo Obregon. All rights reserved.
//

#import "KanbanTableFactory.h"
#import "KanbanTableManager.h"


@implementation KanbanTableFactory
{

}
+ (KanbanTableManager *)createKanbanTableManager:(CGRect)frame
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
	KanbanTableSource *source = [[KanbanTableSource alloc] init];
	KanbanTableManager *tableManager = [[KanbanTableManager alloc] initWithTableView:tableView source:source];
	return tableManager;
}

@end