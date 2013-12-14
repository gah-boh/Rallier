//
// Created by Gabo Obregon on 12/13/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaskItem : NSObject

@property (nonatomic) NSString *taskName;

- (id)initWithName:(NSString *)name;

@end