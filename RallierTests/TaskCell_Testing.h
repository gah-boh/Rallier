//
//  TaskCell_Testing.h
//  Rallier
//
//  Created by Gabo Obregon on 1/4/14.
//  Copyright (c) 2014 Gabo Obregon. All rights reserved.
//

#import "TaskCell.h"

@interface TaskCell (Testing)

- (NSInteger)calculateTagWithSection:(NSInteger)section row:(NSInteger)row;

- (NSIndexPath *)decypherTag:(int)tag;
@end
