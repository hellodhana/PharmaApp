//
//  HTMLBuilder.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HTMLBuilder.h"
#import "RegionBrandPerfDO.h"
#import "DashboardMainVC.h"
#import "SharedData.h"
#import "DOPayer.h"
#import "DOBrandPerf.h"

#define FUSION_TABLE_REGION    @"3514170"
#define FUSION_TABLE_DISTRICT  @"3515247"
#define FUSION_TABLE_TERRITORY @"3647788"

@implementation HTMLBuilder

+(NSString *)htmlForDashboardMapwithWidth:(int)width andHeight:(int)height
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:
    
    @"<html>"
    @"<head>"
    @"<meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\" />"
    @"<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>"
    @"<link href=\"/maps/documentation/javascript/examples/default.css\" rel=\"stylesheet\"" 
    @"type=\"text/css\" />"
    @"<script type=\"text/javascript\" src=\"https://maps.googleapis.com/maps/api/js?sensor=false\">"
    @"</script>"
    @"<script type=\"text/javascript\">"
    
    @"function initialize() {"
        @"var usa = new google.maps.LatLng(37.09024,-95.712891);"
    
        @"map = new google.maps.Map(document.getElementById('map_canvas'), {"
            @"center: usa,"
            @"zoom: 3,"
            @"mapTypeId: google.maps.MapTypeId.ROADMAP,"
            @"mapTypeControl: false,"
            @"mapTypeControlOptions: {"
                @"style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,"
                @"position: google.maps.ControlPosition.BOTTOM_RIGHT"
            @"}"                                   
        @"});"
    
        @"layer = new google.maps.FusionTablesLayer({"
            @"suppressInfoWindows: true,"                                   
            @"query: {"
                @"select: 'geometry',"
                @"from: '3514170'"
            @"},"
            @"styles: [{"
                @"polygonOptions: {"
                    @"fillColor: \"#4A8D46\","
                    @"fillOpacity: 0.3"
                @"}"
                @"}, {"
                @"where: \"'id' = 'WEST'\","
                @"polygonOptions: {"
                    @"fillColor: \"#CF145A\""
                @"}"
                @"}, {"
                @"where: \"'id' = 'EAST'\","
                @"polygonOptions: {"
                    @"fillColor: \"#FF00FF\""
                @"}"
                @"}, {"
                @"where: \"'id' = 'SOUTH'\","
                @"polygonOptions: {"
                    @"fillColor: \"#4A8D46\""
                @"}"
                @"}"
            @"]"
        @"});"
        
        @"layer.setMap(map);"
        
        @"google.maps.event.addListener(map, 'zoom_changed'," 
        @"function() {"
            @"zoomLevel = map.getZoom();"
            @"if (zoomLevel <= 3) {"
               @"layer.setOptions({"
                    @"query: {"
                        @"select: 'geometry',"
                        @"from: '3514170'"
                    @"},"
                    @"styles: [{"
                                   @"polygonOptions: {"
                                   @"fillColor: \"#4A8D46\","
                                   @"fillOpacity: 0.3"
                                   @"}"
                                   @"}, {"
                                   @"where: \"'id' = 'WEST'\","
                                   @"polygonOptions: {"
                                   @"fillColor: \"#CF145A\""
                                   @"}"
                                   @"}, {"
                                   @"where: \"'id' = 'EAST'\","
                                   @"polygonOptions: {"
                                   @"fillColor: \"#FF00FF\""
                                   @"}"
                                   @"}, {"
                                   @"where: \"'id' = 'SOUTH'\","
                                   @"polygonOptions: {"
                                   @"fillColor: \"#4A8D46\""
                                   @"}"
                        @"}"
                    @"]"
                @"});"
            @"}"
            @"if (zoomLevel > 3) {"
                @"layer.setOptions({"
                    @"query: {"
                        @"select: 'geometry',"
                        @"from: '3515247'"
                    @"},"
                    @"styles: [{"
                        @"polygonOptions: {"
                            @"fillColor: \"#CF145A\","
                            @"fillOpacity: 0.3"
                        @"}"
                        @"}, {"
                        @"where: \"Growth > 0 AND Growth < 85\","
                        @"polygonOptions: {"
                            @"fillColor: \"#CF145A\""
                        @"}"
                        @"}, {"
                        @"where: \"Growth >= 85 AND Growth <= 95\","
                        @"polygonOptions: {"
                            @"fillColor: \"#D88A04\""
                        @"}"
                        @"}, {"
                        @"where: \"Growth > 95\","
                        @"polygonOptions: {"
                            @"fillColor: \"#4A8D46\""
                        @"}"
                        @"}"
                    @"]"
                @"});"
            @"}"    
        @"});"
        @"google.maps.event.addListener(layer, 'click'," 
         @"function(event) {" 
         @"window.location.href = \"myapp://mapClicked\";"
         @"var info = document.getElementById('info_html').value;"
         //@"map.openInfoWindowHtml(event.latLng,\"Dhana\");"
         @"event.infoWindowHtml = info;"                                   
        @"});"                                   
    @"}"
    @"</script>"
    @"</head>"
    @"<body onload=\"initialize()\">"
    @"<div id=\"map_canvas\" style=\""
    @"position: fixed;left: 0;top: 0;width: 100%;height: 100%;border:1px solid #000000;margin:0px;\"></div>"
    @"<div id=\"info_html\"></div>"];

    //[returnHTML appendFormat:@"%dpx; width:%dpx; margin: -2px\"></div>",height, width];
    [returnHTML appendString:@"</body></html>"];
    
    return returnHTML;
}

