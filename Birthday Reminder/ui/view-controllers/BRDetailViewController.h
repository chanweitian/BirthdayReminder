//
//  BRDetailViewController.h
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"


@interface BRDetailViewController : BRCoreViewController

@property (strong, nonatomic) NSMutableDictionary *birthday;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end
