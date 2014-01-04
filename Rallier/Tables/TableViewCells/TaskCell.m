//
//  TaskCell.m
//  Rallier
//
//  Created by Gabo Obregon on 12/21/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskCell.h"
#import "TaskItem.h"

@implementation TaskCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSIndexPath *fieldIndexPath = [self decypherTag:[textField tag]];
	[[NSNotificationCenter defaultCenter] postNotificationName:[self notificationName]
														object:fieldIndexPath];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)configureWithTaskItem:(TaskItem *)taskItem indexPath:(NSIndexPath *)path notificationName:(NSString *)notification
{
	[self setNotificationName:notification];
	[[self taskName] setText:[taskItem taskName]];
	[[self estimate] setText:[self formatTaskNumber:[taskItem estimate]]];
	[[self toDo] setText:[self formatTaskNumber:[taskItem toDo]]];
	[self setFieldsTags:path];
}

- (void)setFieldsTags:(NSIndexPath *)indexPath
{
	NSInteger tag = [self calculateTagWithSection:[indexPath section]
											  row:[indexPath row]];
	[[self taskName] setTag:tag];
	[[self estimate] setTag:tag];
	[[self toDo] setTag:tag];
}

- (NSInteger)calculateTagWithSection:(NSInteger)section row:(NSInteger)row
{
	return 1000 * section + row;
}

- (NSString *)formatTaskNumber:(NSNumber *)number
{
	return [NSString stringWithFormat:@"%.2f", [number floatValue]];
}

- (NSIndexPath *)decypherTag:(int)tag
{
	NSString *formatted = [NSString stringWithFormat:@"%.3f", tag / 1000.0];
	NSArray *separated = [formatted componentsSeparatedByString:@"."];
	int row = [[separated lastObject] intValue];
	int section = [[separated firstObject] intValue];
	return [NSIndexPath indexPathForRow:row inSection:section];
}
@end
