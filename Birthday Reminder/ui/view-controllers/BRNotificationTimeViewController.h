//
//  BRNotificationTimeViewController.h
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRNotificationTimeViewController : BRCoreViewController
@property (weak, nonatomic) IBOutlet UILabel *whatTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

- (IBAction)didChangeTime:(id)sender;


@end
