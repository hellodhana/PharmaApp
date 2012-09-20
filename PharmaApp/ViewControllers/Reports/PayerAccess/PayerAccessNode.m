//
//  PayerAccessNode.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PayerAccessNode.h"

@implementation PayerAccessNode
@synthesize payerPref=_payerPref;


-(id)initWithPayerPref:(DOPayerPerf *)payerPref
{
    self = [super initWithValue:payerPref.regionDO.desc];
    if(self)
    {
        self.payerPref = payerPref;
    }    
    return self;
}

@end
