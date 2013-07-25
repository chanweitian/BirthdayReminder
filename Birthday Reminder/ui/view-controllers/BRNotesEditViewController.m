//
//  BRNotesEditViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRNotesEditViewController.h"
#import "BRDBirthday.h"
#import "BRDModel.h"

@interface BRNotesEditViewController ()

@end

@implementation BRNotesEditViewController

@synthesize birthday;

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
    self.textView.text = self.birthday.notes;
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
    
    self.birthday.notes =   self.textView.text;
    NSLog(@"User changed the notes text: %@",self.textView.text);
}

- (IBAction)cancelAndDismiss:(id)sender {
    [[BRDModel sharedInstance] cancelChanges];
    [super cancelAndDismiss:sender];
}

- (IBAction)saveAndDismiss:(id)sender {
    [[BRDModel sharedInstance] saveChanges];
    [super saveAndDismiss:sender];
}

@end
