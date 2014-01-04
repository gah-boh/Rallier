//
//  TaskCell.h
//  Rallier
//
//  Created by Gabo Obregon on 12/21/13.
//  Copyright (c) 2013 Gabo Obregon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskCellDelegate;


@interface TaskCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) id<TaskCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UITextField *estimate;
@property (weak, nonatomic) IBOutlet UITextField *toDo;


@end

@protocol TaskCellDelegate <NSObject>
- (void)manageCell:(TaskCell *)taskCell;
@end

