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

- (void)setTaskItem:(TaskItem *)taskItem
{
	_taskItem = taskItem;
	[self configureWithTaskItem:taskItem];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[self updateTaskItem];
}

- (void)updateTaskItem
{
	[[self taskItem] setEstimate:[self convertNumericFieldText:[[self estimate] text]]];
	[[self taskItem] setToDo:[self convertNumericFieldText:[[self toDo] text]]];
}

- (NSNumber *)convertNumericFieldText:(NSString *)text
{
	NSString *strippedString = [text stringByReplacingOccurrencesOfString:@"[^0-9\\.]" withString:@"" options:NSRegularExpressionSearch
																	range:NSMakeRange(0, [text length])];
	return [NSNumber numberWithFloat:[strippedString floatValue]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)configureWithTaskItem:(TaskItem *)taskItem
{
	[[self taskName] setText:[taskItem taskName]];
	[[self estimate] setText:[self formatTaskNumber:[taskItem estimate]]];
	[[self toDo] setText:[self formatTaskNumber:[taskItem toDo]]];
}

- (NSString *)formatTaskNumber:(NSNumber *)number
{
	return [NSString stringWithFormat:@"%.2f", [number floatValue]];
}

@end
