//
//  FavoriteSearchTableViewController.h
//  recipes
//
//  Created by Kondratyuk Hanna on 12.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleRecipeCell;

typedef enum
{
    searchScoreAll = 0,
    searchScopeFiveStar = 1,
    searchScopeFourStar = 2,
    searchScoreOther = 3
    
} RatingSearchScope;

@interface FSearchTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSArray *recipesArray;
@property (strong,nonatomic) NSMutableArray *filteredRecipesArray;


//  for work with xib cell file
@property (strong, nonatomic) IBOutlet UITableViewCell *recipeCell;
@property (strong, nonatomic) UINib *recipeCellNib;




@end

// http://useyourloaf.com/blog/2012/06/07/prototype-table-cells-and-storyboards.html

// http://stackoverflow.com/questions/19069503/uisearchdisplaycontrollers-searchresultstableviews-contentsize-is-incorrect-b