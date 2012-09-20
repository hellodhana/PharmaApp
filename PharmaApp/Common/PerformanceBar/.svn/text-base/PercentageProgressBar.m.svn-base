//
//  PercentageProgressBar.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define LEFT_PADDING 5.0f
#define RIGHT_PADDING 3.0f

#import "PercentageProgressBar.h"

@implementation PercentageProgressBar

@synthesize progress;


- (id)initWithFrame:(CGRect)frame andProgressBarStyle:(ProgressBarStyle)barStyle;
{
    currStyle = barStyle;
    if (self = [super initWithFrame:frame]) 
    {
        NSString* progressFillStr = nil;
        if (barStyle == ProgressStyle) {
            progressFillStr = [self getImageNameFromBarDefinition:ProgressBarBlue]; 
        } 
        else 
        {
            progressFillStr = [self getImageNameFromBarDefinition:ProgressBarGreen];                 
        }

        progressFillImage = [UIImage imageNamed:progressFillStr];
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [bgImageView setImage:[UIImage imageNamed:@"progress-track.png"]];
        
        [self addSubview:bgImageView];
        
        progressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 0, frame.size.height)];

        [self addSubview:progressImageView];

        //Add Negative Sentiment
        if(currStyle == SentimentStyle)
        {
            progressImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 0, frame.size.height)];
            
            [self addSubview:progressImageView1];
        }            
        
        percentView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_PADDING, 6, 32, 17)];
        
        UIImageView* percentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 17)];
        
        [percentImageView setImage:[UIImage imageNamed:@"progress-count.png"]];
        
        UILabel* percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 17)];
        
        [percentLabel setTag:1];
        [percentLabel setText:@"0%"];
        [percentLabel setBackgroundColor:[UIColor clearColor]];
        [percentLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [percentLabel setTextAlignment:UITextAlignmentCenter];
        [percentLabel setAdjustsFontSizeToFitWidth:YES];
        
        [percentView addSubview:percentImageView];
        [percentView addSubview:percentLabel];
        
        [self addSubview:percentView];
        
        //Add Negative Sentiment
        if(currStyle == SentimentStyle)
        {
            UIImageView* percentImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 17)];
            
            [percentImageView1 setImage:[UIImage imageNamed:@"progress-count.png"]];
            
            percentView1 = [[UIView alloc] initWithFrame:CGRectMake(bgImageView.frame.size.width - 4 - 32, 6, 32, 17)];
                        
            percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 17)];
            
            [percentLabel setTag:1];
            [percentLabel setText:@"0%"];
            [percentLabel setBackgroundColor:[UIColor clearColor]];
            [percentLabel setFont:[UIFont boldSystemFontOfSize:13]];
            [percentLabel setTextAlignment:UITextAlignmentCenter];
            [percentLabel setAdjustsFontSizeToFitWidth:YES];
            
            [percentView1 addSubview:percentImageView1];
            [percentView1 addSubview:percentLabel];
            
            [self addSubview:percentView1];
            
        }
        
        self.progress = 0.0f;
    }
    
    return self;
}


- (void)setProgress:(CGFloat)theProgress {
    
    float origProgress = theProgress;
    if (self.progress != theProgress) {
        if (theProgress > 1) {
            theProgress=1;
        }
        if (theProgress >= 0 && theProgress <= 1) {
            
            NSString* progressFillStr = nil;
            
            if (currStyle == SentimentStyle) { 
                progressFillStr = [self getImageNameFromBarDefinition:ProgressBarGreen];
            }
            else {
                if (theProgress <0.85) {
                    progressFillStr = [self getImageNameFromBarDefinition:ProgressBarRed]; 
                } 
                else if (theProgress >= 0.85 &&  theProgress <= 0.95) {
                    progressFillStr = [self getImageNameFromBarDefinition:ProgressBarOrange];                 
                }
                else{
                    progressFillStr = [self getImageNameFromBarDefinition:ProgressBarGreen];               
                }
            }
            progressFillImage = [UIImage imageNamed:progressFillStr];
    
            progress = theProgress;
            
            progressImageView.image = progressFillImage;
            
            CGRect frame = progressImageView.frame;
            
            frame.origin.x = 2;
            frame.origin.y = 2;
            frame.size.height = bgImageView.frame.size.height - 4;
            
            frame.size.width = (bgImageView.frame.size.width - 4) * progress;
            
            progressImageView.frame = frame;
            
            CGRect percentFrame = percentView.frame;
            
            float percentViewWidth = percentView.frame.size.width;
            float leftEdge = (progressImageView.frame.size.width - percentViewWidth) - RIGHT_PADDING;
            
            percentFrame.origin.x = (leftEdge < LEFT_PADDING) ? LEFT_PADDING : leftEdge;
            if (currStyle == ProgressStyle) {
                percentView.frame = percentFrame;
            }


            UILabel* percentLabel = (UILabel*)[percentView viewWithTag:1];
            int positiveSenti = (int)(origProgress*100);
            [percentLabel setText:[NSString  stringWithFormat:@"%d%%", positiveSenti]];
            
            //Negative Sentiment
            if (currStyle == SentimentStyle) { 
                UIImage *redFillImage = [UIImage imageNamed:[self getImageNameFromBarDefinition:ProgressBarRed]];
                progressImageView1.image = redFillImage;
                
                frame = progressImageView1.frame;
                
                frame.origin.x = progressImageView.frame.size.width + 2;
                frame.origin.y = 2;
                frame.size.height = bgImageView.frame.size.height - 4;
                
                frame.size.width = (bgImageView.frame.size.width - 4) * (1 - progress);
                
                progressImageView1.frame = frame;
                
                
                percentLabel = (UILabel*)[percentView1 viewWithTag:1];
                int negativeSenti = 100 - positiveSenti;
                [percentLabel setText:[NSString  stringWithFormat:@"%d%%", negativeSenti]];
            }
        }
    }
}