+(NSString *)dataForPerfBubbleChart:(NSArray *)regionBrandPerfArray
{
    NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"["];
    
    //Add Data Header
    [returnString appendString:@"['ID', 'Execution Index', 'Financial Performance', 'Brand Health', 'Revenue'],"];
    [returnString appendString:@"['Default', 0, 0, '0 - 84', 0]"];
    
    for (DOBrandPerf *brandPerf in regionBrandPerfArray) {
        
        int exeIndex = [brandPerf.execAct floatValue];
        int finIndex = [brandPerf.finAct doubleValue] ;   
        int healthIndex = ([brandPerf.healthAct floatValue] / [brandPerf.healthPln floatValue]) * 100.0;
        
        [returnString appendString:@",['"];
        [returnString appendString:brandPerf.doRegion.desc];
        [returnString appendString:@"', "];
        [returnString appendString:[NSString stringWithFormat:@"{v:%d,f:'%d%%'}",exeIndex,exeIndex]];
        [returnString appendString:@", "];        
        [returnString appendString:[NSString stringWithFormat:@"{v:%d,f:'%d%%'}",finIndex,finIndex]];
        [returnString appendString:@", "];
        if(healthIndex < 85)
        {
            [returnString appendString:[NSString stringWithFormat:@"{v:'0 - 84',f:'%d'}",healthIndex]];
        }
        else if(healthIndex >= 85 && healthIndex <= 95)
        {
           
            [returnString appendString:[NSString stringWithFormat:@"{v:'85 - 95',f:'%d'}",healthIndex]];
        }  
        else
        {
            [returnString appendString:[NSString stringWithFormat:@"{v:'96 - 100',f:'%d'}",healthIndex]];
        }
 
        [returnString appendString:@", "];
        
        //int salesPlnK = [brandPerf.salesPln longValue] / 1000;
        int salesActK = [brandPerf.salesAct longValue] / 1000;        
        if(salesActK < 50)
        { 
            [returnString appendString:[NSString stringWithFormat:@"{v:10,f:'$%d.0M'}",salesActK]];
        }
        else if(salesActK >= 50 && salesActK <= 150)
        {            
            [returnString appendString:[NSString stringWithFormat:@"{v:20,f:'$%d.0M'}",salesActK]];
        }  
        else
        {
            [returnString appendString:[NSString stringWithFormat:@"{v:30,f:'$%d.0M'}",salesActK]];
        }

        
        [returnString appendString:@"]"];        
    }
    
    [returnString appendString:@"]"];

    return returnString;
}

+(NSString *)htmlForPerfBubbleChart:(NSString *)chartData
{

    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:                                   
            @"<html>"
            @"<head>"
            @"<meta name=\"viewport\" content=\"width=device-width, target-densitydpi=160dpi, initial-scale=1.0\">"
            @"<script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>"
            @"<script type=\"text/javascript\">"
            @"google.load(\"visualization\", \"1\", {packages:[\"corechart\"]});"
            @"google.setOnLoadCallback(drawChart);"
            @"function drawChart() {"
            @"var data = google.visualization.arrayToDataTable("];
    
    [returnHTML appendString:chartData];
    [returnHTML appendString:@",false);"];
    
    [returnHTML appendString:@"var options = {"
    @"title: '',"
     @"chartArea: {width: '70%', height: '60%', top:'70'},"
    @"legend: {position: 'none'},"     
    @"hAxis: {title: 'Execution Index' ,fontName:'Arial', minValue: 0, maxValue: 120},"
    @"vAxis: {title: 'Financial Performance', minValue: 0, maxValue: 120},"
    @"bubble: {textStyle: {fontSize: 10},opacity:0.9},"
    @"sizeAxis: {minSize: 10, maxSize: 20 },"
    @"series: {'0 - 84': {color: '#CF145A'}, '85 - 95': {color: '#D88A04'}, '96 - 100': {color: '#4A8D46'}},"
    @"};"];
    
    [returnHTML appendString:
     @"var chart = new google.visualization.BubbleChart(document.getElementById('chart_div'));"
     @"data.removeRow(0);"
     
     @"chart.draw(data, options);"
     @"var lineELe = document.getElementById('horlineEle');"
     @"lineELe.getContext(\"2d\").dashedLine(102, 1, 630, 1, 2);"
     @"var lineELe = document.getElementById('verlineEle');"
     @"lineELe.getContext(\"2d\").dashedLine(1, 50, 1, 350, 2);"     
     @"}"
     @"CanvasRenderingContext2D.prototype.dashedLine = function(x1, y1, x2, y2, dashLen) {"
         @"if (dashLen == undefined) dashLen = 2;"
         
         @"this.beginPath();"
         @"this.moveTo(x1, y1);"
         
         @"var dX = x2 - x1;"
         @"var dY = y2 - y1;"
         @"var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);"
         @"var dashX = dX / dashes;"
         @"var dashY = dY / dashes;"
         
         @"var q = 0;"
         @"while (q++ < dashes) {"
             @"x1 += dashX;"
             @"y1 += dashY;"
             @"this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x1, y1);"
         @"}"
         @"this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x2, y2);"
         
         @"this.stroke();"
         @"this.closePath();"
     @"};"     
     @"</script>"
     @"</head>"
     @"<body>"
     @"<div id=\"chart_div\" style=\"fixed;left: 0;top: 0;width: 100%; height: 100%;\"></div>"
     @"<div class=\"canvas\" style=\"position:fixed; left:20px; top:120px\"><canvas id=\"horlineEle\" width=\"900\" height=\"2\"></canvas></div>"
     @"<div class=\"canvas\" style=\"position:fixed; left:560px; top:30px\"><canvas id=\"verlineEle\" width=\"2\" height=\"600\"></canvas></div>"
     @"</body>"
     @"</html>"];
    
    // NSLog(@"Html : %@",returnHTML);

    return returnHTML;
}

