//
//  SFALoginVC.m
//  SFA
//
//  Created by Martin Heras on 3/29/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFALoginVC.h"
#import "PharmaDAO.h"
#import "DashBoardVC.h"
#import "DAOPharma.h"
#import "DOBrand.h"
#import "SharedData.h"

#define LOGIN_PANEL_ANIMATION_DURATION      0.3
#define LOGIN_PANEL_TRANSLATION_OFFSET      135.0

@implementation SFALoginVC

@synthesize loginPanel = _loginPanel;
@synthesize signInButton = _signInButton;
@synthesize demoButton = _demoButton;
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize activityIndicator = _activityIndicator;
@synthesize tableSelectorView=_tableSelectorView;
@synthesize ytdBrandPopoverController=_ytdBrandPopoverController;
@synthesize ytdBrandLabel=_ytdBrandLabel;
@synthesize brandYTDview=_brandYTDview;

- (id)init
{
    self = [super initWithNibName:@"SFALoginView" bundle:[NSBundle mainBundle]];
    if (self) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[self.activityIndicator setFrame:CGRectMake(409.0, 463.0, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height)];
		[self.activityIndicator setHidesWhenStopped:YES];
		
		[self.view addSubview:self.activityIndicator];
    }
    return self;
}

- (void)keyboardWillAppear:(NSNotification *)notification
{
    [UIView beginAnimations:@"loginPanelMoveUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:LOGIN_PANEL_ANIMATION_DURATION];
    _loginPanel.transform = CGAffineTransformMakeTranslation(0.0, -1.0 * LOGIN_PANEL_TRANSLATION_OFFSET);
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:@"loginPanelMoveDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:LOGIN_PANEL_ANIMATION_DURATION];
    _loginPanel.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_signInButton setBackgroundImage:[[UIImage imageNamed:@"blue_button.png"] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [_demoButton setBackgroundImage:[[UIImage imageNamed:@"text_button_green.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0] forState:UIControlStateNormal];
   
    //gaurav  set default selected value for dropdown
    DOValueSelect *selectedDO = [[[DAOPharma sharedDAO] getAllBrands] objectAtIndex:0];

    self.ytdBrandLabel.text =[selectedDO getValueSelectDescription];
    
    SharedData *sharedObject = [SharedData sharedObj];
    sharedObject.doBrand = (DOBrand *)selectedDO;
}

- (void)viewDidUnload
{
    self.usernameTextField = nil;
    self.passwordTextField = nil;
    self.signInButton = nil;
    self.demoButton = nil;
    self.loginPanel = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    // Notification when keyboard appears.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    // Notification when keyboard hides.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	
    if ([self.activityIndicator isAnimating]) {
		[self.activityIndicator stopAnimating];
	}
}

- (void)activityIndicatorStart {
	[self.activityIndicator setHidden:NO];
	[self.activityIndicator startAnimating];
}

- (void)activityIndicatorStop {
	[self.activityIndicator stopAnimating];
}


- (IBAction)onForgotPasswordTouch:(id)sender 
{
    // TODO Implement this!
}

- (IBAction)onSignInTouch:(id)sender 
{
    // TODO Implement this!
}

- (IBAction)onDemoTouch:(id)sender 
{
    [self performSelectorInBackground:@selector(activityIndicatorStart) withObject:nil];
    [PharmaDAO sharedDAO];
 
    DashBoardVC *dashboardVC = [[DashBoardVC alloc] init];

    [self navOpenVC:dashboardVC];  
    self.activityIndicator.hidden = YES; 
    

}

-(IBAction)showBrandYTDoption:(id)sender
{
    UIView *senderView = (UIButton *)sender;
    
    NSMutableArray *keys = [[DAOPharma sharedDAO] getAllBrands];
    
    if (!self.tableSelectorView) {
        self.tableSelectorView = [[ValueSelectTableVC alloc] initWithValues:keys andSender:self.ytdBrandLabel];
    } else {
        [self.tableSelectorView reloadTableValues:keys andSender:self.ytdBrandLabel];
    }
    self.tableSelectorView.delegate = self;
    if (!self.ytdBrandPopoverController) {
        self.ytdBrandPopoverController = [[UIPopoverController alloc] 
                                          initWithContentViewController:self.tableSelectorView];               
    }
    [self.ytdBrandPopoverController presentPopoverFromRect:senderView.frame inView:senderView.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];    
}

- (void)valueSelected:(DOValueSelect *)valueDO forSender:(NSObject *)sender
{
    SharedData *sharedObject = [SharedData sharedObj];
    sharedObject.doBrand = (DOBrand *)valueDO;
    
    UILabel *senderLbl = (UILabel *)sender;
    senderLbl.text = [valueDO getValueSelectDescription];
    [self.ytdBrandPopoverController dismissPopoverAnimated:YES];
}

@end
