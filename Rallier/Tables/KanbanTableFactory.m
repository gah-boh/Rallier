//
// Created by Gabo Obregon on 1/4/14.
// Copyright (c) 2014 Gabo Obregon. All rights reserved.
//

#import "KanbanTableFactory.h"
#import "KanbanTableManager.h"
#import "KanbanTableHeaderView.h"


@implementation KanbanTableFactory
{

}
+ (KanbanTableManager *)createKanbanTableManager:(CGRect)frame withName:(NSString *)name
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
	UIView *header = [self createHeaderView:frame name:name];
	[tableView setTableHeaderView:header];
	KanbanTableSource *source = [[KanbanTableSource alloc] init];
	KanbanTableManager *tableManager = [[KanbanTableManager alloc] initWithTableView:tableView
																			  source:source
																			   title:name];
	return tableManager;
}

+ (UIView *)createHeaderView:(CGRect)frame name:(NSString *)name
{
	NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"KanbanTableHeaderView" owner:nil options:nil];
	KanbanTableHeaderView *header = nil;
	for (id xibObject in xibArray) {
		if ([xibObject isKindOfClass:[KanbanTableHeaderView class]]) {
			header = (KanbanTableHeaderView *)xibObject;
		}
	}
	[[header title] setText:name];
	[header setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 75.0)];
	return header;
}

@end