//
//  SecondDetailRecipeViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@interface SecondDetailRecipeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) UIImage *iconRecipeImage;

@property (weak, nonatomic) IBOutlet UITableView *myRecipeTableView;


@property (strong, nonatomic) NSData *imageData;

@end
