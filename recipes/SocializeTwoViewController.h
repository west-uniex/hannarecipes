//
//  SocializeTwoViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 21.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "BRBlueButton.h"

//@class BRBlueButton;

@interface SocializeTwoViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet BRBlueButton *shareOnfacebookButton;
@property (weak, nonatomic) IBOutlet BRBlueButton *shareOnTwitterButton;
@property (weak, nonatomic) IBOutlet BRBlueButton *emailToFriendButton;
@property (weak, nonatomic) IBOutlet BRBlueButton *sendSMSToFriendButton;

- (IBAction)shareOnFacebookButtonDidTap:(id)sender;
- (IBAction)shareOnTwitterButtonDidTap:(id)sender;
- (IBAction)sendEmailToFriendButtonDidTap:(id)sender;
- (IBAction)sendSMSToFriendButtonDidTap:(id)sender;

@end
