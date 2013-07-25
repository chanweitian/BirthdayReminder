//
//  BRDMobel.h
//  Birthday Reminder
//
//  Created by Administrator on 7/22/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRDModel : NSObject

+ (BRDModel*)sharedInstance;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) saveChanges;
- (NSMutableDictionary *) getExistingBirthdaysWithUIDs:(NSArray *)uids;
- (void)cancelChanges;

@end
