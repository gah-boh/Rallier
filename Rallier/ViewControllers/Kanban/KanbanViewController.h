//
//  KanbanViewController.h
//  Rallier
//
//  Created by Gabo Obregon on 12/13/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DefinedTableManager;
@class CellTransferHelper;

@interface KanbanViewController : UIViewController

@property (nonatomic) DefinedTableManager *definedTableManager;
@property (nonatomic) DefinedTableManager *inProgressTableManager;
@property (nonatomic) NSMutableArray *tableManagers;

@end
