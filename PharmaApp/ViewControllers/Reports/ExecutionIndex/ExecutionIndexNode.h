//
//  PayerAccessNode.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOExecution.h"
#import "GenericTreeNode.h"
#import "ExecutionIndexNode.h"

@interface ExecutionIndexNode : GenericTreeNode
{
    DOExecution *_execPref;
}

@property(nonatomic, retain) DOExecution *execPref;

-(id)initWithPayerPref:(DOExecution *)execPref;
@end
