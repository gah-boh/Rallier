//
//  DefinedTableManager.m
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "DefinedTableManager.h"

@implementation DefinedTableManager

- (id)initWithTableView:(UITableView *)tableView
				 source:(id <UITableViewDataSource>)dataSource
{
	self = [super init];
	if (self) {
		_view = tableView;
		[_view setDelegate:self];
		[_view setDataSource:dataSource];
	}
	return self;
}

- (void)dealloc
{
	[_view setDelegate:nil];
}

@end
