//
// Created by Gabo Obregon on 12/21/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DefinedTableManager;
@class CellTransferHelper;


@interface DragController : NSObject

@property (nonatomic, strong) DefinedTableManager *sourceDragManager;
@property (nonatomic, strong) CellTransferHelper *draggingInfo;
@property (nonatomic, strong) UITableViewCell *draggedCell;

- (id)initWithSource:(DefinedTableManager *)sourceDragManager helper:(CellTransferHelper *)helper draggedCell:(UITableViewCell *)cell;

- (void)dragCell:(CGPoint)translation;

- (void)dragEndedAt:(DefinedTableManager *)destinationTableManager;
@end