+(NSString *)dataForAdopDuraBubbleChart:(NSArray *)regionBrandPerfArray
{
    
    NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"["];
    
    //Add Data Header
    [returnString appendString:@"['ID', 'Durability Index', 'Adoption Index', 'Risk', 'Revenue'],"];
    [returnString appendString:@"['Default', 0, 0, 'Not at Risk', 0]"];
    
    for (DOBrandPerf *brandPerf in regionBrandPerfArray) {
        
        int durIndex = [brandPerf.durabAct floatValue];
        int adaIndex = [brandPerf.adapAct doubleValue] ;   
        
        [returnString appendString:@",['"];
        [returnString appendString:brandPerf.doRegion.desc];
        [returnString appendString:@"', "];
        [returnString appendString:[NSString stringWithFormat:@"{v:%d,f:'%d%%'}",durIndex,durIndex]];
        [returnString appendString:@", "];        
        [returnString appendString:[NSString stringWithFormat:@"{v:%d,f:'%d%%'}",adaIndex,adaIndex]];
        [returnString appendString:@", "];
        
        if((durIndex - adaIndex) > - 15 && (durIndex - adaIndex) < 15)
        {
            [returnString appendString:@"'Not at Risk'"];
        }
        else 
        {
            [returnString appendString:@"'At Risk'"];
        }
        
        [returnString appendString:@", "];
        
        //int salesPlnK = [brandPerf.salesPln longValue] / 1000;
        int salesActK = [brandPerf.salesAct longValue] / 1000;        
        if(salesActK < 50)
        { 
            [returnString appendString:[NSString stringWithFormat:@"{v:10,f:'$%d.0M'}",salesActK]];
        }
        else if(salesActK >= 50 && salesActK <= 150)
        {            
            [returnString appendString:[NSString stringWithFormat:@"{v:20,f:'$%d.0M'}",salesActK]];
        }  
        else
        {
            [returnString appendString:[NSString stringWithFormat:@"{v:30,f:'$%d.0M'}",salesActK]];
        }
        
        
        [returnString appendString:@"]"];        
    }
    
    [returnString appendString:@"]"];
    
    return returnString;    
    
}

+(NSString *)htmlForAdopDuraBubbleChart:(NSString *)chartData
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:                                   
                                   @"<html>"
                                   @"<head>"
                                   @"<script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>"
                                   @"<script type=\"text/javascript\">"
                                   @"google.load(\"visualization\", \"1\", {packages:[\"corechart\"]});"
                                   @"google.setOnLoadCallback(drawChart);"
                                   @"function drawChart() {"
                                   @"var data = google.visualization.arrayToDataTable("];
    
    [returnHTML appendString:chartData];
    [returnHTML appendString:@");"];
    
    [returnHTML appendString:@"var options = {"
     @"title: '',"
     @"hAxis: {title: 'Durability Index' , minValue: 0, maxValue: 120},"
     @"vAxis: {title: 'Adoption Index', minValue: 0, maxValue: 120},"
     @"legend: {position: 'none'},"
     @"sizeAxis: {minSize: 10, maxSize: 20 },"     
     @"bubble: {textStyle: {fontSize: 11}},"
     @"series: {'At Risk': {color: 'red'}, 'Not at Risk': {color: 'green'}}" 
     @"};"];
    
    [returnHTML appendString:
     @"var chart = new google.visualization.BubbleChart(document.getElementById('chart_div'));"
     @"data.removeRow(0);"
     
     @"chart.draw(data, options);"
     @"}"
     @"</script>"
     @"</head>"
     @"<body>"
     @"<div id=\"chart_div\" style=\"fixed;left: 0;top: 0;width: 100%; height: 100%;\"></div>"
     @"</body>"
     @"</html>"];
    
        // NSLog(@"%@",returnHTML);
 
    return returnHTML;
    
}

