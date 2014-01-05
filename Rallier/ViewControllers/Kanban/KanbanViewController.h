//
//  KanbanViewController.h
//  Rallier
//
//  Created by Gabo Obregon on 12/13/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KanbanTableManager;
@class CellTransferHelper;

@interface KanbanViewController : UIViewController

@property (nonatomic) KanbanTableManager *definedTableManager;
@property (nonatomic) KanbanTableManager *inProgressTableManager;
@property (nonatomic) KanbanTableManager *completedTableManager;
@property (nonatomic) NSMutableArray *tableManagers;

@end
