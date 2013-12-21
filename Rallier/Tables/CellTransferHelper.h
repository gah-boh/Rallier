//
// Created by Gabo Obregon on 12/16/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskItem;


@interface CellTransferHelper : NSObject
@property (nonatomic, strong) TaskItem *taskItem;
@property (nonatomic, strong) NSIndexPath *position;

- (id)initWithTaskItem:(TaskItem *)mock position:(NSIndexPath *)indexPath;

@end