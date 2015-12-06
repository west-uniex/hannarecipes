//
//  SocializeViewController.m
//  recipes
//
//  Created by Anna Kondratyuk on 10/30/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "SocializeViewController.h"



@interface SocializeViewController ()

@end

@implementation SocializeViewController

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




#pragma mark
#pragma mark       UITableViewDelegate

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedCell.reuseIdentifier isEqualToString:@"Facebook"] )
    {
        DLog(@"FACEBOOK");// SLServiceTypeTwitter
        BOOL ok = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
        if (!ok) return;
        SLComposeViewController* vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        if (!vc) return;
        vc.completionHandler = ^(SLComposeViewControllerResult result) {
            DLog(@"%i", result);
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Twitter"])
    {
        DLog(@"TWITTER");
        BOOL ok = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
        if (!ok) return;
        SLComposeViewController* vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (!vc) return;
        vc.completionHandler = ^(SLComposeViewControllerResult result) {
            DLog(@"%i", result);
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Email"])
    {
        DLog(@"E-MAIL ");
        BOOL ok = [MFMailComposeViewController canSendMail];
        if (!ok) return;
        MFMailComposeViewController* vc = [MFMailComposeViewController new];
        vc.mailComposeDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"SMS"])
    {
        DLog(@"SMS");
        BOOL ok = [MFMessageComposeViewController canSendText];
        if (!ok) return;
        MFMessageComposeViewController* vc = [MFMessageComposeViewController new];
        vc.messageComposeDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}



- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

#pragma mark 

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    // could do something with result/error
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    DLog(@"%i", result);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark




@end
