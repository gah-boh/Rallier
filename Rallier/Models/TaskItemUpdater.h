//
// Created by Gabo Obregon on 12/22/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaskItemUpdater : NSObject

@property (nonatomic, strong) NSDictionary *propertyAndValue;
@property (nonatomic, weak) UIView *field;

- (id)initWithKVC:(NSDictionary *)kvc field:(UIView *)field;
@end