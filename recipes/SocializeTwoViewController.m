//
//  SocializeTwoViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 21.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "SocializeTwoViewController.h"
#import "BRStyleSheet.h"

@interface SocializeTwoViewController ()

@end

@implementation SocializeTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action


- (IBAction)shareOnFacebookButtonDidTap:(id)sender
{
    DLog(@"FACEBOOK");// SLServiceTypeTwitter
    BOOL ok = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
    if (!ok) return;
    SLComposeViewController* vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if (!vc) return;
    vc.completionHandler = ^(SLComposeViewControllerResult result)
    {
        DLog(@"%i", result);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)shareOnTwitterButtonDidTap:(id)sender
{
    DLog(@"TWITTER");
    BOOL ok = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
    if (!ok) return;
    SLComposeViewController* vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if (!vc) return;
    vc.completionHandler = ^(SLComposeViewControllerResult result)
    {
        DLog(@"%i", result);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:vc animated:YES completion:nil];

}

- (IBAction)sendEmailToFriendButtonDidTap:(id)sender
{
    DLog(@"E-MAIL ");
    BOOL ok = [MFMailComposeViewController canSendMail];
    if (!ok) return;
    MFMailComposeViewController* vc = [MFMailComposeViewController new];
    vc.mailComposeDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)sendSMSToFriendButtonDidTap:(id)sender
{
    DLog(@"SMS");
    BOOL ok = [MFMessageComposeViewController canSendText];
    if (!ok) return;
    MFMessageComposeViewController* vc = [MFMessageComposeViewController new];
    vc.messageComposeDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];

}

#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    // could do something with result/error
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark MFMessageComposeViewControllerDelegate

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    DLog(@"%i", result);
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
