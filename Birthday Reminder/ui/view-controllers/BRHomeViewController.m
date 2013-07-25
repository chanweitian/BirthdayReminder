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
#import "BRDModel.h"
#import "BRDBirthday.h"

@interface BRHomeViewController ()
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation BRHomeViewController

#pragma mark Fetched Results Controller to keep track of the Core Data BRDBirthday managed objects

- (NSFetchedResultsController *) fetchedResultsController {
    if(_fetchedResultsController == nil){
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        // access the single managed object context trough model singleton
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        
        //fetch request requires an entity description
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
        fetchRequest.entity = entity;
        
        
        //we'll order the BRDBrithday object in name sort order for now
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nextBirthday" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
        fetchRequest.sortDescriptors = sortDescriptors;
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultsController.delegate = self;
        NSError *error = nil;
        
        if (![ self.fetchedResultsController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    
    return _fetchedResultsController;
    
}

#pragma mark NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //The fetched results changed
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        NSLog(@"initWithCoder");
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"birthdays" ofType:@"plist"];
        NSArray *nonMutableBirthdays = [NSArray arrayWithContentsOfFile:plistPath];
        

        BRDBirthday *birthday;
        NSDictionary *dictionary;
        NSString *name;
        NSString *pic;
        NSString *pathForPic;
        NSData *imageData;
        NSDate *birthdate;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        //Get existing Entities so as not to have duplicates
        NSString *uid;
        NSMutableArray *uids = [NSMutableArray array];
        for (int i=0; i<[nonMutableBirthdays count]; i++){
            dictionary = nonMutableBirthdays[i];
            uid = dictionary[@"name"];
            [uids addObject:uid];
        }
        
        NSMutableDictionary *existingEntities = [[BRDModel sharedInstance] getExistingBirthdaysWithUIDs:uids];
                    
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        
        for(int i=0; i< nonMutableBirthdays.count; i++){
            
            dictionary = nonMutableBirthdays[i];
            uid = dictionary[@"name"];
            birthday = existingEntities[uid];
            if (birthday) {//birthday already exists
                
            }
            else {//birthday doesn't exist so create it
                birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday"
                                                         inManagedObjectContext:context];
                existingEntities[uid] = birthday;
                birthday.uid = uid;
            }
            
            name = dictionary[@"name"];
            pic = dictionary[@"pic"];
            birthdate = dictionary[@"birthdate"];
            pathForPic = [[NSBundle mainBundle] pathForResource:pic ofType:nil];
            imageData = [NSData dataWithContentsOfFile:pathForPic];
            birthday.name = name;
            birthday.imageData = imageData;
            NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:birthdate];
            //New literals syntax, same as
            //birthday.birthDay = [NSNumber numberWithInt:components.day];
            birthday.birthDay = @(components.day);
            birthday.birthMonth = @(components.month);
            birthday.birthYear = @(components.year);
            [birthday updateNextBirthdayAndAge];

        }
        [[BRDModel sharedInstance] saveChanges];
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
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    BRDBirthday *birthday = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = birthday.name;
    cell.detailTextLabel.text = birthday.birthdayTextToDisplay;
    cell.imageView.image = [UIImage imageWithData:birthday.imageData];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
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
        BRDBirthday *birthday = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
        
        BRDetailViewController *birthdayDetailViewController = segue.destinationViewController;
        birthdayDetailViewController.birthday = birthday;
        
    } else if  ([identifier isEqualToString:@"AddBirthday"]){
        
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        BRDBirthday *birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday" inManagedObjectContext:context];
        [birthday updateWithDefaults];
         
        UINavigationController *navigationController = segue.destinationViewController;
        
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *) navigationController.topViewController;
        
        birthdayEditViewController.birthday = birthday;
        
    }
    
}



@end
