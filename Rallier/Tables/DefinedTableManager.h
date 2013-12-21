//
//  DefinedTableManager.h
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefinedTaskItemSource.h"

@class CellTransferHelper;

extern NSString * const taskCellIdentifier;

@interface DefinedTableManager : NSObject <UITableViewDelegate>

@property (nonatomic) UITableView *view;
@property (nonatomic) id <TaskItemSourceProtocol> dataSource;

- (id)initWithTableView:(UITableView *)tableView source:(id <TaskItemSourceProtocol>)dataSource;

- (CellTransferHelper *)getCellTransferInfoForPoint:(CGPoint)point;

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath;

- (void)removeCellAndDataFromPosition:(NSIndexPath *)path;

- (void)newItemDragged:(TaskItem *)item;
@end