+(NSString *)htmlForDashboardMapForPerfDetail:(NSArray *)perfArray;
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:@""];
    
    NSMutableString *regredSet = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *regyellowSet = [[NSMutableString alloc] initWithString:@""];    
    NSMutableString *regblueSet =  [[NSMutableString alloc] initWithString:@""];   
    NSMutableString *reggreenSet = [[NSMutableString alloc] initWithString:@""];    
    NSMutableString *disredSet = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *disyellowSet = [[NSMutableString alloc] initWithString:@""];    
    NSMutableString *disblueSet =  [[NSMutableString alloc] initWithString:@""];   
    NSMutableString *disgreenSet = [[NSMutableString alloc] initWithString:@""];  
    NSMutableString *terredSet = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *teryellowSet = [[NSMutableString alloc] initWithString:@""];    
    NSMutableString *terblueSet =  [[NSMutableString alloc] initWithString:@""];   
    NSMutableString *tergreenSet = [[NSMutableString alloc] initWithString:@""];      
    for (BrandPerfRegionDO *perfDO in perfArray) {
        
        int growth = [perfDO.performance intValue];  
        int hier = [perfDO.hierarchy intValue];
        
        switch (hier) {
            case REGIONS_HIER_REGION:
                if(growth < 85)
                {
                    if ([regredSet isEqualToString:@""]) {
                        [regredSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [regredSet appendFormat:@", '%@'",perfDO.region];    
                    }            
                }
                else if(growth >= 85 && growth <=95)
                {
                    if ([regyellowSet isEqualToString:@""]) {
                        [regyellowSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [regyellowSet appendFormat:@", '%@'",perfDO.region];    
                    }             
                }
                else if(growth > 95)
                {
                    if ([reggreenSet isEqualToString:@""]) {
                        [reggreenSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [reggreenSet appendFormat:@", '%@'",perfDO.region];    
                    }            
                }
                
                break;
            case REGIONS_HIER_DISTRICT:
                if(growth < 85)
                {
                    if ([disredSet isEqualToString:@""]) {
                        [disredSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [disredSet appendFormat:@", '%@'",perfDO.region];    
                    }            
                }
                else if(growth >= 85 && growth <=95)
                {
                    if ([disyellowSet isEqualToString:@""]) {
                        [disyellowSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [disyellowSet appendFormat:@", '%@'",perfDO.region];    
                    }             
                }
                else if(growth > 95 )
                {
                    if ([disgreenSet isEqualToString:@""]) {
                        [disgreenSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [disgreenSet appendFormat:@", '%@'",perfDO.region];    
                    }            
                }
                
                break;
                
            case REGIONS_HIER_TERRITORY:
                if(growth < 85)
                {
                    if ([terredSet isEqualToString:@""]) {
                        [terredSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [terredSet appendFormat:@", '%@'",perfDO.region];    
                    }            
                }
                else if(growth >= 85 && growth <=95)
                {
                    if ([teryellowSet isEqualToString:@""]) {
                        [teryellowSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [teryellowSet appendFormat:@", '%@'",perfDO.region];    
                    }             
                }
                else if(growth > 95)
                {
                    if ([tergreenSet isEqualToString:@""]) {
                        [tergreenSet appendFormat:@"'%@'",perfDO.region];
                    }
                    else {
                        [tergreenSet appendFormat:@", '%@'",perfDO.region];    
                    }            
                }
                
                break;
            default:
                break;
        }
    }
    
    //Construct HTML
    [returnHTML appendString:
        @"<html>"
        @"<head>"
        @"<meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\" />"
        @"<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>"
        @"<link href=\"/maps/documentation/javascript/examples/default.css\" rel=\"stylesheet\"" 
        @"type=\"text/css\" />"
        @"<script type=\"text/javascript\" src=\"https://maps.googleapis.com/maps/api/js?sensor=false\">"
        @"</script>"
        @"<script type=\"text/javascript\">"
    
        @"function initialize() {"
            @"var usa = new google.maps.LatLng(37.09024,-95.712891);"
    
            @"map = new google.maps.Map(document.getElementById('map_canvas'), {"
                @"center: usa,"
                @"zoom: 3,"
                @"mapTypeId: google.maps.MapTypeId.ROADMAP,"
                @"mapTypeControl: false,"
                @"mapTypeControlOptions: {"
                    @"style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,"
                    @"position: google.maps.ControlPosition.BOTTOM_RIGHT"
                @"}"                                   
            @"});"
    
            @"layer = new google.maps.FusionTablesLayer({"   
                @"suppressInfoWindows: true,"                                        
                @"query: {"
                    @"select: 'geometry',"
                    @"from:'"];
    
    [returnHTML appendString:FUSION_TABLE_REGION];
    
    [returnHTML appendString:@"'},"
            @"styles: [{"
            @"polygonOptions: {"
            @"fillColor: \"#FFFFFF\","
            @"fillOpacity: 0.3"
            @"}"
            @"}"];
     
    if(![regredSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
                              @"where: \"'id' IN ("];
        [returnHTML appendString:regredSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#CF145A\""
         @"}"
         @"}"];  
    }
    if(![regyellowSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regyellowSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#D88A04\""
         @"}"
         @"}"];  
    }
    if(![regblueSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regblueSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    if(![reggreenSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:reggreenSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    [returnHTML appendString:
         @"]"
         @"});"];    
    
    [returnHTML appendString:
        @"layer.setMap(map);"    
        @"google.maps.event.addListener(map, 'zoom_changed'," 
        @"function() {"
            @"zoomLevel = map.getZoom();"
            @"document.getElementById('zoom_lvl').value = zoomLevel;"
//Set Region Layer option     
            @"if (zoomLevel <= 3) {"
                @"layer.setOptions({"
                    @"suppressInfoWindows: true,"                                        
                    @"query: {"
                    @"select: 'geometry',"
                    @"from:'"];
    
    [returnHTML appendString:FUSION_TABLE_REGION];
    
    [returnHTML appendString:@"'},"
     @"styles: [{"
     @"polygonOptions: {"
     @"fillColor: \"#FFFFFF\","
     @"fillOpacity: 0.3"
     @"}"
     @"}"];
    
    if(![regredSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regredSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#CF145A\""
         @"}"
         @"}"];  
    }
    if(![regyellowSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regyellowSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#D88A04\""
         @"}"
         @"}"];  
    }
    if(![regblueSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regblueSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    if(![reggreenSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:reggreenSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    [returnHTML appendString:
     @"]"
     @"});}"]; 
    
//Set District Layer option     
    [returnHTML appendString:
     @"if (zoomLevel == 4) {"
     @"layer.setOptions({"
     @"suppressInfoWindows: true,"                                        
     @"query: {"
     @"select: 'geometry',"
     @"from:'"];
    
    [returnHTML appendString:FUSION_TABLE_DISTRICT];
    
    [returnHTML appendString:@"'},"
     @"styles: [{"
     @"polygonOptions: {"
     @"fillColor: \"#FFFFFF\","
     @"fillOpacity: 0.3"
     @"}"
     @"}"];
    
    if(![disredSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:disredSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#CF145A\""
         @"}"
         @"}"];  
    }
    if(![disyellowSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:disyellowSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#D88A04\""
         @"}"
         @"}"];  
    }
    if(![disblueSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:disblueSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    if(![disgreenSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:disgreenSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    [returnHTML appendString:
     @"]"
     @"});}"];    
    //Set Territory Layer option     
    [returnHTML appendString:
     @"if (zoomLevel > 4) {"
     @"layer.setOptions({"
     @"suppressInfoWindows: true,"                                        
     @"query: {"
     @"select: 'geometry',"
     @"from:'"];
    
    [returnHTML appendString:FUSION_TABLE_TERRITORY];
    
    [returnHTML appendString:@"'},"
     @"styles: [{"
     @"polygonOptions: {"
     @"fillColor: \"#FFFFFF\","
     @"fillOpacity: 0.3"
     @"}"
     @"}"];
    
    if(![terredSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:terredSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#CF145A\""
         @"}"
         @"}"];  
    }
    if(![teryellowSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:teryellowSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#D88A04\""
         @"}"
         @"}"];  
    }
    if(![terblueSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:terblueSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    if(![tergreenSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:tergreenSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    [returnHTML appendString:
     @"]"
     @"});}"];    
    
    [returnHTML appendString:
        @"window.location.href = \"myapp://zoomChanged\";" 
        @"});"];

    [returnHTML appendString:
     @"google.maps.event.addListener(layer, 'click'," 
     @"function(event) {" 
        @"document.getElementById('sel_reg').value = event.row['id'].value;"
        @"window.location.href = \"myapp://mapClicked\";"                                 
     @"});"];      
    [returnHTML appendString:
        @"}"
        @"</script>"
        @"</head>"
        @"<body onload=\"initialize()\">"
        @"<div id=\"map_canvas\" style=\""
        @"position: fixed;left: 0;top: 0;width: 100%;height: 100%;border:1px solid #000000;margin:0px;\"></div>"
        @"<div id=\"sel_reg\"></div>"
        @"<div id=\"zoom_lvl\"></div>"
     ];
    
    //[returnHTML appendFormat:@"%dpx; width:%dpx; margin: -2px\"></div>",height, width];
    [returnHTML appendString:@"</body></html>"];
    

    return returnHTML;
}

+(NSString *)htmlForDashboardMapForFinPerfDetail:(NSArray *)perfArray paerntReg:(NSString *)parentRegion andCenter:(NSString *)center;
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:@""];
    int hier = 0;
    
    NSMutableString *regredSet = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *regyellowSet = [[NSMutableString alloc] initWithString:@""];    
    NSMutableString *regblueSet =  [[NSMutableString alloc] initWithString:@""];   
    NSMutableString *reggreenSet = [[NSMutableString alloc] initWithString:@""];    
    
    for (DOBrandPerf *perfDO in perfArray) {

        hier = [perfDO.doRegion.hier intValue];
        NSString *regionStr = nil;
        if(hier == 1)
        {
            regionStr = perfDO.doRegion.region;
        }
        else if (hier == 2) {
            regionStr = perfDO.doRegion.state;
        }
        else if (hier == 3) {
            regionStr = perfDO.doRegion.territory;            
        }        
     
        int growth = ( [perfDO.salesAct floatValue] / [perfDO.salesPln floatValue] ) * 100; 
          // NSLog(@"regionStr :%@ , growth :%d",regionStr,growth);

                if(growth <= 85)
                {
                    if ([regredSet isEqualToString:@""]) {
                        [regredSet appendFormat:@"'%@'",regionStr];
                    }
                    else {
                        [regredSet appendFormat:@", '%@'",regionStr];    
                    }            
                }
                else if(growth > 85 && growth <=95)
                {
                    if ([regyellowSet isEqualToString:@""]) {
                        [regyellowSet appendFormat:@"'%@'",regionStr];
                    }
                    else {
                        [regyellowSet appendFormat:@", '%@'",regionStr];    
                    }             
                }
                else if(growth > 95)
                {
                    if ([regblueSet isEqualToString:@""]) {
                        [regblueSet appendFormat:@"'%@'",regionStr];
                    }
                    else {
                        [regblueSet appendFormat:@", '%@'",regionStr];    
                    } 
                }
                else
                {
                    if ([reggreenSet isEqualToString:@""]) {
                        [reggreenSet appendFormat:@"'%@'",regionStr];
                    }
                    else {
                        [reggreenSet appendFormat:@", '%@'",regionStr];    
                    }            
                }
    }

    //Construct HTML
    [returnHTML appendString:
     @"<html>"
     @"<head>"
     @"<meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\" />"
     @"<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>"
     @"<link href=\"/maps/documentation/javascript/examples/default.css\" rel=\"stylesheet\"" 
     @"type=\"text/css\" />"
     @"<script type=\"text/javascript\" src=\"https://maps.googleapis.com/maps/api/js?sensor=false\">"
     @"</script>"
     @"<script type=\"text/javascript\">"
     @"function initialize() {"];
     
     if(center)
     {
         [returnHTML appendFormat:@"var usa = new google.maps.LatLng(%@);",center];
     }
     else 
     {
         [returnHTML appendString:@"var usa = new google.maps.LatLng(37.09024,-95.712891);"];
     }
         
     
    [returnHTML appendString:@"map = new google.maps.Map(document.getElementById('map_canvas'), {"
     @"center: usa," ];
    
    if(hier <= 1)
    {    
        [returnHTML appendString:@"zoom: 3,"];
    }
    else if(hier == 2)
    {
        [returnHTML appendString:@"zoom: 4,"];        
    }    
    else {
        [returnHTML appendString:@"zoom: 5,"];
    }
    
    [returnHTML appendString:
     @"mapTypeId: google.maps.MapTypeId.ROADMAP,"
     @"mapTypeControl: false,"
     @"mapTypeControlOptions: {"
     @"style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,"
     @"position: google.maps.ControlPosition.BOTTOM_RIGHT"
     @"}"                                   
     @"});"
     
     @"layer = new google.maps.FusionTablesLayer({"   
     @"suppressInfoWindows: true,"                                        
     @"query: {"
     @"select: 'geometry',"
     @"from:'"];
    
    if(hier == 1)
    {    
        [returnHTML appendString:FUSION_TABLE_REGION];
    }
    else if(hier == 2)
    {
        [returnHTML appendString:FUSION_TABLE_DISTRICT];
    }
    else {
        [returnHTML appendString:FUSION_TABLE_TERRITORY];
    }
    
    [returnHTML appendString:@"',"];
     
    if (parentRegion) 
    {
        [returnHTML appendFormat:@"where: \"'parent' = '%@'\"", parentRegion];
    }
         
     [returnHTML appendString:
     @"},styles: [{"
     @"polygonOptions: {"
     @"fillColor: \"#FFFFFF\","
     @"fillOpacity: 0.3"
     @"}"
     @"}"];
    
    if(![regredSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regredSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#CF145A\""
         @"}"
         @"}"];  
    }
    if(![regyellowSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regyellowSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#D88A04\""
         @"}"
         @"}"];  
    }
    if(![regblueSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:regblueSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    //#00CCFF
    if(![reggreenSet isEqualToString:@""])
    {    
        [returnHTML appendString:@", {"
         @"where: \"'id' IN ("];
        [returnHTML appendString:reggreenSet];
        [returnHTML appendString:
         @")\",polygonOptions: {"
         @"fillColor: \"#4A8D46\""
         @"}"
         @"}"];  
    }
    [returnHTML appendString:
     @"]"
     @"});"];    
    
    [returnHTML appendString:
     @"layer.setMap(map);"]; 
    
    [returnHTML appendString:
     @"google.maps.event.addListener(layer, 'click'," 
     @"function(event) {" 
     @"document.getElementById('sel_reg').value = event.row['id'].value;"
     @"window.location.href = \"myapp://mapClicked\";"                                 
     @"});"]; 
    
    [returnHTML appendString:
     @"}"
     @"</script>"
     @"</head>"
     @"<body onload=\"initialize()\">"
     @"<div id=\"map_canvas\" style=\""
     @"position: fixed;left: 0;top: 0;width: 100%;height: 100%;border:1px solid #000000;margin:0px;\"></div>"
     @"<div id=\"sel_reg\"></div>"
     @"<div id=\"zoom_lvl\"></div>"
     ];
    
    //[returnHTML appendFormat:@"%dpx; width:%dpx; margin: -2px\"></div>",height, width];
    [returnHTML appendString:@"</body></html>"];
    
  //  NSLog(@"Html : %@",returnHTML);
    return returnHTML;    
}




+(NSString *)htmlForForceDirected
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:@""];
    
    [returnHTML appendString:
     
     @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"
     @"<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">"
     @"<head>"
     @"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />"
     @"<link type=\"text/css\" href=\"base.css\" rel=\"stylesheet\" />"
     @"<link type=\"text/css\" href=\"ForceDirected.css\" rel=\"stylesheet\" />"     
     @"<script language=\"javascript\" type=\"text/javascript\" src=\"jit.js\"></script>"
     @"<script language=\"javascript\" type=\"text/javascript\" src=\"forcedirect.js\"></script>"
     @"<script language=\"javascript\" type=\"text/javascript\">"
     @"function initWithJSON() { var cjson = ["];
     
    [returnHTML appendString:[HTMLBuilder jsonForForceDirected]];
    
    [returnHTML appendString:
     @"];"
     @"init(cjson);"
     @"}"
     @"</script>"
     @"</head>"
     @"<body onload=\"initWithJSON();\">"
     @"<div id=\"container\">"
     @"<div id=\"infovis\">"
     @"</div>"
     @"</div>"     
     @"</body>"
     @"</html>"];
    
    

    return returnHTML;
}

+(NSString *)jsonForForceDirected
{
    NSMutableString *returnJSON = [[NSMutableString alloc] initWithString:@""];
    
    [returnJSON appendString:
     
     @"{\"adjacencies\": ["
     @"\"node1\","
     @"\"node3\","     
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$dim\": 17,"
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"   
     @"\"$pic\": \"node0.jpeg\","        
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10"
     @"},"
     @"\"id\": \"node0\","
     @"\"name\": \"Dr.Scott Evangelista\"},"     
     
     @"{\"adjacencies\": ["
     @"\"node2\","
     @"\"node3\"," 
     @"\"node4\","
     @"\"node12\""         
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#00CC66\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"   
     @"\"$pic\": \"node1.png\","     
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node1\","
     @"\"name\": \"Dr. Greg Szwartz\"},"     
     
     @"{\"adjacencies\": ["       
     @"\"node12\""        
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#00CC66\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"   
     @"\"$pic\": \"unknow.gif\","     
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node2\","
     @"\"name\": \"Dr. Kean Scwartz\"}," 
     
     @"{\"adjacencies\": ["   
     @"\"node4\""        
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#00CC66\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"     
     @"\"$pic\": \"node3.png\","          
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node3\","
     @"\"name\": \"Dr. Dan Goodman\"}," 
     
     @"{\"adjacencies\": ["       
     @"\"node5\","
     @"\"node9\""        
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"    
     @"\"$pic\": \"node4.jpeg\","          
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node4\","
     @"\"name\": \"Dr. Deborshi Dutt\"}," 
     
     @"{\"adjacencies\": ["      
     @"\"node6\""        
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#00CC66\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"     
     @"\"$pic\": \"node5.jpg\","       
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node5\","
     @"\"name\": \"Dr. Dixit Chopra\"}," 
     
     @"{\"adjacencies\": ["
     @"\"node7\","   
     @"\"node8\""     
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"  
     @"\"$pic\": \"node6.png\","       
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node6\","
     @"\"name\": \"Dr. Dhanasekar K\"},"   
     
     @"{\"adjacencies\": [" 
     @"\"node9\","   
     @"\"node11\","        
     @"\"node10\""       
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"    
     @"\"$pic\": \"node7.png\","       
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 12"
     @"},"
     @"\"id\": \"node7\","
     @"\"name\": \"Dr. Kaushik Hegde\"}," 
     
     @"{\"adjacencies\": ["  
     @"\"node11\""      
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#00CC66\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1," 
     @"\"$pic\": \"unknow.gif\","                     
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node8\","
     @"\"name\": \"Dr. Jessy Ryder\"},"      
     
     @"{\"adjacencies\": ["       
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#00CC66\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"  
     @"\"$pic\": \"node9.jpg\","      
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node9\","
     @"\"name\": \"Dr. Gaurav Thakur\"},"  
     
     @"{\"adjacencies\": ["       
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"   
     @"\"$pic\": \"unknow.gif\","            
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 17"
     @"},"
     @"\"id\": \"node10\","
     @"\"name\": \"Dr. Mathew Hayden\"},"      
     
     @"{\"adjacencies\": ["       
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"  
     @"\"$pic\": \"unknow.gif\","           
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node11\","
     @"\"name\": \"Dr. Ricky Ponting\"},"      
     
     @"{\"adjacencies\": ["       
     @"],"
     @"\"data\": {"
     @"\"$color\": \"#000000\","
     @"\"$type\": \"circle\","
     @"\"$hcpgrp\": \"Dr.Doe Group\","
     @"\"$NRx\": 10.6,"        
     @"\"$Market\": 4.1,"             
     @"\"$NRxTRx\": 2.1,"  
     @"\"$pic\": \"unknow.gif\","       
     @"\"$Patient\": 47.4,"             
     @"\"$decile\": 10,"     
     @"\"$dim\": 7"
     @"},"
     @"\"id\": \"node12\","
     @"\"name\": \"Dr. Darren Lehman\"}"   
     
     ];
    
    return returnJSON;
}

+(NSString *)htmlForLineChat
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:@""];
    
    [returnHTML appendString:
     
     @"<html>"
     @"<head>"
     @"<script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>"
     @"<script type=\"text/javascript\">"
     @"google.load(\"visualization\", \"1\", {packages:[\"corechart\"]});"
     @"google.setOnLoadCallback(drawChart);"
     @"function drawChart() {"
         @"var data = google.visualization.arrayToDataTable(["
                                                           @"['Month', 'Blog', 'Twitter', 'Facebook', 'Youtube'],"
                                                           @"['Jan',  60,      40, 55, 80],"
                                                           @"['Feb',  70,      60, 40, 75],"
                                                           @"['Mar',  50,       70, 90, 65],"
                                                           @"['Apr',  65,      50, 25, 70]"
                                                           @"]);"
         
         @"var options = {"
         @"title: '',"
         @"legend : {position:'top'}"
         @"};"
         
         @"var chart = new google.visualization.LineChart(document.getElementById('chart_div'));"
         @"chart.draw(data, options);"
     @"}"
     @"</script>"
     @"</head>"
     @"<body>"
     @"<div id=\"chart_div\" align=\"left\" style=\"margin: 0; width: 100%; height: 100%;\"></div>"
     @"</body>"
     @"</html>"];
    
    return returnHTML;
}

//gaurav
+(NSString *)htmlForWordCloud:(NSString *)brandName rskflag:(NSInteger)flag
{
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:@""];
    
    [returnHTML appendString:
     @"<!DOCTYPE html>"
     @"<html>"
     @"<head>"
     @"<link rel=\"stylesheet\" type=\"text/css\" href=\"jqcloud.css\"/>"
     @"<script type=\"text/javascript\" src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.js\"></script>"
     @"<script type=\"text/javascript\" src=\"jqcloud-1.0.0.min.js\"></script>"
     @"<script type=\"text/javascript\">"
     @"var word_list = [" ];
    [returnHTML appendString:[NSString stringWithFormat:@"{text: \"%@\", weight: 9},",brandName]];
    if(flag == 0)
    {
        [returnHTML appendString:
         @"{text: \"Prescribe\", weight: 2.2},"
         @"{text: \"Effective\", weight: 1.5},"
         @"{text: \"Healthy\", weight: 2.4},"
         @"{text: \"Quick\", weight: 2},"
         @"{text: \"Recommended\", weight: 1.8},"
         @"{text: \"on demand\", weight: 2.5},"
         @"{text: \"Positive\", weight: 2},"
         @"{text: \"Side effect\", weight: 6.8},"
         @"{text: \"dislike\", weight: 6.5},"
         @"{text: \"Negative\", weight: 5},"
         @"{text: \"Avoid\", weight: 6.2}"     
         @"];" ];
    }else {
        [returnHTML appendString:
         @"{text: \"Prescribe\", weight: 6.8},"
         @"{text: \"Effective\", weight: 6.5},"
         @"{text: \"Healthy\", weight: 6.2},"
         @"{text: \"Quick\", weight: 6},"
         @"{text: \"Recommended\", weight: 5.8},"
         @"{text: \"on demand\", weight: 5.5},"
         @"{text: \"Positive\", weight: 5},"
         @"{text: \"Side effect\", weight: 3},"
         @"{text: \"dislike\", weight: 2},"
         @"{text: \"Negative\", weight: 2},"
         @"{text: \"Avoid\", weight: 1}"     
         @"];" ];
    }
    [returnHTML appendString:
     @"$(function() {"
     @"$(\"#brandsocial\").jQCloud(word_list);"
     @"});"
     @"</script>"
     @"</head>"
     @"<body>"
     @"<div id=\"brandsocial\" style=\"width: 410px; height: 263px;\"></div>"
     @"</body>"
     @"</html>"
     
     ];     
    
    return returnHTML;
    
}

+(NSString *)htmlForPayerAccess:(NSArray *)topPayers
{
    
    NSMutableString *returnHTML = [[NSMutableString alloc] initWithString:@""];

    [returnHTML appendString:    
    @"<!DOCTYPE html>"     
    @"<html xmlns=\"http://www.w3.org/1999/xhtml\">"
    @"<head>"
    @"<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/>"
    @"<script type=\"text/javascript\" src=\"http://www.google.com/jsapi\"></script>"
    @"<script type=\"text/javascript\">"
    @"google.load('visualization', '1', {packages: ['corechart']});"
    @"</script>"
    @"<script type=\"text/javascript\">"
    @"function drawVisualization() {"
        // Create and populate the data table.
        @"var data = google.visualization.arrayToDataTable(["
     @"['Payer', 'Lives Covered'],"];
        for(DOPayer *payer in topPayers)
        {
            [returnHTML appendString:[NSString stringWithFormat:@"['%@' , %ld] ,", payer.payerName, [payer.livesCovered longValue]]];
        }
                                                          
    [returnHTML appendString:@"]);"        
        // Create and draw the visualization.
        @"new google.visualization.PieChart(document.getElementById('visualization'))."
        @"draw(data, {title:\"Top Payers\", titleTextStyle:{fontSize: 15},chartArea:{Left:0,top:20,width:\"100%\",height:\"80%\"},is3D:true});"
    @"}"
    
    
    @"google.setOnLoadCallback(drawVisualization);"
    @"</script>"
    @"</head>"
    @"<body style=\"font-family: Arial;border: 0 none;\">"
    @"<div id=\"visualization\" style=\"width: 440px; height: 300px;\"></div>"
    @"</body>"
     @"</html>"];
    
    //NSLog(@"%@",returnHTML);    
    return returnHTML;
}

@end
