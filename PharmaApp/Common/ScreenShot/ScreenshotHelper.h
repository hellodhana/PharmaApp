//
//  ScreenshotHelper.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 18/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScreenshotHelper : NSObject

+ (id)sharedInstance;

-(void) refreshStorage;
-(void) writeImagetoStore:(UIImage *)image;
-(void) writeImagetoStore:(UIImage *)image fileName:(NSString *)fileName;
-(NSArray *)readImageStore;

@end
