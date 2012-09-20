//
//  DOBrand.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOValueSelect.h"

@interface DOBrand : DOValueSelect
{
    NSNumber *_brandID;
    NSString *_brandDesc;
}

@property(nonatomic, retain) NSNumber *brandID;
@property(nonatomic, retain) NSString *brandDesc;

-(id)initWithBrandID:(NSNumber *)brandID brandDesc:(NSString *)desc;
@end
