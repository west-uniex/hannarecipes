//
//  SearchTableViewController.m
//  recipes
//
//  Created by Kondratyuk Hanna on 12.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "FavoriteSearchTableViewController.h"
#import "SimpleRecipeCell.h"
#import "Recipe.h"
#import "UIImageView+RemoteFile.h"
#import "DetailRecipeTableViewController.h"

#import "RecipeStore.h"
#import "ImageStore.h"

@interface FSearchTableViewController ()
{
    UIToolbar *tb;
}

@end

@implementation FSearchTableViewController

static NSString *NibRecipeCellIdentifier = @"NibRecipeCellIdentifier";
static NSString *RecipeCellIdentifier = @"RecipeCellIdentifier";
//static NSString *SegueShowRecipe = @"SegueShowRecipe";

#define RECIPE_CELL_TAG_NAME   200
#define RECIPE_CELL_TAG_IMAGE  100
#define RECIPE_CELL_TAG_RATING 300


#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Don't show the scope bar or cancel button until editing begins
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];    
    
    [self.searchDisplayController.searchResultsTableView registerNib: [UINib nibWithNibName:@"SimpleRecipeCell" bundle:nil] forCellReuseIdentifier: @"NibRecipeCellIdentifier"];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor lightGrayColor];
    
    //  prepare for add toolbar to keyboard view
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adjustForKeyboard:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    self.searchBar.inputAccessoryView = [self accessoryView];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.recipesArray = [[RecipeStore defaultStore] allRecipes];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (UINib *) recipeCellNib
{
    if (!_recipeCellNib)
    {
        _recipeCellNib = [UINib nibWithNibName:@"SimpleRecipeCell" bundle:nil];
    }
    return _recipeCellNib;
}


#pragma mark
#pragma mark  internal methods for show advanced keyboard

- (UIToolbar *) accessoryView
{
	tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f)];
	tb.tintColor = [UIColor darkGrayColor];
	
	NSMutableArray *items = [NSMutableArray array];
	[items addObject:BARBUTTON(@"Clear", @selector(clearText))];
	[items addObject:SYSBARBUTTON(UIBarButtonSystemItemFlexibleSpace, nil)];
	[items addObject:BARBUTTON(@"Done", @selector(leaveKeyboardMode))];
	tb.items = items;
	
	return tb;
}

- (void) clearText
{
	[self.searchBar setText:@""];
}

- (void) leaveKeyboardMode
{
	[self.searchBar resignFirstResponder];
}

- (void) keyboardWillHide: (NSNotification *) notification
{
	// return to previous text view size
	//tv.frame = self.view.bounds;
    DLog(@" ");
}

