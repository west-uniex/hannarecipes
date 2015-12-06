//
//  MyRecipesTableViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "MyRecipesTableViewController.h"
#import "Recipe.h"
#import "MyRecipeStore.h"
#import "DetailRecipeTableViewController.h"

#import "SimpleRecipeCell.h"
#import "UIImageView+RemoteFile.h"

#import "EditRecipeViewController.h"

#import "MyImageStore.h"

@interface MyRecipesTableViewController ()
{
    UIToolbar *tb;
}
@end

@implementation MyRecipesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // prepare for work with UISearchDisplayController
    [self.searchDisplayController.searchResultsTableView registerNib: [UINib nibWithNibName:@"WebSimpleRecipeCell" bundle:nil]
                                              forCellReuseIdentifier: @"Cell"];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor lightGrayColor];
    
    //  prepare for add toolbar to keyboard view
    self.searchBar.inputAccessoryView = [self accessoryView];
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.navigationItem.leftBarButtonItem = self.
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.recipesArray = [[MyRecipeStore defaultStore] allRecipes];
    [self.tableView reloadData];
    
}

- (void) viewDidAppear:(BOOL)paramAnimated
{
    [super viewDidAppear:paramAnimated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adjustForKeyboard:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void) viewDidDisappear:(BOOL)paramAnimated
{
    [super viewDidDisappear:paramAnimated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    ;
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
	//
    if ([self.searchBar.text length] > 0)
    {
        [self.searchBar resignFirstResponder];
    }
    else
    {
        [self.searchDisplayController setActive:NO animated:YES];
    }
}


#pragma mark
#pragma mark handling keyboard notifications


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
    DLog(@"keyboard bounds %@", [userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"]);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section

{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [_filteredRecipesArray count];
    }
	else
	{
        return [_recipesArray count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a new Recipe Object
    Recipe *recipe = nil;
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        static NSString *CellIdentifier2 = @"Cell";
        SimpleRecipeCell *cell2 = nil;
        cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2
                                                forIndexPath:indexPath];
        
        //
        recipe = [_filteredRecipesArray objectAtIndex:[indexPath row]];
        
        //Configure the cell
        cell2.nameRecipe.text = recipe.recipeName;
        cell2.nameRecipe.textColor = [UIColor yellowColor];
        //[cell2.imageViewRecipe  setImageWithRemoteFileURL: recipe.imageUrl placeHolderImage: [UIImage imageNamed:@"image-yummly.png"]];
        cell2.imageViewRecipe.image = [[MyImageStore defaultImageStore] imageForKey: recipe.imageKey];
        cell2.ratingRecipeValueLabel.text = [NSString stringWithFormat:@"%@", recipe.rating];
        cell2.ratingRecipeValueLabel.textColor = [UIColor yellowColor];
        cell2.durationRecipeValueLabel.text = [NSString stringWithFormat:@"%d", [recipe.totalNumberInSeconds integerValue]/60];
        cell2.durationRecipeValueLabel.textColor = [UIColor yellowColor];
        cell2.numberOfServingsRecipeValueLabel.text = [NSString stringWithFormat:@"%@", recipe.numberOfServings];
        return cell2;
        
    }
	
    //
    // in case of full table view
    //
    
    static NSString *CellIdentifier = @"RecipeCell";
    SimpleRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                             forIndexPath:indexPath];
    //  retrieve current recipe
    recipe = [_recipesArray objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    cell.nameRecipe.text = recipe.recipeName;
    //[cell.imageViewRecipe  setImageWithRemoteFileURL: recipe.imageUrl   placeHolderImage: [UIImage imageNamed:@"image-yummly.png"]];
    cell.imageView.image = [[MyImageStore defaultImageStore] imageForKey: recipe.imageKey];
    cell.ratingRecipeValueLabel.text = [NSString stringWithFormat:@"%@", recipe.rating];
    cell.durationRecipeValueLabel.text = [NSString stringWithFormat:@"%d", [recipe.totalNumberInSeconds integerValue]/60];
    cell.durationRecipeValueLabel.textColor = [UIColor yellowColor];
    cell.numberOfServingsRecipeValueLabel.text = [NSString stringWithFormat:@"%@", recipe.numberOfServings];
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark
#pragma mark       UITableViewDelegate

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    if (self.tableView == tableView)
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
    
    if (self.searchDisplayController.searchResultsTableView == tableView)
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
        
        //[self performSegueWithIdentifier: @"DetailRecipeSegue" sender: self];
    }
     */
}



- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
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


#pragma mark - UISearchDisplayDelegate Methods

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText: searchString
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
 shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText: [self.searchDisplayController.searchBar text]
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    DLog(@" searchDisplayController = %@", controller);
    
    [self.searchDisplayController.searchResultsTableView registerNib: [UINib nibWithNibName:@"WebSimpleRecipeCell" bundle:nil]
                                              forCellReuseIdentifier: @"Cell"];
    /*
    {
        // Don't show the scope bar or cancel button until editing begins
        [self.searchBar setShowsScopeBar:NO];
        [self.searchBar sizeToFit];
        
        // Hide the search bar until user scrolls up
        CGRect newBounds = [[self tableView] bounds];
        newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
        [[self tableView] setBounds:newBounds];
        
        [self.tableView reloadData];
    }
     */
}

- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView
{
    [self.searchDisplayController.searchResultsTableView registerNib: [UINib nibWithNibName:@"WebSimpleRecipeCell" bundle:nil]
                                              forCellReuseIdentifier: @"Cell"];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor lightGrayColor];
}


#pragma mark - Search Button

- (IBAction)goToSearch:(id)sender
{
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // Note that if you didn't hide your search bar, you should probably not include this, as it would be redundant
    [_searchBar becomeFirstResponder];
}




- (IBAction)createNewRecipeButtonDidTap:(id)sender
{
    
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
    if ([segue.identifier isEqualToString:@"CreatedByMeRecipeSegue"])
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
    
    if ([segue.identifier isEqualToString:@"AddNewRecipe"])
    {
        Recipe *currentRecipe = [Recipe recipeWithRecipeId:nil
                                                recipeName:nil
                                                    rating:@0
                                             totalDuration:@0
                                               ingredients:nil
                                                   flavors:nil
                                                  imageUrl:@"no"
                                                 imageSize:@"90"];
        UINavigationController *nc = segue.destinationViewController;
        
        //  retrieve ivar of all edit recipe view controller
         EditRecipeViewController  *editRecipeController = (EditRecipeViewController *)nc.topViewController;
        //  Passing data between view controllers
        editRecipeController.recipe = currentRecipe;
    }

}


@end
