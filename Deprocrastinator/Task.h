//
//  Task.h
//  Deprocrastinator
//
//  Created by Paul Kitchener on 10/24/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Task : NSObject

@property NSString *task;
@property UIColor *color;
@property int priority;

-(instancetype)initWithTask:(NSString *)task andColor:(UIColor *)color andPriority:(int)priority;

@end
