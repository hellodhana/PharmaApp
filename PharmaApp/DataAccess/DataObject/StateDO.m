//
//  StateDO.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 07/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StateDO.h"

@implementation StateDO
@synthesize code=_code;
@synthesize state=_state;
@synthesize desc=_desc;

-(id)initWithCode:(NSNumber *)code state:(NSString *)state andDesc:(NSString *)desc
{
    self = [super init];
    if(self)
    {
        self.code = code;
        self.state = state;
        self.desc = desc;
    }
    
    return self;
}

@end
