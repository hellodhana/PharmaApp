//
//  SocialPostTable.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialPostTable : UIView
{
    NSMutableArray *_socialPosts;
    
}

@property (nonatomic,retain) NSMutableArray *socialPosts;

-(id)initWithSocialPosts:(NSMutableArray *)socialPosts frame:(CGRect)frame;

@end
