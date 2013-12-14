//
//  DefinedTableManager.h
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefinedTaskItemSource.h"

@interface DefinedTableManager : NSObject <UITableViewDelegate>

@property (nonatomic) UITableView *view;
@property (nonatomic) id <TaskItemSourceProtocol> dataSource;

- (id)initWithTableView:(UITableView *)tableView source:(id <TaskItemSourceProtocol>)dataSource;

@end
