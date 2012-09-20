//
//  DOPayer.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOPayer : NSObject
{
    NSString *_payerName;
    NSString *_status;
    NSNumber *_livesCovered;
}

@property(nonatomic, retain) NSString *payerName;
@property(nonatomic, retain) NSString *status;
@property(nonatomic, retain) NSNumber *livesCovered;

-(id)initWithName:(NSString *)name status:(NSString *)status andLC:(NSNumber *)lives;
@end
