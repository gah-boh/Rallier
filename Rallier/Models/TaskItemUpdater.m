//
// Created by Gabo Obregon on 12/22/13.
// Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskItemUpdater.h"


@implementation TaskItemUpdater

- (id)init
{
	@throw [NSException exceptionWithName:@"Wrong initializer"
								   reason:@"use -initWithKVC:field:"
								 userInfo:nil];
}

- (id)initWithKVC:(NSDictionary *)kvc field:(UIView *)aField
{
	self = [super init];
	if (self) {
		_propertyAndValue = kvc;
		_field = aField;
	}
	return self;
}

@end