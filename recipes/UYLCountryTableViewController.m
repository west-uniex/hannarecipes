//
//  UYLCountryTableViewController.m
//  WorldFacts
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2012 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  Neither the name of Keith Harrison nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 


#import "UYLCountryTableViewController.h"
#import "Recipe.h"
#import "RecipeStore.h"
#import "ImageStore.h"
#import "DetailRecipeTableViewController.h"


@interface UYLCountryTableViewController () < UISearchDisplayDelegate, UISearchBarDelegate>



@property (strong, nonatomic) NSArray *filteredList;

/*
if (cell == nil)
{
    [self.countryCellNib instantiateWithOwner:self
                                      options:nil];
    cell = self.countryCell;
    self.countryCell = nil;
}
*/

@property (strong, nonatomic) IBOutlet UITableViewCell *recipeCell;
@property (strong, nonatomic) UINib *countryCellNib;

typedef enum
{
    searchScopeAllRecipe = 0,
    searchScopeFiveStar = 1,
    searchScopeFourStar = 2,
    SearchScopeOther = 3
    
}  KMPRaitingSearchScope;

@end

@implementation UYLCountryTableViewController

static NSString *KMPRecipeNibCellIdentifier = @"KMPRecipeNibCellIdentifier";
static NSString *KMPRecipeCellIdentifier = @"KMPRecipeCellIdentifier";
static NSString *KMPSegueShowRecipe = @"KMPSegueShowRecipe";

#define KMP_RECIPE_CELL_TAG_NAME      100
#define KMP_RECIPE_CELL_TAG_IMAGEVIEW 200
#define KMP_RECIPE_CELL_TAG_RATING    300

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Recipe", @"Recipe");

    // When not using storyboards the following two lines load and register the NIB
    // for the country cell.
    
    // UINib *countryNib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    // [self.tableView registerNib:countryNib forCellReuseIdentifier:UYLCountryCellIdentifier];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    NSLog(@"prepareForSeqgue: %@ - %@",segue.identifier, [sender reuseIdentifier]);
    if ([segue.identifier isEqualToString:KMPSegueShowRecipe])
    {
        Recipe *recipe = nil;
        if (self.searchDisplayController.isActive)
        {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:sender];
            recipe = [self.filteredList objectAtIndex:indexPath.row];
        }
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            recipe = [self.recipes objectAtIndex:indexPath.row];
        }
        
        DetailRecipeTableViewController *viewController = segue.destinationViewController;
        viewController.recipe = recipe;
    }
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (UINib *)countryCellNib
{
    if (!_countryCellNib)
    {
        _countryCellNib = [UINib nibWithNibName:@"SimpleRecipeCell" bundle:nil];
    }
    return _countryCellNib;
}


#pragma mark -
#pragma mark === UITableViewDataSource Delegate Methods ===
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section

{
    if (tableView == self.tableView)
    {
        return [_recipes count];
    }
    else
    {
        return [_filteredList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Note that here we are not using the tableView parameter to retrieve a new table view cell. Instead
    // we always use self.tableView. This is necessary as our custom table view cell defined in the
    // storyboard and is not registered with the search results table view but only with the original
    // table.
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: KMPRecipeCellIdentifier   ]; //UYLCountryCellIdentifier];

    if (cell == nil)
    {
        // The following call should return cells for reuse but when VoiceOver is active
        // it always returns nil
        
        cell = [self.tableView dequeueReusableCellWithIdentifier: KMPRecipeNibCellIdentifier]; //UYLNibCountryCellIdentifier];
        
        if (cell == nil)
        {
            [self.countryCellNib instantiateWithOwner:self
                                              options:nil];
            cell = self.recipeCell;
            self.recipeCell = nil;
        }
    }

    Recipe *recipe = nil;
    if (tableView == self.tableView)
    {
        recipe = [_recipes objectAtIndex:indexPath.row];
    }
    else
    {
        recipe = [self.filteredList objectAtIndex:indexPath.row];
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag: KMP_RECIPE_CELL_TAG_NAME]; //UYL_COUNTRYCELLTAG_NAME];
    nameLabel.text = recipe.recipeName;

    UIImageView *pictureRecipeImageView = (UIImageView *)[cell viewWithTag:KMP_RECIPE_CELL_TAG_IMAGEVIEW];
    pictureRecipeImageView.image = [[ImageStore defaultImageStore] imageForKey:recipe.imageKey];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section

{
    if (tableView == self.tableView)
    {
        return nil;
    }
    else
    {
        return nil;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return nil;
    }
    else
    {
        return nil;
    }
}


#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -

// The following method is implemented as a workaround for the iOS 5 bug when dequeuing
// cells with VoiceOver active. When the cell is not loaded from the storyboard
// we need to manually perform the segue.

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString: KMPRecipeNibCellIdentifier]) //UYLNibCountryCellIdentifier])
    {
        [self performSegueWithIdentifier:KMPSegueShowRecipe sender:cell];
    }
}


#pragma mark -
#pragma mark === UISearchDisplayDelegate ===
#pragma mark -

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    KMPRaitingSearchScope scopeKey = controller.searchBar.selectedScopeButtonIndex;
    //UYLWorldFactsSearchScope scopeKey = controller.searchBar.selectedScopeButtonIndex;
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

- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 64;
}


- (void)searchForText:(NSString *)searchText
                scope:(KMPRaitingSearchScope)scopeOption
{

    switch (scopeOption)
    {
        case searchScopeAllRecipe: //KMPRaitingSearchScope:
            ;
            break;
            
        case searchScopeFiveStar: //KMPRaitingSearchScope:
            ;
            break;
            
        case searchScopeFourStar: //KMPRaitingSearchScope:
            ;
            break;
            
        case SearchScopeOther: //KMPRaitingSearchScope:
            ;
            break;
            
        default:
            break;
    }
}

@end
