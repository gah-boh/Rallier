//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskItem;

@protocol KanbanTableViewDataSource <UITableViewDataSource>

- (TaskItem *)itemForPosition:(int)position;

- (void)removeCell:(UITableViewCell *)cell path:(NSIndexPath *)indexPath;
- (void)addData:(TaskItem *)taskItem;
@end

@interface KanbanTableSource : NSObject <KanbanTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *items;

@end