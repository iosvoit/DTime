//
//  FirstViewController.h
//  DTime
//
//  Created by Christina on 05.10.14.
//  Copyright (c) 2014 Christina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;
@property (nonatomic, weak) IBOutlet UIButton *endButton;

@property (nonatomic, weak) IBOutlet UILabel *remainingTimeLabel;


- (IBAction)startButtonDidPressed:(id)sender;
- (IBAction)stopButtonDidPressed:(id)sender;
- (IBAction)endButtonDidPressed:(id)sender;


 

@end

