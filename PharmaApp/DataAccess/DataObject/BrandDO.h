//
//  BrandDO.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandDO : NSObject
{
    NSNumber *_brandID;
    NSString *_brandDesc;
}

@property(nonatomic, retain) NSNumber *brandID;
@property(nonatomic, retain) NSString *brandDesc;

-(id)initWithBrandID:(NSNumber *)brandID brandDesc:(NSString *)desc;

@end
