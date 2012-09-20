//
//  SocialPostDO.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialPostDO.h"

@implementation SocialPostDO
@synthesize when=_when;
@synthesize user=_user;
@synthesize content=_content;
@synthesize source=_source;

-(id)initWithPost:(NSString *)post byUser:(NSString *)user onDate:(NSString *)date from:(NSString *)source
{
    self = [super init];
    if(self)
    {
        self.when = date;
        self.user = user;
        self.content = post;
        self.source = source;
    }
    
    return self;
}
@end
