//
//  SocialPostDO.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialPostDO : NSObject
{
    NSString *_when;
    NSString *_user;
    NSString *_content;
    NSString *_source;
}

@property(nonatomic, retain) NSString *when;
@property(nonatomic, retain) NSString *user;
@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) NSString *source;

-(id)initWithPost:(NSString *)post byUser:(NSString *)user onDate:(NSString *)date from:(NSString *)source;
@end
