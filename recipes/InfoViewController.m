//
//  InfoViewController.m
//  recipes
//
//  Created by Mykola Kondratyuk on 2/17/14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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


#pragma mark IB Action

- (IBAction)cancelButtonDidTap:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openVoferLtdInSafariButtonDidTap:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.Vofer.com.au"]];
}

- (IBAction)sendEmailToHannaButtonDidTap:(id)sender
{
    DLog(@"E-MAIL ");
    BOOL ok = [MFMailComposeViewController canSendMail];
    if (!ok) return;
    MFMailComposeViewController* mc = [MFMailComposeViewController new];
    mc.mailComposeDelegate = self;
    [mc setSubject:@"Hello, Hanna!"];
    [mc setToRecipients:@[@"anna_5tav@mail.ru"]];
    [mc setMessageBody:@"\n\napp SmartFood" isHTML:NO];
    [self presentViewController:mc animated:YES completion:nil];

}

#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    // could do something with result/error
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
