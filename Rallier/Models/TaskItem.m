//
// Created by Gabo Obregon on 12/13/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskItem.h"


@implementation TaskItem
{

}

- (id)initWithName:(NSString *)name
{
	self = [super init];
	if (self) {
		_taskName = name;
	}
	return self;
}

@end