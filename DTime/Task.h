//
//  Task.h
//  DTime
//
//  Created by Christina on 26.10.14.
//  Copyright (c) 2014 Christina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * closedDate;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * discription;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * timeSpend;

@end
