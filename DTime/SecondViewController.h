//
//  SecondViewController.h
//  DTime
//
//  Created by Christina on 05.10.14.
//  Copyright (c) 2014 Christina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@interface SecondViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *projectsArray;


@end



