//
//  DetailWebRecipeViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 15.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "DetailWebRecipeViewController.h"

#import "Recipe.h"
#import "FlavorSet.h"

#import "SimpleRecipeCell.h"
#import "FullRecipeDescriptionCell.h"

#import "MyImageStore.h"
#import "EditRecipeViewController.h"

#import "RecipeStore.h"
#import "ProgressLineCell.h"


@interface DetailWebRecipeViewController ()

@end

@implementation DetailWebRecipeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if (screenHeight == 568)
    {
        // make for recipe view  shift for 44 points ???
        CGRect frameRecipeView = self.myRecipeTableView.frame;
        frameRecipeView.origin.y = frameRecipeView.origin.y + 44;
        frameRecipeView.size.height = frameRecipeView.size.height - 44;
        self.myRecipeTableView.frame = frameRecipeView;
    }

    [self.myRecipeTableView registerNib:[UINib nibWithNibName:@"WebSimpleRecipeCell" bundle:nil]
                 forCellReuseIdentifier:@"Cell"];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.myRecipeTableView reloadData];
    
    DLog(@" recipe: %@", self.recipe);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    NSInteger numberOfRows = 0;
    
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            numberOfRows = [self.recipe.flavors counterNonzeroValue];
            return  6;
            break;
            
        case 2:
            return self.recipe.ingredients.count;
            break;
        
        case 3:
            return self.recipe.ingredientLines.count;
            break;
            
        case 4:
            return 1;
            break;
            
        default:
            break;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier0 = @"Cell";
    SimpleRecipeCell *cell0 = nil;
    
    static NSString *CellIdentifier1 = @"CellFlavorSection";
    ProgressLineCell *cell1 = nil;
    
    static NSString *CellIdentifier2 = @"CellFullRecipeLink";
    UITableViewCell *cell2 = nil;
    
    switch (indexPath.section)
    {
        case 0:
            
            cell0 = (SimpleRecipeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier0
                                                                        forIndexPath:indexPath];
            // Configure the cell...
            cell0.nameRecipe.text = self.recipe.recipeName;
            //cell0.imageViewRecipe.image = [[MyImageStore defaultImageStore] imageForKey:  self.recipe.imageKey];
            cell0.imageViewRecipe.image = self.iconRecipeImage;
            cell0.ratingRecipeValueLabel.text = [NSString stringWithFormat:@"%@", self.recipe.rating];
            if ([self.recipe.totalNumberInSeconds isKindOfClass:[NSNumber class]])
            {
                int durationInSeconds = [self.recipe.totalNumberInSeconds intValue];
                cell0.durationRecipeValueLabel.text = [NSString stringWithFormat:@"%d", durationInSeconds/60];
            }
            else
            {
                cell0.durationRecipeValueLabel.text = @" ";
            }

            cell0.numberOfServingsRecipeValueLabel.text = [NSString stringWithFormat:@"%@", self.recipe.numberOfServings];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            cell0.accessoryType = UITableViewCellAccessoryNone;
            return cell0;
            break;
            
        case 1: // flavers
            
            cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
            // Configure the cell...
            
            
             if (indexPath.row == 0)
            {
                cell1.nameTaste.text = @"salty";
                [cell1.valueProgressView setProgress:[self.recipe.flavors.salty floatValue] animated:YES];
            }
            
            if (indexPath.row == 1)
            {
                cell1.nameTaste.text = @"sour";
                [cell1.valueProgressView setProgress:[self.recipe.flavors.sour floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 2)
            {
                cell1.nameTaste.text = @"sweet";
                [cell1.valueProgressView setProgress:[self.recipe.flavors.sweet floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 3)
            {
                cell1.nameTaste.text = @"bitter";
                [cell1.valueProgressView setProgress:[self.recipe.flavors.bitter floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 4)
            {
                cell1.nameTaste.text = @"meaty";
                [cell1.valueProgressView setProgress:[self.recipe.flavors.meaty floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 5)
            {
                cell1.nameTaste.text = @"piquant";
                [cell1.valueProgressView setProgress:[self.recipe.flavors.piquant floatValue] animated:YES] ;
            }
            cell1.textLabel.textColor = [UIColor yellowColor];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell1;
            break;
            
            
        case 2:   // ingredients
            
            cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
            // Configure the cell...
            cell2.textLabel.text = [self.recipe.ingredients objectAtIndex:indexPath.row];
            cell2.textLabel.textColor = [UIColor yellowColor];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell2;
            break;
            
            
        case 3:   // igredients lines
            
            cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
            // Configure the cell...
            cell2.textLabel.text = [self.recipe.ingredientLines objectAtIndex:indexPath.row];
            cell2.textLabel.textColor = [UIColor yellowColor];
            cell2.textLabel.numberOfLines = 0;
            cell2.textLabel.adjustsFontSizeToFitWidth = YES;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell2;
            break;
            
        case 4:   // full recipe link
            
            cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
            // Configure the cell...
            cell2.textLabel.text = self.recipe.sourceRecipeUrl;
            cell2.textLabel.textColor = [UIColor redColor];
            cell2.selectionStyle = UITableViewCellSelectionStyleBlue;
            return cell2;
            break;
            
        default:
            break;
    }
    
    
    
    return cell0;
}

#pragma mark

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section

{
    if (section == 0)
    {
        return @"";
    }
    else if (section == 1)
    {
        return @"Taste";
    }
    else if (section == 2)
    {
        return @"ingredients";
    }

    else if (section == 3)
    {
        return @"ingredient lines";
    }
    else if (section == 4)
    {
        return @"recipe full description link";
    }
    
    return @"";
    
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditRecipe"])
    {
        UINavigationController *nc = segue.destinationViewController;
        
        //  retrieve ivar of all edit recipe view controller
        EditRecipeViewController  *editRecipeController = (EditRecipeViewController *)nc.topViewController;
        //  Passing data between view controllers
        editRecipeController.recipe = self.recipe;
    }
    
}

#pragma mark
#pragma mark    UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 4)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.recipe.sourceRecipeUrl]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 100.0;
            
        case 1:
            return 44.0;
            
        case 2:
            return 44.0;
            
        case 3:
            return 44.0;
            
        case 4:
            return 44.0;
            
        default:
            break;
    }
    
    return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    switch (section)
    {
        case 0:
            return 0.0;
            
        case 1:
            return 44.0;
            
        case 2:
            return 44.0;
            
        case 3:
            return 44.0;
            
        case 4:
            return 44.0;
            
        default:
            break;
    }

    
    return 0.0;
}


#pragma mark    action


- (IBAction)saveButtonDidTap:(id)sender
{
    DLog(@" ");
    UIAlertView *endorseSaveAlertView = [[UIAlertView alloc] initWithTitle: @"Endorse Save In Favorite Recipe"
                                                                   message:@" "
                                                                  delegate:self
                                                         cancelButtonTitle:@"NO"
                                                         otherButtonTitles:@"YES", nil];
    endorseSaveAlertView.tag = 300;
    [endorseSaveAlertView show];
}


- (IBAction)sendButtonDidTap:(id)sender
{
    NSString *message = NSLocalizedString(@"I have image of recipe",
                                          @"  ");
    NSArray *activityItems = @[ message, self.iconRecipeImage ];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll, UIActivityTypeAssignToContact];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)lookForRecipeInSafary:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.recipe.sourceRecipeUrl]];
}

#pragma mark conform UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (alertView.tag == 300)
    {
        if (buttonIndex == 0)
        {
            DLog(@" button index = 0  it's NO button did tap");
        }
        else if (buttonIndex == 1)
        {
            DLog(@"button index = 1 it's YES button did tap");
            [[RecipeStore defaultStore] addRecipe:_recipe withImage:_iconRecipeImage];
            if (![[RecipeStore defaultStore] saveChanges])
            {
                DLog(@" bad news data did not saved");
            }
            
        }
    }
}




@end
