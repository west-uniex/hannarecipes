//
//  AllIngredientsTableViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 03.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllIngredientsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *allIngredients;


- (IBAction)cancelButtonDidTap:(id)sender;

@end
