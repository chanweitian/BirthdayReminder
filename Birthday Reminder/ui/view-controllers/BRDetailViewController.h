//
//  BRDetailViewController.h
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"
@class BRDBirthday;

@interface BRDetailViewController : BRCoreViewController

@property (strong, nonatomic) BRDBirthday *birthday;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end
