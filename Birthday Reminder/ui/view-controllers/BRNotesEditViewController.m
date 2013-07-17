//
//  BRNotesEditViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRNotesEditViewController.h"

@interface BRNotesEditViewController ()

@end

@implementation BRNotesEditViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"User changed the notes text: %@",self.textView.text);
}

@end
