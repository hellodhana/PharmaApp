//
//  SFALoginVC.h
//  SFA
//
//  Created by Martin Heras on 3/29/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAAbstractVC.h"
#import "ValueSelectTableVC.h"

@interface SFALoginVC : SFAAbstractVC<ValueSelectorProtocol> {
    
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    UIButton *_signInButton;
    UIButton *_demoButton;
    UIView *_loginPanel;
    UIActivityIndicatorView *_activityIndicator;
    ValueSelectTableVC *_tableSelectorView;
    IBOutlet UIPopoverController *_ytdBrandPopoverController;
    IBOutlet UILabel *_ytdBrandLabel;
    IBOutlet UIView *_brandYTDview;
    
}

@property (nonatomic, retain) IBOutlet UIView *loginPanel;

@property (nonatomic, retain) IBOutlet UIButton *signInButton;
@property (nonatomic, retain) IBOutlet UIButton *demoButton;
@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) UIPopoverController *ytdBrandPopoverController;
@property(nonatomic, retain) ValueSelectTableVC *tableSelectorView;
@property(nonatomic, retain) UILabel *ytdBrandLabel;
@property(nonatomic, retain) UIView *brandYTDview;

- (IBAction)onForgotPasswordTouch:(id)sender;
- (IBAction)onSignInTouch:(id)sender;
- (IBAction)onDemoTouch:(id)sender;
-(IBAction)showBrandYTDoption:(id)sender;

@end
