//
//  HTMLBuilder.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandPerfRegionDO.h"
#import "SFACommons.h"

@interface HTMLBuilder : NSObject

+(NSString *)htmlForDashboardMapwithWidth:(int)width andHeight:(int)height;

+(NSString *)dataForPerfBubbleChart:(NSArray *)regionBrandPerfArray;

+(NSString *)htmlForPerfBubbleChart:(NSString *)chartData;

+(NSString *)htmlForDashboardMapForPerfDetail:(NSArray *)perfArray;

+(NSString *)htmlForDashboardMapForFinPerfDetail:(NSArray *)perfArray paerntReg:(NSString *)parentRegion andCenter:(NSString *)center;

+(NSString *)htmlForForceDirected;

+(NSString *)jsonForForceDirected;



+(NSString *)htmlForLineChat;

+(NSString *)htmlForWordCloud:(NSString *)brandName rskflag:(NSInteger)flag;//gaurav

+(NSString *)dataForAdopDuraBubbleChart:(NSArray *)regionBrandPerfArray;

+(NSString *)htmlForAdopDuraBubbleChart:(NSString *)chartData;

+(NSString *)htmlForPayerAccess:(NSArray *)topPayers;
@end
