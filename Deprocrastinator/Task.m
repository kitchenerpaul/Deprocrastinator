//
//  Task.m
//  Deprocrastinator
//
//  Created by Paul Kitchener on 10/24/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "Task.h"

@implementation Task

-(instancetype)initWithTask:(NSString *)task andColor:(UIColor *)color andPriority:(int)priority{
    self = [super init];
    if (self) {
        self.task = task;
        self.color = color;
        self.priority = priority;
    }
    return self;
}

@end
