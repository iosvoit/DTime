//
//  SecondViewController.m
//  DTime
//
//  Created by Christina on 05.10.14.
//  Copyright (c) 2014 Christina. All rights reserved.
//

#import "SecondViewController.h"
#import "TaskDetailsViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end


@implementation SecondViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performFetch];
    [self.tableView reloadData];
}

- (void)performFetch
{
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Task" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    self.projectsArray = array.mutableCopy;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.projectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    Task *projectwow = self.projectsArray [indexPath.row];
    cell.textLabel.text = projectwow.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"showDetailsSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetailsSegue"]) {
        TaskDetailsViewController *detailsViewController = segue.destinationViewController;
        Task *task = self.projectsArray[self.selectedIndexPath.row];
        detailsViewController.task = task;
    }
}

@end
