//
//  SFAMasterFrameVC.m
//  SFA
//
//  Created by Martin Heras on 3/28/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAMasterFrameVC.h"
#import "SharedData.h"


@interface SFAMasterFrameVC ()
{
    UIImage *_snapshotImage;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *titleBarView;
@property (nonatomic, retain) IBOutlet UIButton *btnBack;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIImage *snapshotImage;
@end

@implementation SFAMasterFrameVC
@synthesize titleName;
@synthesize titleLabel = _titleLabel;
@synthesize contentView = _contentView;
@synthesize titleBarView = _titleBarView;
@synthesize btnBack = _btnBack;
@synthesize activityIndicator = _activityIndicator;
@synthesize snapshotImage=_snapshotImage;
@synthesize brandLabel=_brandLabel;
@synthesize editButton=_editButton;
@synthesize backButton=_backButton;
@synthesize infoButton=_infoButton;
@synthesize closeButton=_closeButton;
@synthesize bottomToolBarView=_bottomToolBarView;
@synthesize bottomToolBarButton=_bottomToolBarButton;
- (id)init 
{
    self = [super initWithNibName:@"SFAMasterFrameView" bundle:[NSBundle mainBundle]];
    if (self) {
        
        self.title = SCREEN_TITLE_UNNAMED;
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self.activityIndicator setFrame:CGRectMake((self.view.frame.size.width / 2) + 150 , self.view.frame.size.height / 2, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height)];
		[self.activityIndicator setHidesWhenStopped:YES];
		[self.view addSubview:self.activityIndicator];
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.infoButton.hidden=YES;
    if(self.title==SCREEN_TITLE_DASHBOARD){
        self.backButton.hidden=TRUE;
    }
    _titleLabel.text = self.title; 
    // NSLog(@"title : %@",self.title);
    self.infoButton.layer.cornerRadius=5;
    
}
-(void)viewWillAppear:(BOOL)animated{
    SharedData *sharedObject = [SharedData sharedObj];        
    int shwToolBar=sharedObject.showToolbar;
    if(shwToolBar==0){
        self.bottomToolBarView.hidden=NO;
        CGRect newFrame = self.contentView.frame;
        newFrame.size.height = 660;
        self.contentView.frame = newFrame;
        [self.bottomToolBarButton setImage:[UIImage imageNamed:@"downArrowHome.png"] forState:UIControlStateNormal];
        

    }else{
        self.bottomToolBarView.hidden=YES;
        CGRect newFrame = self.contentView.frame;
        newFrame.size.height = 696;
        self.contentView.frame = newFrame;
        [self.bottomToolBarButton setImage:[UIImage imageNamed:@"upArrowHome.png"] forState:UIControlStateNormal];
        

    }
}
- (void)viewDidUnload
{
    [self setContentView:nil];
    [super viewDidUnload];
}

- (IBAction)onBackTouch:(id)sender 
{
    [self navGoBack];
}

- (IBAction)onLogoutTouch:(id)sender
{
    [self navGoToLogin];
}

- (void)didDisplayActivityIndicator
{
    [self.activityIndicator setHidden:NO];
	[self.activityIndicator startAnimating];
    [self performSelector:@selector(didStopActivityIndicator) withObject:nil afterDelay:1.0];
}


- (void)didStopActivityIndicator
{
	[self.activityIndicator stopAnimating];
}

- (IBAction)onHomeTouch:(id)sender 
{
    [self didStopActivityIndicator];
    [self navGoHome];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendEmail:(id)sender
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    [controller.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"My Subject"];
    //NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
    [controller setMessageBody:@"Hello there." isHTML:NO]; 
    
    if(self.snapshotImage)
    {
        //  NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
        NSData *attach = UIImagePNGRepresentation(self.snapshotImage);
        [controller addAttachmentData:attach mimeType:@"image/png" fileName:@"snapshot"];
    }
    
    if (controller) 
    {
        [self presentModalViewController:controller animated:YES];
    }
    //[controller release];
}

- (IBAction)onSnapShot:(id)sender
{
    UIGraphicsBeginImageContextWithOptions(self.contentView.bounds.size, self.contentView.opaque, 0.0); 
	[self.contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
	self.snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	UIImageWriteToSavedPhotosAlbum(self.snapshotImage, nil, nil, nil);
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    [controller.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"My Subject"];
    //NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
    [controller setMessageBody:@"Hello there." isHTML:NO]; 
    
    if(self.snapshotImage)
    {
        NSData *attach = UIImagePNGRepresentation(self.snapshotImage);
        [controller addAttachmentData:attach mimeType:@"image/png" fileName:@"snapshot"];
    }
    
    if (controller) 
    {
        [self presentModalViewController:controller animated:YES];
    }    
}
- (IBAction)infoButtonDetails:(id)sender{
    if(i==1){
        [self close:nil]; 
        
    }
    else{
        /*[UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:2.0];
         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
         */
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.30;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        transition.delegate = self;
        [self.infoButton.layer addAnimation:transition forKey:nil];
        self.infoButton.hidden=NO;
        i=1;
        
  //      [self.view addSubview:self.infoButton];
        [self.view bringSubviewToFront:self.infoButton];
        
        
    }
}
- (IBAction)close:(id)sender{
    i=0;
    CATransition *transition = [CATransition animation];
    transition.duration = 0.30;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.infoButton.layer addAnimation:transition forKey:nil];
    self.infoButton.hidden=YES;
   // [self.infoButton removeFromSuperview];
    
    
}

- (IBAction)showToolbar:(id)sender{
    
    if(self.bottomToolBarView.hidden){
        [self.bottomToolBarButton setImage:[UIImage imageNamed:@"downArrowHome.png"] forState:UIControlStateNormal];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.30;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        transition.delegate = self;
        [self.bottomToolBarView.layer addAnimation:transition forKey:nil];
        
        self.bottomToolBarView.hidden=NO;
       
        
        CGRect newFrame = self.contentView.frame;
        newFrame.size.height = newFrame.size.height-self.bottomToolBarView.frame.size.height;
        self.contentView.frame = newFrame;
        SharedData *sharedObject = [SharedData sharedObj];
        sharedObject.showToolbar =0;
    }
    else {
        [self.bottomToolBarButton setImage:[UIImage imageNamed:@"upArrowHome.png"] forState:UIControlStateNormal];
      
        CATransition *transition = [CATransition animation];
        transition.duration = 0.30;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        transition.delegate = self;
        self.bottomToolBarView.hidden=YES;
        [self.bottomToolBarView.layer addAnimation:transition forKey:nil];

        CGRect newFrame = self.contentView.frame;
        newFrame.size.height = newFrame.size.height+self.bottomToolBarView.frame.size.height;
        self.contentView.frame = newFrame;
        
        SharedData *sharedObject = [SharedData sharedObj];
        sharedObject.showToolbar =1;
    }
}

@end
