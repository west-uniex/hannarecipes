//
//  SearchInWebRecipeViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 13.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTP_Client.h"

@interface SearchInWebRecipeViewController : UIViewController <UITextFieldDelegate, HTTP_ClientDelegate>

@property (weak, nonatomic) IBOutlet UITextField *enterNameRecipeTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityYummlyServiceIndicator;

@property (strong,nonatomic,readonly) NSArray *recipesArray;

@property (weak, nonatomic) IBOutlet UIButton *showResultOfRequestToYummlyButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIImageView *yummlyImageView;

- (IBAction)showResultOfRequestToYummlyButtonDidTap:(id)sender;
- (IBAction)reloadButtonDidTap:(id)sender;

@end
