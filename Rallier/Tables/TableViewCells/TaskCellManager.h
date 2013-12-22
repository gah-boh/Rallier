//
// Created by Gabo Obregon on 12/22/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskCell.h"


@interface TaskCellManager : NSObject <TaskCellDelegate>

@property (nonatomic, strong) NSMutableSet *managedCells;

@end