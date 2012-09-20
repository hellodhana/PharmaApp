//
//  DOTime.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DOTime.h"

@implementation DOTime
@synthesize timID=_timID;
@synthesize month=_month;
@synthesize year=_year;

-(NSString *)getValueSelectDescription
{
    return [NSString stringWithFormat:@"%@/%d",self.month, [self.year intValue]];
}

-(id)initWithID:(NSNumber *)timID month:(NSString *)month year:(NSNumber *)year
{
    self = [super init];
    if(self)
    {
        self.timID = timID;
        self.month = month;
        self.year = year;
    }
    return self;
}
@end
