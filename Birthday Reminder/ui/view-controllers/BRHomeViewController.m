//
//  BRHomeViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRHomeViewController.h"

@interface BRHomeViewController ()

@end

@implementation BRHomeViewController


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"initWithCoder");
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

-(IBAction)unwindBackToHomeViewController:(UIStoryboardSegue *)segue {
    NSLog(@"unwindBackToHomeViewController!");
}

@end
