//
// Created by Gabo Obregon on 12/14/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskItemSourceProtocol <UITableViewDataSource>

@end

@interface DefinedTaskItemSource : NSObject <TaskItemSourceProtocol>
@property(nonatomic, strong) NSMutableArray *items;
@end