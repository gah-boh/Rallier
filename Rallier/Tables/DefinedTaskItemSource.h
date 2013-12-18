//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskItem;

@protocol TaskItemSourceProtocol <UITableViewDataSource>

- (TaskItem *)itemForPosition:(int)position;

- (void)removeDataForPosition:(int)position;

- (void)addData:(TaskItem *)taskItem forPosition:(int)position;
@end

@interface DefinedTaskItemSource : NSObject <TaskItemSourceProtocol>
@property(nonatomic, strong) NSMutableArray *items;
@end