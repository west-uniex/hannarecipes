//
//  InfoViewController.h
//  recipes
//
//  Created by Mykola Kondratyuk on 2/17/14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)cancelButtonDidTap:(id)sender;

- (IBAction)openVoferLtdInSafariButtonDidTap:(id)sender;

- (IBAction)sendEmailToHannaButtonDidTap:(id)sender;

@end
