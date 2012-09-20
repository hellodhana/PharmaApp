//
//  DurabilityIndexView.m
//  PharmaApp
//
//  Created by Gaurav Thakur on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DurabilityIndexView.h"

#import "DAOPharma.h"
#import "DOBrand.h"
#import "SharedData.h"
#import "DurabilityTable.h"



@interface DurabilityIndexView (){
    
    NSArray *durabilityIndexArray;
    NSArray *overallPerfArray;
    NSMutableArray *brandPerfArray; 
    
    DurabilityTable *durabilityTable;  
}

@end

@implementation DurabilityIndexView

@synthesize avgNRxCall=_avgNRxCall;
@synthesize avgNRxOffCall=_avgNRxOffCall;
@synthesize TRXNRXRatio=_TRXNRXRatio;
@synthesize newstartPatients=_newstartPatients;
@synthesize rltvCopay=_rltvCopay;
@synthesize switchPatients=_switchPatients;
@synthesize restartPatients=_restartPatients;
@synthesize physicianstable=_physicianstable;
@synthesize currentlbl1=_currentlbl1;
@synthesize currentlbl2=_currentlbl2;
@synthesize currentlbl3=_currentlbl3;
@synthesize currentlbl4=_currentlbl4;
@synthesize currentlbl5=_currentlbl5;
@synthesize currentlbl6=_currentlbl6;
@synthesize currentlbl7=_currentlbl7;
@synthesize targetlbl1=_targetlbl1;
@synthesize targetlbl2=_targetlbl2;
@synthesize targetlbl3=_targetlbl3;
@synthesize targetlbl4=_targetlbl4;
@synthesize targetlbl5=_targetlbl5;
@synthesize targetlbl6=_targetlbl6;
@synthesize targetlbl7=_targetlbl7;
@synthesize currentlbl8=_currentlbl8;
@synthesize targetlbl8=_targetlbl8;
@synthesize durabilityACT=_durabilityACT;
@synthesize durabilityView=_durabilityView;
@synthesize durabilityMainView=_durabilityMainView;
@synthesize arrow1=_arrow1;
@synthesize arrow2=_arrow2;
@synthesize arrow3=_arrow3;
@synthesize arrow4=_arrow4;
@synthesize arrow5=_arrow5;
@synthesize arrow6=_arrow6;
@synthesize arrow7=_arrow7;
@synthesize arrow8=_arrow8;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"DurabilityIndexView" owner:nil options:nil];
    if (objs && [objs count]) {
        DurabilityIndexView *myView = [objs objectAtIndex:0];      
        return myView;
    }
    
    return nil;
}

