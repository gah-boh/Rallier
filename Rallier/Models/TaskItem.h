//
// Created by Gabo Obregon on 12/13/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaskItem : NSObject

@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSNumber *estimate;
@property (nonatomic, strong) NSNumber *toDo;

- (id)initWithName:(NSString *)name estimate:(NSNumber *)estimate toDo:(NSNumber *)toDo;

@end