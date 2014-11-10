//
//  FirstViewController.m
//  DTime
//
//  Created by Christina on 05.10.14.
//  Copyright (c) 2014 Christina. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (nonatomic) int timeIntervalFromTaskStarted;
@property (nonatomic, strong) NSTimer *taskTimer;
@property (nonatomic, weak) IBOutlet UIImageView *spinnerImageView;
@property (nonatomic) BOOL shouldSpin;
@end


@implementation FirstViewController

@synthesize taskTimer = _taskTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startButtonDidPressed:(id)sender {
    self.startButton.enabled = NO;
    self.stopButton.enabled = YES;
    self.endButton.enabled = YES;
    
    [self.taskTimer fire];
    
    self.shouldSpin = YES;
    [self spinWheel];
}

- (void)spinWheel
{
    if (!self.shouldSpin) {
        return;
    }
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.spinnerImageView.transform = CGAffineTransformRotate(self.spinnerImageView.transform, M_PI_2);
    }
                     completion:^(BOOL finished) {
        if (finished) {
            [self spinWheel];
        }
    }];
}

- (void)stopButtonDidPressed:(id)sender {
    self.startButton.enabled = YES;
    self.stopButton.enabled = NO;
    self.endButton.enabled = YES;
    
    self.shouldSpin = NO;
    
    [self.taskTimer invalidate];
    self.taskTimer = nil;
}

- (void)endButtonDidPressed:(id)sender {
    self.startButton.enabled = YES;
    self.stopButton.enabled = NO;
    self.endButton.enabled = NO;
    
    self.shouldSpin = NO;
    
    [self.taskTimer invalidate];
    self.taskTimer = nil;
    
    [self createNewTask];
}

- (void)setTaskTimer:(NSTimer *)taskTimer {
    _taskTimer = taskTimer;
}

- (NSTimer *)taskTimer {
    if (_taskTimer == nil) {
        _taskTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeIntervalAndTimeLabel) userInfo:nil repeats:YES];
    }
    return _taskTimer;
}

- (void)updateTimeIntervalAndTimeLabel
{
    self.timeIntervalFromTaskStarted += 1;
    
    CGFloat seconds = self.timeIntervalFromTaskStarted;
    
    int minutes = floorf((int)seconds / 60);
    int hours = floorf(minutes / 60);
    int leftSeconds = (int)seconds % 60;
    int leftMinutes = minutes % 60;
    
    [self.remainingTimeLabel setText:[NSString stringWithFormat:@"Прошло %d:%d:%d", hours, leftMinutes, leftSeconds]];
}

- (void)createNewTask
{
    // Alert style
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Новое задание" message:@"Чем вы занимались?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler: NULL];
    
    // Make choices for the user using alert actions.
    UIAlertAction *doSomethingAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion: NULL];
    }];
    
    UIAlertAction *doNothingAction = [UIAlertAction actionWithTitle:@"Создать" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textwow = alert.textFields[0];
        if (textwow.text.length > 0) {
            NSString *text = textwow.text;
            Task *newProject = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Task"
                                inManagedObjectContext:appDelegate.managedObjectContext];
            newProject.name = text;
            newProject.createdDate = [NSDate date];
            newProject.timeSpend = @(self.timeIntervalFromTaskStarted);
            
            [appDelegate.managedObjectContext save: nil];
            [alert dismissViewControllerAnimated:YES completion: NULL];
            
            self.timeIntervalFromTaskStarted = 0.0f;
            [self.remainingTimeLabel setText:nil];
        }
    }];
    
    // Add actions to the controller so they will appear
    [alert addAction:doSomethingAction];
    [alert addAction:doNothingAction];
    
    // Finally present the action
    [self presentViewController:alert animated:YES completion:nil];
}

@end
