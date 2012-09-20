//
//  GenericTreeNode.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericTreeNode : NSObject
{
    int index;
    NSString *value;
    GenericTreeNode *parent;
    NSMutableArray *children;
    BOOL inclusive;
    NSArray *flattenedTreeCache;
  
}

@property (nonatomic) int index;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) GenericTreeNode *parent;
@property (nonatomic, retain, readonly) NSMutableArray *children;
@property (nonatomic) BOOL inclusive;

- (id)initWithValue:(NSString *)_value;

- (void)addChild:(GenericTreeNode *)newChild;
- (NSUInteger)descendantCount;
- (NSUInteger)levelDepth;
- (NSArray *)flattenElements;
- (NSArray *)flattenElementsWithCacheRefresh:(BOOL)invalidate;
- (BOOL)isRoot;
- (BOOL)hasChildren;

@end