//
//  DOGeo.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOValueSelect.h"

@interface DOGeo : DOValueSelect
{
    NSNumber *_regionID;
    NSString *_territory;
    NSString *_state;
    NSString *_region;
    NSNumber *_hierarchy;
    NSString *_desc;
}

@property(nonatomic, retain) NSNumber *regionID;
@property(nonatomic, retain) NSString *territory;
@property(nonatomic, retain) NSString *state;
@property(nonatomic, retain) NSString *region;
@property(nonatomic, retain) NSNumber *hierarchy;
@property(nonatomic, retain) NSString *desc;

@end
