//
//  MyRecipesTableViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecipesTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSArray *recipesArray;
@property (strong,nonatomic) NSMutableArray *filteredRecipesArray;



- (IBAction)createNewRecipeButtonDidTap:(id)sender;


@end