- (void)setProgressinText:(CGFloat)theProgress {
    
    if (self.progress != theProgress) {
        if (theProgress > 1) {
            theProgress=1;
        }
            
        if (theProgress >= 0 && theProgress <= 1) {
            
            NSString* progressFillStr = nil;
            
            if (theProgress <0.85) {
                progressFillStr = [self getImageNameFromBarDefinition:ProgressBarRed]; 
            } 
            else if (theProgress >= 0.85 &&  theProgress <= 0.95) {
                progressFillStr = [self getImageNameFromBarDefinition:ProgressBarOrange];                 
            }
            else{
                progressFillStr = [self getImageNameFromBarDefinition:ProgressBarGreen];               
            }
            progressFillImage = [UIImage imageNamed:progressFillStr];
            
            
            progress = theProgress;
            
            progressImageView.image = progressFillImage;
            
            CGRect frame = progressImageView.frame;
            
            frame.origin.x = 2;
            frame.origin.y = 2;
            frame.size.height = bgImageView.frame.size.height - 4;
            
            frame.size.width = (bgImageView.frame.size.width - 4) * progress;
            
            progressImageView.frame = frame;
            
            CGRect percentFrame = percentView.frame;
            
            float percentViewWidth = percentView.frame.size.width;
            float leftEdge = (progressImageView.frame.size.width - percentViewWidth) - RIGHT_PADDING;
            
            percentFrame.origin.x = (leftEdge < LEFT_PADDING) ? LEFT_PADDING : leftEdge;
            if (currStyle == ProgressStyle) {
                percentView.frame = percentFrame;
            }
            
            
            UILabel* percentLabel = (UILabel*)[percentView viewWithTag:1];
            int positiveSenti = (int)(progress*100);
            positiveSenti=positiveSenti/4;
            [percentLabel setText:[NSString  stringWithFormat:@"%d", positiveSenti]];
            
            //Negative Sentiment
            if (currStyle == SentimentStyle) { 
                UIImage *redFillImage = [UIImage imageNamed:[self getImageNameFromBarDefinition:ProgressBarRed]];
                progressImageView1.image = redFillImage;
                
                frame = progressImageView1.frame;
                
                frame.origin.x = progressImageView.frame.size.width + 2;
                frame.origin.y = 2;
                frame.size.height = bgImageView.frame.size.height - 4;
                
                frame.size.width = (bgImageView.frame.size.width - 4) * (1 - progress);
                
                progressImageView1.frame = frame;
                
                
                percentLabel = (UILabel*)[percentView1 viewWithTag:1];
                int negativeSenti = 100 - positiveSenti;
                negativeSenti=negativeSenti/4;
                
                [percentLabel setText:[NSString  stringWithFormat:@"%d", negativeSenti]];
            }
        }
    }
}



-(NSString*)getImageNameFromBarDefinition:(ProgressBarColor)barDef
{
    NSString* imageName;
    
    switch (barDef) {
        case ProgressBarBlue:
            imageName = @"progress-fill-blue.png";
            break;
        case ProgressBarRed:
            imageName = @"progress-fill-red.png";
            break;
        case ProgressBarBrown:
            imageName = @"progress-fill-brown.png";
            break;
        case ProgressBarYellow:
            imageName = @"progress-fill-yellow.png";
            break;
        case ProgressBarOrange:
            imageName = @"progress-fill-orange.png";
            break;
        case ProgressBarGreen:
            imageName = @"progress-fill-green.png";
            break;
        default:
            imageName = @"progress-fill-green.png";
            break;
    }
    
    return imageName;
}





@end

