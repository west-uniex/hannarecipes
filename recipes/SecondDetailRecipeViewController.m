//
//  SecondDetailRecipeViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "SecondDetailRecipeViewController.h"

#import "Recipe.h"
#import "FlavorSet.h"

#import "SimpleRecipeCell.h"
#import "FullRecipeDescriptionCell.h"

#import "MyImageStore.h"
#import "EditRecipeViewController.h"

#import "ProgressLineCell.h"

@interface SecondDetailRecipeViewController ()

@end

@implementation SecondDetailRecipeViewController

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
        frameRecipeView.size.height = self.myRecipeTableView.frame.size.height - 44;
        self.myRecipeTableView.frame = frameRecipeView;
    }

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
    [self.myRecipeTableView reloadData];
    
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            return 6;
            break;
            
        case 2:
            return self.recipe.ingredientLines.count;
            break;
            
        case 3:
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
    static NSString *CellIdentifier0 = @"CellImageAndNameSection";
    SimpleRecipeCell *cell0 = nil;
    
    static NSString *CellIdentifier1 = @"CellLineIngredientsSection";
    UITableViewCell *cell1 = nil;
    
    
    static NSString *CellIdentifier2 = @"CellFullRecipeSection";
    FullRecipeDescriptionCell *cell2 = nil;
    
    
    static NSString *CellIdentifier3 = @"CellFlaversSection";
    ProgressLineCell *cell3 = nil;
    
    switch (indexPath.section)
    {
        case 0:
            
            cell0 = (SimpleRecipeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier0 forIndexPath:indexPath];
             // Configure the cell...
            cell0.nameRecipe.text = self.recipe.recipeName;
            cell0.imageViewRecipe.image = [[MyImageStore defaultImageStore] imageForKey:  self.recipe.imageKey];
            cell0.ratingRecipeValueLabel.text = [NSString stringWithFormat:@"%@", self.recipe.rating];
            cell0.durationRecipeValueLabel.text = [NSString stringWithFormat:@"%d", [self.recipe.totalNumberInSeconds integerValue]/60];
            cell0.numberOfServingsRecipeValueLabel.text = [NSString stringWithFormat:@"%@", self.recipe.numberOfServings];
            
            return cell0;
            break;
            
        case 1: //  tastes
            cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3 forIndexPath:indexPath];
            // Configure the cell...
            if (indexPath.row == 0)
            {
                cell3.nameTaste.text = @"salty";
                [cell3.valueProgressView setProgress:[self.recipe.flavors.salty floatValue] animated:YES];
            }
            
            if (indexPath.row == 1)
            {
                cell3.nameTaste.text = @"sour";
                [cell3.valueProgressView setProgress:[self.recipe.flavors.sour floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 2)
            {
                cell3.nameTaste.text = @"sweet";
                [cell3.valueProgressView setProgress:[self.recipe.flavors.sweet floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 3)
            {
                cell3.nameTaste.text = @"bitter";
                [cell3.valueProgressView setProgress:[self.recipe.flavors.bitter floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 4)
            {
                cell3.nameTaste.text = @"meaty";
                [cell3.valueProgressView setProgress:[self.recipe.flavors.meaty floatValue] animated:YES] ;
            }
            
            if (indexPath.row == 5)
            {
                cell3.nameTaste.text = @"piquant";
                [cell3.valueProgressView setProgress:[self.recipe.flavors.piquant floatValue] animated:YES] ;
            }
            cell3.textLabel.textColor = [UIColor yellowColor];
            return cell3;
            break;
            
        case 2: //
            
            cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
            // Configure the cell...
            cell1.textLabel.text = [self.recipe.ingredientLines objectAtIndex:indexPath.row];
            cell1.textLabel.textColor = [UIColor yellowColor];
            cell1.textLabel.numberOfLines = 0;
            return cell1;
            break;
            
        case 3:
             cell2 = (FullRecipeDescriptionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
            // Configure the cell...
            cell2.fullRecipeTextView.text = self.recipe.recipeFullDescription;
            return cell2;
            break;
            
        default:
            break;
    }

    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
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
        return @"ingredient lines";
    }
    else if (section == 3)
    {
        return @"recipe full description";
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
            return 300.0;
            break;
            
        default:
            break;
    }
    
    return 0.0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UILabel *label = nil;
    CGRect frame;
    switch (section)
    {
        case 0:
            return nil;
            
        case 1:
            frame = CGRectMake(0, 0, 40, 20);
            label = [[UILabel alloc] initWithFrame:frame];
            label.text = @"    Taste";//
            label.textColor = [UIColor yellowColor];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"Helvetica" size:18];
            return label    ;
            
        case 2:
            frame = CGRectMake(0, 0, 40, 20);
            label = [[UILabel alloc] initWithFrame:frame];
            label.text = @"    Ingredient lines";//
            label.textColor = [UIColor yellowColor];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"Helvetica" size:18];

            return label;
            
        case 3:
            frame = CGRectMake(0, 0, 40, 20);
            label = [[UILabel alloc] initWithFrame:frame];
            label.text = @"    Recipe full description";//
            label.textColor = [UIColor yellowColor];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"Helvetica" size:18];

            return label;
            break;
            
        default:
            break;
    }



    return label;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section

{
    return 30.0;
}

@end
