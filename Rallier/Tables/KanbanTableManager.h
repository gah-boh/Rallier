//
//  KanbanTableManager.h
//  Rallier
//
//  Created by Gabo Obregon on 12/14/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KanbanTableSource.h"

@class CellTransferHelper;

extern NSString * const taskCellIdentifier;
extern CGFloat const rowHeight;

@interface KanbanTableManager : NSObject <UITableViewDelegate>

@property (nonatomic) UITableView *view;
@property (nonatomic) id <TaskItemSourceProtocol> dataSource;

- (id)initWithTableView:(UITableView *)tableView source:(id <TaskItemSourceProtocol>)dataSource notificationName:(NSString *)nameForNotification;

- (CellTransferHelper *)getCellTransferInfoForPoint:(CGPoint)point;

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath;

- (void)removeCell:(UITableViewCell *)cell data:(NSIndexPath *)path;

- (void)newItemDragged:(TaskItem *)item;
@end
