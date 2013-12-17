//
// Created by Gabo Obregon on 12/16/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskItem;


@interface CellTransferHelper : NSObject
@property (nonatomic, strong) TaskItem *taskItem;
@property (nonatomic, assign) int arrayPosition;
@property (nonatomic, strong) UITableViewCell *cell;

- (id)initWithTaskItem:(TaskItem *)mock cell:(UITableViewCell *)cell arrayPosition:(int)position;

@end