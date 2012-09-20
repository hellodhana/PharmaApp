//
//  PercentageProgressBar.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

typedef enum
{       
    ProgressBarGreen,
    ProgressBarRed,
    ProgressBarBrown,
    ProgressBarBlue,
    ProgressBarYellow,
    ProgressBarOrange
} ProgressBarColor;

typedef enum
{
    ProgressStyle,
    SentimentStyle,
} ProgressBarStyle;

@interface PercentageProgressBar : UIView {
@private
    
    UIView* percentView;    

    UIView* percentView1;
    
    UIImageView *bgImageView;
    
    UIImageView *progressImageView;

    UIImageView *progressImageView1;
    
    UIImage *progressFillImage;

    ProgressBarStyle currStyle;
}

@property (nonatomic, readwrite, assign) CGFloat progress;


- (id)initWithFrame:(CGRect)frame andProgressBarStyle:(ProgressBarStyle)barStyle;

-(NSString*)getImageNameFromBarDefinition:(ProgressBarColor)barDef;

-(void)setProgress:(CGFloat)theProgress;
-(void)setProgressinText:(CGFloat)theProgress;
@end