//
//  BRNotificationTimeViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRNotificationTimeViewController.h"

@interface BRNotificationTimeViewController ()

@end

@implementation BRNotificationTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didChangeTime:(id)sender {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self.timePicker.date];
    
    NSLog(@"Changed time to: %d:%d",components.hour,components.minute);
}
@end
