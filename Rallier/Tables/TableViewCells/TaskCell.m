//
//  TaskCell.m
//  Rallier
//
//  Created by Gabo Obregon on 12/21/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[_estimate setDelegate:self];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

@end
