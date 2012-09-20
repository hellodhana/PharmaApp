//
//  SFAMasterFrameVC.h
//  SFA
//
//  Created by Martin Heras on 3/28/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAAbstractVC.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface SFAMasterFrameVC : SFAAbstractVC<MFMailComposeViewControllerDelegate> {
    
    UILabel *_titleLabel;
    IBOutlet UIButton *_editButton;
    IBOutlet UILabel *_brandLabel;
    IBOutlet UIView *_contentView;
    IBOutlet UIView *_titleBarView;
    IBOutlet UIButton *_btnBack;
    UIActivityIndicatorView *_activityIndicator;
    NSString *titleName;
    IBOutlet UIView *_backButton;
    IBOutlet UIView *_infoButton;
    IBOutlet UIButton *_closeButton;
    IBOutlet UIButton *_bottomToolBarButton;
    IBOutlet UIView *_bottomToolBarView;
    int i;
    
   
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) UILabel *brandLabel;
@property (nonatomic, retain) UIButton *editButton;
@property (nonatomic, retain)  UIView *backButton;
@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) UIView *infoButton;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) UIView *bottomToolBarView;
@property (nonatomic, retain) UIButton *bottomToolBarButton;

- (IBAction)onBackTouch:(id)sender;
- (IBAction)onHomeTouch:(id)sender;
- (IBAction)onControlEvalTouch:(id)sender;
- (IBAction)onAccessRiskTouch:(id)sender;
- (IBAction)onEnterRiskTouch:(id)sender;
- (IBAction)onSnapShot:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)showToolbar:(id)sender;
@end