- (void) adjustForKeyboard: (NSNotification *) notification
{
    
	// Retrieve the keyboard bounds via the notification userInfo dictionary
	CGRect kbounds;
	NSDictionary *userInfo = [notification userInfo];
	[(NSValue *)[userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] getValue:&kbounds];
    
	// Shrink the textview frame -- comment this out to see the default behavior
    //CGRect destRect = CGRectShrinkHeight(self.view.bounds, kbounds.size.height);
	//tv.frame = destRect;
    DLog(@" %@", [userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"]);
}



#pragma mark -
#pragma mark === UITableViewDataSource Delegate Methods ===
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{

    // Check to see whether the normal table or search results
    // table is being displayed and return the count from the appropriate array
    if (tableView == self.tableView)
	{
        return [_recipesArray count];
    }
	else
	{
        return [_filteredRecipesArray count];    
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:RecipeCellIdentifier];
    
    if (cell == nil)
    {
        // The following call should return cells for reuse but when UISearchDisplayDelegate is active
        // it always returns nil
        
        cell = [self.tableView dequeueReusableCellWithIdentifier: NibRecipeCellIdentifier];
        
        if (cell == nil)
        {
            [self.recipeCellNib instantiateWithOwner:self options:nil];
            cell = self.recipeCell;
            self.recipeCell = nil;
        }
    }
    
    Recipe *recipe = nil;
    if (tableView == self.tableView)
    {
        recipe = [_recipesArray objectAtIndex:[indexPath row]];
    }
    else
    {
        if (([_filteredRecipesArray count] > 0 ) && ( [_filteredRecipesArray count] - 1  >= indexPath.row) )
        {
            recipe = [_filteredRecipesArray objectAtIndex:[indexPath row]];
        }
        else
        {
            return cell;
        }
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag: RECIPE_CELL_TAG_NAME];
    nameLabel.text = recipe.recipeName;
    
    UIImageView *recipeIconImageView = (UIImageView *)[cell viewWithTag: RECIPE_CELL_TAG_IMAGE];
    UIImage *iconImage = [[ImageStore defaultImageStore] imageForKey:recipe.imageKey];;
    recipeIconImageView.image = iconImage;
    return cell;
}




#pragma mark
#pragma mark       UITableViewDelegate

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableView *_searchResultsTableView = self.searchDisplayController.searchResultsTableView;
    
    if (_searchResultsTableView == tableView) // why  _searchResultsTableView == nil ?
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        DetailRecipeTableViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteDetailRecipeVC"];
        //  true image send
        SimpleRecipeCell *selectedCell = (SimpleRecipeCell *)[self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
        detailController.iconRecipeImage = selectedCell.imageViewRecipe.image;
        //   true recipe send
        NSString *recipeName = selectedCell.nameRecipe.text;
        Recipe *trueResipe = nil;
        for (Recipe *recipe in self.recipesArray)
        {
            if ([recipe.recipeName isEqualToString:recipeName])
            {
                trueResipe = recipe;
                break;
            }
        }
        detailController.recipe = trueResipe;
        
        //  make push in sequance 
        [self.navigationController pushViewController:detailController animated:YES];
        return;
        //[self performSegueWithIdentifier: @"DetailRecipeSegue" sender: self];
    }
    
    if (tableView == self.tableView)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        DetailRecipeTableViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteDetailRecipeVC"];
        //  true image send
        SimpleRecipeCell *selectedCell = (SimpleRecipeCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        detailController.iconRecipeImage = selectedCell.imageViewRecipe.image;
        detailController.recipe = [self.recipesArray objectAtIndex:indexPath.row];
        
        //  make push in sequance
        [self.navigationController pushViewController:detailController animated:YES];
        return;
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        DetailRecipeTableViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteDetailRecipeVC"];
        //  true image send
        SimpleRecipeCell *selectedCell = (SimpleRecipeCell *)[tableView cellForRowAtIndexPath:indexPath];
        detailController.iconRecipeImage = selectedCell.imageViewRecipe.image;
        //   true recipe send
        NSString *recipeName = selectedCell.nameRecipe.text;
        Recipe *trueResipe = nil;
        for (Recipe *recipe in self.recipesArray)
        {
            if ([recipe.recipeName isEqualToString:recipeName])
            {
                trueResipe = recipe;
                break;
            }
        }
        detailController.recipe = trueResipe;
        
        //  make push in sequance
        [self.navigationController pushViewController:detailController animated:YES];
        return;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

#pragma mark - Navigation
#pragma mark - Navigation   segues

// DetailRecipeSegue



/*
 - (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier
 sender:(id)sender
 {
 // Check if there is some text and if there isn't, display a message
 // to the user and prevent her from going to the next screen
 
 if ([identifier isEqualToString:@"GoToSearchRecipe"])
 {
 if ([self.enterNameRecipeTextField.text length] == 0)
 {
 [self displayTextIsRequired];
 return NO;
 }
 };
 return YES;
 }
 */


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FavoriteDetailRecipeSegue"])
    {
        NSIndexPath *chosenCellIndexPath = [self.tableView indexPathForSelectedRow];
        if (chosenCellIndexPath)
        {
            // segue performing from table view
            Recipe *currentRecipe = [self.recipesArray objectAtIndex:chosenCellIndexPath.row];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:chosenCellIndexPath];
            SimpleRecipeCell *src = (SimpleRecipeCell *)cell;
            UIImage *iconImage =src.imageViewRecipe.image;
            DetailRecipeTableViewController  *detailRecipeController = segue.destinationViewController;
            detailRecipeController.recipe = currentRecipe;
            detailRecipeController.iconRecipeImage = iconImage;
            return;
        }
        
        NSIndexPath *chosenCellSeachResultTableViewIndexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        if (chosenCellSeachResultTableViewIndexPath)
        {
            // segue performing from seach result table view
            Recipe *currentRecipe = [self.recipesArray objectAtIndex:chosenCellSeachResultTableViewIndexPath.row];
            UITableViewCell *cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:chosenCellSeachResultTableViewIndexPath];
            SimpleRecipeCell *src = (SimpleRecipeCell *)cell;
            UIImage *iconImage =src.imageViewRecipe.image;
            DetailRecipeTableViewController  *detailRecipeController = segue.destinationViewController;
            detailRecipeController.recipe = currentRecipe;
            detailRecipeController.iconRecipeImage = iconImage;

        }
        
    }
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredRecipesArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.recipeName contains[c] %@",searchText];
    NSArray *tempArray = [_recipesArray filteredArrayUsingPredicate:predicate];
    
    if(![scope isEqualToString:@"All"])
    {
        //  make from scope number
        NSNumber *flag = nil;
        NSPredicate *scopePredicate = nil;
        if ([scope isEqualToString:@"Five Star"])
        {
            flag = @5;
            scopePredicate= [NSPredicate predicateWithFormat:@"SELF.rating == %@",flag];
        }
        else if ([scope isEqualToString:@"Four Star"])
        {
            flag = @4;
            scopePredicate= [NSPredicate predicateWithFormat:@"SELF.rating >= %@ AND SELF.rating < %@",flag, @5];
        }
        else
        {
            flag = @1;
            scopePredicate= [NSPredicate predicateWithFormat:@"SELF.rating >= %@ AND SELF.rating < %@",flag, @4];
        }
        
        // Further filter the array with the scope
        
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    _filteredRecipesArray = [NSMutableArray arrayWithArray:[tempArray copy]];
}


- (void)searchForText:(NSString *)searchText
                scope:(RatingSearchScope) scopeOption
{
    [self.filteredRecipesArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.recipeName contains[c] %@",searchText];
    NSArray *tempArray = [_recipesArray filteredArrayUsingPredicate:predicate];
    
    if(!(scopeOption == searchScoreAll))
    {
        //  make from scope number
        NSNumber *flag = nil;
        NSPredicate *scopePredicate = nil;
        if (scopeOption == searchScopeFiveStar)
        {
            flag = @5;
            scopePredicate= [NSPredicate predicateWithFormat:@"SELF.rating == %@",flag];
        }
        else if (searchScopeFourStar == scopeOption)
        {
            flag = @4;
            scopePredicate= [NSPredicate predicateWithFormat:@"SELF.rating >= %@ AND SELF.rating < %@",flag, @5];
        }
        else
        {
            flag = @1;
            scopePredicate= [NSPredicate predicateWithFormat:@"SELF.rating >= %@ AND SELF.rating < %@",flag, @4];
        }
        
        // Further filter the array with the scope
        
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    _filteredRecipesArray = [NSMutableArray arrayWithArray:[tempArray copy]];
    
}


#pragma mark - UISearchDisplayDelegate Methods

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    
    RatingSearchScope scopeKey = controller.searchBar.selectedScopeButtonIndex;
    
    [self searchForText:searchString scope:scopeKey];
    
    /*
    NSString *titleSelected = [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText: searchString   scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    */
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
 shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = controller.searchBar.text;
    [self searchForText:searchString scope:searchOption];
    return YES;
    
    // Tells the table data source to reload when scope bar selection changes
    
    /*
    [self filterContentForSearchText: [self.searchDisplayController.searchBar text]
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    */
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}



- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView
{
    //[self.searchDisplayController.searchResultsTableView registerNib: [UINib nibWithNibName:@"SimpleRecipeCell" bundle:nil]
    //                                          forCellReuseIdentifier: @"Cell"];
    
    //[self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"SimpleRecipeCell" bundle:[NSBundle mainBundle]]
      //   forCellReuseIdentifier:@"Cell"];
    tableView.rowHeight = 100;
    //self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor lightGrayColor];
    tableView.backgroundColor = [UIColor lightGrayColor];
}


/*
 - (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
 {
 [tableView registerNib:[UINib nibWithNibName:@"MyCellNib" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyCellIdentifier"];
 }
 */


/*

#pragma mark -
#pragma mark === UISearchDisplayDelegate ===
#pragma mark -

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    UYLWorldFactsSearchScope scopeKey = controller.searchBar.selectedScopeButtonIndex;
    [self searchForText:searchString scope:scopeKey];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
 shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = controller.searchBar.text;
    [self searchForText:searchString scope:searchOption];
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 64;
}

*/




#pragma mark - Search Button

- (IBAction)goToSearch:(id)sender
{
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // Note that if you didn't hide your search bar, you should probably not include this, as it would be redundant
    [_searchBar becomeFirstResponder];
}

#pragma mark
#pragma mark  conform 


@end
