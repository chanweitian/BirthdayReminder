//
//  BRDetailViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRDetailViewController.h"
#import "BRBirthdayEditViewController.h"

@interface BRDetailViewController ()

@end

@implementation BRDetailViewController

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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillApprea");
    NSString *name = self.birthday[@"name"];
    self.title = name;
    UIImage *image = self.birthday[@"image"];
    if (image == nil) {
        //default to the birthday cake pic if there's no birthday image
        self.photoView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    } else {
        self.photoView.image = image;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"EditBirthday"]) {
        //Edit this birthday
        UINavigationController *navigationController = segue.destinationViewController;
        BRBirthdayEditViewController *birthdayEditViewController =
        (BRBirthdayEditViewController *) navigationController.topViewController;
        birthdayEditViewController.birthday = self.birthday;
    }
}

@end
