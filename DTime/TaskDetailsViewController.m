//
//  TaskDetailsViewController.m
//  DTime
//
//  Created by Christina on 26.10.14.
//  Copyright (c) 2014 Christina. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "Task.h"

@interface TaskDetailsViewController ()
@property (nonatomic, weak) IBOutlet UILabel *spendTime;
@end


@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:self.task.name];
    
    int seconds = [self.task.timeSpend integerValue];
    
    int minutes = floorf((int)seconds / 60);
    int hours = floorf(minutes / 60);
    int leftSeconds = (int)seconds % 60;
    int leftMinutes = minutes % 60;
    
    self.spendTime.text = [NSString stringWithFormat:@"Прошло %d:%d:%d", hours, leftMinutes, leftSeconds];
}



@end
