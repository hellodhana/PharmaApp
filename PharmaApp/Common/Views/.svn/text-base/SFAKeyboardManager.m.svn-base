//
//  SFAKeyboardManager.m
//  SFA
//
//  Created by Javier on 5/26/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAKeyboardManager.h"

static SFAKeyboardManager *sharedInstance = nil;

@implementation SFAKeyboardManager

@synthesize isVisible = _isVisible;

#pragma mark -
#pragma mark Singleton methods

// Private "init" method that should only be used internally
- (id)initApplicationContext
{
    self = [super init];
    if (self != nil) {
        self.isVisible = NO;
    }
    return self;
}

+ (SFAKeyboardManager *)sharedInstance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:NULL] initApplicationContext];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


// IMPORTANT: override here all the "initWith…" and instance getter methods that should not be invoked directly, invalidating them.
- (id)init {
    @throw [NSException exceptionWithName: @"NotSupportedException" reason: @"This is a singleton class. No init method can be used. Use '+(SFAKeyboardManager *)sharedInstance' method to get the instance..." userInfo: nil];
}

@end
