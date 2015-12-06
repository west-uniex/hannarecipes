//
//  SearchTableViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 12.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTP_Client.h"

@interface SearchTableViewController : UITableViewController <HTTP_ClientDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSArray *recipesArray;
@property (strong,nonatomic) NSMutableArray *filteredRecipesArray;



@end
