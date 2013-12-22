//
// Created by Gabo Obregon on 12/13/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskItem.h"


@implementation TaskItem

- (id)initWithName:(NSString *)name
		  estimate:(NSNumber *)estimate
			  toDo:(NSNumber *)toDo
{
	self = [super init];
	if (self) {
		_taskName = name;
		_estimate = estimate;
		_toDo = toDo;
	}
	return self;
}

@end