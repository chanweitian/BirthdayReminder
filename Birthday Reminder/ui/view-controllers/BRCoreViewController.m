//
//  BRCoreViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRCoreViewController ()

@end

@implementation BRCoreViewController

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
    self.view.backgroundColor = [UIColor grayColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAndDismiss:(id)sender {
    NSLog(@"Cancel!");
    [self dismissViewControllerAnimated:YES completion:^{
        //any code we place inside this block will
        //run once the view controller has been dismissed
        NSLog(@"Dismiss complete!");
    }];
}

- (IBAction)saveAndDismiss:(id)sender {
    NSLog(@"Save");
    [self dismissViewControllerAnimated:YES completion:^{
        //view controller dismiss animation completed
    }];
}

@end