-(void) drawRect:(CGRect)rect
{
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
//gaurav
-(void)loaddata
{
    self.durabilityMainView.layer.cornerRadius = 5;    
    self.durabilityMainView.layer.borderWidth = 2;    
    self.durabilityMainView.layer.borderColor = [[UIColor darkGrayColor] CGColor]; 
    
    DOBrand *brandDO=[[SharedData sharedObj] doBrand];
    DORegion *regionDO=[[SharedData sharedObj] doRegion];
    
    //overallPerfArray = [[DAOPharma sharedDAO] getBrandPerformancesForPeriod:[NSNumber numberWithInt:1]];
    
    // NSNumber *brandID=[NSNumber numberWithInt:2];
    durabilityIndexArray=[[DAOPharma sharedDAO] getDurabilityIndexForBrand:brandDO.brandID forPeriod:[NSNumber numberWithInt:1] andRegion:regionDO.regionID];
    
    // brandPerfArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = 0) AND (self.doBrand != nil)"]]];    
    
    
    // [(UIView *)[[self.durabilityIndexVw subviews] objectAtIndex:0] removeFromSuperview];
    
   // NSLog(@"%d",durabilityIndexArray.count);
    DODurability *bo = [durabilityIndexArray objectAtIndex:0];
    //NSLog(@"%d",[bo.nrx_mkt_shr_pln intValue]);
    
    self.currentlbl1.text=[NSString stringWithFormat:@"%d",[bo.nrx_mkt_shr_act intValue]];
    self.currentlbl2.text=[NSString stringWithFormat:@"%d",[bo.nrx_mkt_grth intValue]];
    self.currentlbl3.text=[NSString stringWithFormat:@"%d%%",[bo.trx_nrx_ratio intValue]];
    self.currentlbl4.text=[NSString stringWithFormat:@"%d%%",[bo.num_new_pat_strt intValue]];
    self.currentlbl5.text=[NSString stringWithFormat:@"%d",[bo.rlt_copay_act intValue]];
    self.currentlbl6.text=[NSString stringWithFormat:@"%d%%",[bo.num_swh_pat_strt intValue]];
    self.currentlbl7.text=[NSString stringWithFormat:@"%d",[bo.trx_mkt_grth intValue]];
    self.currentlbl8.text=[NSString stringWithFormat:@"%d",[bo.trx_mkt_shr_act intValue]];
    
    float target=(([bo.nrx_mkt_shr_act floatValue]/[bo.nrx_mkt_shr_pln floatValue] )* 100);
    self.targetlbl1.text=[NSString stringWithFormat:@"%d%%",(int)target];
    if(target<85){
        self.arrow1.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow1.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow1.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.nrx_mkt_grth floatValue]/[bo.nrx_mkt_grth_pln floatValue])* 100);
    self.targetlbl2.text=[NSString stringWithFormat:@"%d%%",(int) target];
    
    if(target<85){
        self.arrow2.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow2.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow2.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.trx_nrx_ratio floatValue]/[bo.trx_nrx_ratio floatValue])* 100);
    self.targetlbl3.text=[NSString stringWithFormat:@"%d%%",(int) target];
    
    if(target<85){
        self.arrow3.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow3.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow3.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.num_new_pat_strt floatValue]/[bo.num_new_pat_strt_pln floatValue])* 100);
    self.targetlbl4.text=[NSString stringWithFormat:@"%d%%",(int) target];
    
    if(target<85){
        self.arrow4.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow4.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow4.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.rlt_copay_act floatValue]/[bo.rlt_copay_pln floatValue])* 100);
    self.targetlbl5.text=[NSString stringWithFormat:@"%d%%",(int)target];
    
    if(target<85){
        self.arrow5.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow5.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow5.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.num_swh_pat_strt floatValue]/[bo.num_swh_pat_strt_pln floatValue])* 100);
    self.targetlbl6.text=[NSString stringWithFormat:@"%d%%",(int)target];
    
    if(target<85){
        self.arrow6.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow6.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow6.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.trx_mkt_grth floatValue]/[bo.trx_mkt_grth_pln floatValue])* 100);
    self.targetlbl7.text=[NSString stringWithFormat:@"%d%%",(int) target];
    
    if(target<85){
        self.arrow7.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow7.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow7.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    target=(([bo.trx_mkt_shr_act floatValue]/[bo.trx_mkt_shr_pln floatValue])* 100);
    self.targetlbl8.text=[NSString stringWithFormat:@"%d%%",(int) target];
    
    if(target<85){
        self.arrow8.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if(target>=85 && target <=95){
        self.arrow8.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else{
        self.arrow8.image=[UIImage imageNamed:@"green-circle.png"];
    }
    
    float durabilit_ACT=[bo.durbl_idx_act floatValue];
    float durabilit_PLN=[bo.durbl_idx_pln floatValue];
    float durability_divide=(durabilit_ACT/durabilit_PLN);
    self.durabilityACT.text=[NSString stringWithFormat:@"%d%%",(int)durabilit_ACT];
    rounded=[[MBRoundProgressView alloc]init];
    rounded.progresslabel.text=0;
   // NSLog(@"%f",durability_divide);
    [rounded setProgress:durability_divide];
    [self.durabilityView addSubview:rounded]; 
    
    
    
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
