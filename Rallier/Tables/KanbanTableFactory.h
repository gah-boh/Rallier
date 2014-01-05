//
// Created by Gabo Obregon on 1/4/14.
// Copyright (c) 2014 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KanbanTableManager;


@interface KanbanTableFactory : NSObject
+ (KanbanTableManager *)createKanbanTableManager:(CGRect)frame withName:(NSString *)name;
@end