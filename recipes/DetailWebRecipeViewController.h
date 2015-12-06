//
//  DetailWebRecipeViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 15.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@interface DetailWebRecipeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) UIImage *iconRecipeImage;

@property (weak, nonatomic) IBOutlet UITableView *myRecipeTableView;

- (IBAction)saveButtonDidTap:(id)sender;

- (IBAction)lookForRecipeInSafary:(id)sender;

@end
