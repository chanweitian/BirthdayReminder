//
//  BRHomeViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRHomeViewController.h"
#import "BRDetailViewController.h"
#import "BRBirthdayEditViewController.h"

@interface BRHomeViewController ()
@property (nonatomic,strong) NSMutableArray *birthdays;
@end

@implementation BRHomeViewController


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"initWithCoder");
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"birthdays" ofType:@"plist"];
        NSArray *nonMutableBirthdays = [NSArray arrayWithContentsOfFile:plistPath];
        
        self.birthdays = [NSMutableArray array];
        
        NSMutableDictionary *birthday;
        NSDictionary *dictionary;
        NSString *name;
        NSString *pic;
        UIImage *image;
        NSDate *birthdate;
        
        for(int i=0; i< nonMutableBirthdays.count; i++){
            dictionary = [nonMutableBirthdays objectAtIndex:i];
            name = dictionary[@"name"];
            pic = dictionary[@"pic"];
            image = [UIImage imageNamed:pic];
            birthdate = dictionary[@"birthdate"];
            birthday = [NSMutableDictionary dictionary];
            birthday[@"name"] = name;
            birthday[@"image"] = image;
            birthday[@"birthdate"] = birthdate;
            
            [self.birthdays addObject:birthday];
        }
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
    [self.tableView reloadData];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindBackToHomeViewController:(UIStoryboardSegue *)segue {
    NSLog(@"unwindBackToHomeViewController!");
}

#pragma mark UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSMutableDictionary *birthday = self.birthdays[indexPath.row];
    
    NSString *name = birthday[@"name"];
    NSDate *birthdate = birthday[@"birthdate"];
    UIImage *image = birthday[@"image"];
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = birthdate.description;
    cell.imageView.image = image;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.birthdays count];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Segues
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"BirthdayDetail"]) {
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        NSDictionary *birthday = self.birthdays[selectedIndexPath.row];
        
        BRDetailViewController *birthdayDetailViewController = segue.destinationViewController;
        birthdayDetailViewController.birthday = birthday;
        
    } else if  ([identifier isEqualToString:@"AddBirthday"]){
        
        NSMutableDictionary *birthday = [NSMutableDictionary dictionary];
        
        birthday[@"name"] = @"My Friend";
        birthday[@"birthdate"] = [NSDate date];
        [self.birthdays addObject:birthday];
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *) navigationController.topViewController;
        
        birthdayEditViewController.birthday = birthday;
        
        
        
    }
    
    
    
}



@end
