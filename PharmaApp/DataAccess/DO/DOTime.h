//
//  DOTime.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOValueSelect.h"

@interface DOTime : DOValueSelect
{
    NSNumber *_timID;
    NSString *_month;    
    NSNumber *_year;
}

@property(nonatomic, retain) NSNumber *timID;
@property(nonatomic, retain) NSString *month;    
@property(nonatomic, retain) NSNumber *year; 

-(id)initWithID:(NSNumber *)timID month:(NSString *)month year:(NSNumber *)year;
@end
