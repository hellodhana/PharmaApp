//
//  SFAReportsMainVC.m
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAReportsMainVC.h"
#import "HTMLBuilder.h"
#import "AdoptionNWView.h"
#import "SocialPerformanceView.h"
#import "AdoptionDurabView.h"
#import "PayerAccessView.h"
#import "ExecutionIndexView.h"
#import "SharedData.h"

@implementation SFAReportsMainVC

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
-(id)init {
    self = [super initWithNibName:@"SFAReportsMainView" bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization.
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[SFAUtils addMultiGradientToView:self.view beginColor:[UIColor lightGrayColor] middleColor:REPORTS_BACKGROUND_COLOR_TO finalColor:[UIColor lightGrayColor]];
	
	[[_borderView layer] setBorderColor:[REPORTS_BORDER_COLOR CGColor]];
	[[_borderView layer] setCornerRadius:10.0];	
	[[_borderView layer] setBorderWidth:10.0];
	
	//Separator between sidebar and main view
	UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 2.0, CGRectGetHeight(self.view.frame))];
	[SFAUtils addMultiGradientToView:separatorView beginColor:[UIColor grayColor] middleColor:REPORTS_BORDER_COLOR finalColor:[UIColor grayColor]];
	[self.view addSubview:separatorView];
    _regionView.layer.cornerRadius=5;
    _brandView.layer.cornerRadius=5;
    _YTDView.layer.cornerRadius=5;
    
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setTitleReport:(NSString *)titleReport {
    _segMaporGraph.hidden=YES;
	[_titleLabel setText:titleReport];
	
	//Reposition of reloadButton
	CGSize titleSize = [[_titleLabel text] sizeWithFont:_titleLabel.font];
	CGRect newFrame = CGRectMake(CGRectGetMinX(_titleLabel.frame) + titleSize.width, CGRectGetMinY(_reloadButton.frame), CGRectGetWidth(_reloadButton.frame), CGRectGetHeight(_reloadButton.frame));
	[_reloadButton setFrame:newFrame];
    if([titleReport isEqualToString:@"Execution Index"])
    {
        if(!executionView){
            executionView = [[ExecutionIndexView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
            
        }
        [_contentView addSubview:executionView];
        [executionView loadData];          
    }
    else if([titleReport isEqualToString:@"Market Access"])
    {
        if(!payerView){
            payerView = [[PayerAccessView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:payerView];
        [payerView loadData];        
        
    }
    else if([titleReport isEqualToString:@"Adoption Network"])
    {   
        if(!adoptionView){
            adoptionView = [[AdoptionNWView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:adoptionView];
        
        [adoptionView loadGraph];
        _segMaporGraph.hidden=NO;
        _segMaporGraph.selectedSegmentIndex=0;
        
        
    }
    else if ([titleReport isEqualToString:@"Social Performance"]) 
    {
        if(!socialView){
            socialView = [[SocialPerformanceView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:socialView];
        [socialView loaddata];
    }
    else if ([titleReport isEqualToString:@"Adoption vs Durability"]) 
    {
        if(!adoptionDuraView){
            adoptionDuraView = [[AdoptionDurabView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:adoptionDuraView];
        [adoptionDuraView loadGraph];

    }
    
    else if ([titleReport isEqualToString:@"Durability Index"]) 
    {
        if(!durabilityIndexView){
            durabilityIndexView = [[DurabilityIndexView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:durabilityIndexView];
        [durabilityIndexView loaddata];
        

        
    }
   
    else if ([titleReport isEqualToString:@"Self Org. Map"]) 
    {
        if(!selfOrgMapView){
            selfOrgMapView = [[SelfOrgMapView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:selfOrgMapView];
        [selfOrgMapView loadGraph];
        
    }
    
    else if ([titleReport isEqualToString:@"Intensity"]) 
    {
        if(!intensityView){
            intensityView = [[IntensityView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        }
        [_contentView addSubview:intensityView];
    
        
    }
    
    NSString *brandName = [[SharedData sharedObj] doBrand].brandDesc;
    NSString *regionName=[[SharedData sharedObj] RegionData];
    NSString *getYTD=[[SharedData sharedObj] period];
    
    [_titleLabel setText:[NSString stringWithFormat:@"%@",titleReport]];
    _regionlbl.text=regionName;
    _brandlbl.text=brandName;
    _YTDlbl.text=getYTD;
    
    
}

- (void)setImageReport:(UIImage *)imageReport {
	//[_graphicImageView setImage:imageReport];
    
}

- (IBAction)onReloadTouch:(id)sender {
}

- (IBAction)SegValueChanged:(id)sender {
    // AdoptionNWView *adoptionView = [[AdoptionNWView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    // [_contentView addSubview:adoptionView];
    
    
    switch (_segMaporGraph.selectedSegmentIndex) {
        case 0:
            [adoptionView loadGraph];
            _segMaporGraph.selectedSegmentIndex=0;
            break;
        case 1:
            [adoptionView mapClicked:nil];
            _segMaporGraph.selectedSegmentIndex=1;
            
            break;
            
            
        default:
            break;
    }
    
}

- (void)dealloc {
    
}


@end
