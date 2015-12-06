//
//  DetailRecipeTableViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 14.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "DetailRecipeTableViewController.h"
#import "Recipe.h"
#import "FlavorSet.h"
#import "ImageStore.h"
#import "RecipeStore.h"

#import "AllIngredientsTableViewController.h"
#import "AllIngredientsNavigationController.h"

@interface DetailRecipeTableViewController ()

@end

@implementation DetailRecipeTableViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        //DLog(@" I AM HERE !!!");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DLog(@" %@", self.recipe);
    self.recipeImageView.image = self.iconRecipeImage;
    self.nameRecipeLabel.text = self.recipe.recipeName;
    self.ratingRecipeLabel.text = [NSString stringWithFormat:@"Rating = %@", self.recipe.rating];
    if ([self.recipe.totalNumberInSeconds isKindOfClass:[NSNumber class]])
    {
        int durationInSeconds = [self.recipe.totalNumberInSeconds intValue];
        self.durationMakingRecipeInMinutes.text = [NSString stringWithFormat:@"%d",durationInSeconds/60];
    }
    else
    {
        self.durationMakingRecipeInMinutes.text = @"30";
    }
    
    /*
    if (([self.recipe.flavors.bitter floatValue] == 0.0 )&& ([self.recipe.flavors.meaty floatValue]== 0.0) && ([self.recipe.flavors.salty floatValue] == 0.0) &&([self.recipe.flavors.piquant floatValue] == 0.0) && ([self.recipe.flavors.sour floatValue] == 0.0) && ([self.recipe.flavors.sweet floatValue] == 0.0))
    {
        self.bitterValueLabel.text = [NSString stringWithFormat:@"NO DATA"];
        self.meatyValueLabel.text = [NSString stringWithFormat:@"NO DATA"];
        self.piquantValueLabel.text = [NSString stringWithFormat:@"NO DATA"];
        self.saltyValueLabel.text = [NSString stringWithFormat:@"NO DATA"];
        self.sourValueLabel.text = [NSString stringWithFormat:@"NO DATA"];
        self.sweetValueLabel.text = [NSString stringWithFormat:@"NO DATA"];
    }
    else
    {
        self.bitterValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.bitter floatValue]];
        self.meatyValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.meaty floatValue]];
        self.piquantValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.salty floatValue]];
        self.saltyValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.piquant floatValue]];
        self.sourValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.sour floatValue]];
        self.sweetValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.sweet floatValue]];

    }
    */
    [self.valueBitterProgressView setProgress:[self.recipe.flavors.bitter floatValue] animated:YES];
    [self.valueMeatyProgressView setProgress:[self.recipe.flavors.meaty floatValue] animated:YES];
    [self.valuePiquantProgressView setProgress:[self.recipe.flavors.piquant floatValue] animated:YES];
    [self.valueSaltyProgressView setProgress:[self.recipe.flavors.salty floatValue] animated:YES];
    [self.valueSourProgressView setProgress:[self.recipe.flavors.sour floatValue] animated:YES];
    [self.valueSweetyProgressView setProgress:[self.recipe.flavors.sweet floatValue] animated:YES];
    
    
    [self loadIngredientsLabels];
    
    // ingredient lines section
    NSMutableString *text = [NSMutableString stringWithString:[NSString stringWithFormat:@"- %@,", [self.recipe.ingredientLines objectAtIndex:0]]];
    for (NSUInteger i = 1; i < self.recipe.ingredientLines.count; i++)
    {
        [text appendString:[NSString stringWithFormat:@"\n- %@,", [self.recipe.ingredientLines objectAtIndex:i]]];
    }
    self.ingredientLinesTextView.text = [text copy];
    //
    NSString *textForNumberOfServingsPersonLabel = [NSString stringWithFormat:@"%@", self.recipe.numberOfServings];
    if ([textForNumberOfServingsPersonLabel isEqualToString:@"(null)" ])
    {
        self.numberOfServingsPersonLabel.text = @"3";
    }
    else
    {
        self.numberOfServingsPersonLabel.text = textForNumberOfServingsPersonLabel;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark internal methods

- (void) loadIngredientsLabels
{
    self.seeAllIngredientsButton.hidden = YES;
    
    NSArray *ingredients = self.recipe.ingredients;
    NSUInteger numberIngredients = [ingredients count];
    // for debug goal
    //numberIngredients = 25;
    DLog(@"number ingredients in recipe = %d", numberIngredients);
    
    if (numberIngredients == 1)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = @" ";
        self.ingredient2Label.text = @" ";
        self.ingredient3Label.text = @" ";
        self.ingredient4Label.text = @" ";
        self.ingredient5Label.text = @" ";
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";

    }
    else if (numberIngredients == 2)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = @" ";
        self.ingredient3Label.text = @" ";
        self.ingredient4Label.text = @" ";
        self.ingredient5Label.text = @" ";
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 3)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = @" ";
        self.ingredient4Label.text = @" ";
        self.ingredient5Label.text = @" ";
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 4)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = @" ";
        self.ingredient5Label.text = @" ";
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 5)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = @" ";
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 6)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 7)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 8)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 9)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 10)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 11)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 12)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 13)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 14)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 15)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 16)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 17)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 18)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 19)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 20)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = [ingredients objectAtIndex:19];
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 21)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = [ingredients objectAtIndex:19];
        self.ingredient20Label.text = [ingredients objectAtIndex:20];
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 22)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = [ingredients objectAtIndex:19];
        self.ingredient20Label.text = [ingredients objectAtIndex:20];
        self.ingredient21Label.text = [ingredients objectAtIndex:21];
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 23)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = [ingredients objectAtIndex:19];
        self.ingredient20Label.text = [ingredients objectAtIndex:20];
        self.ingredient21Label.text = [ingredients objectAtIndex:21];
        self.ingredient22Label.text = [ingredients objectAtIndex:22];
        self.ingredient23Label.text = @" ";
    }
    else if (numberIngredients == 24)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = [ingredients objectAtIndex:19];
        self.ingredient20Label.text = [ingredients objectAtIndex:20];
        self.ingredient21Label.text = [ingredients objectAtIndex:21];
        self.ingredient22Label.text = [ingredients objectAtIndex:22];
        self.ingredient23Label.text = [ingredients objectAtIndex:23];
    }
    else if (numberIngredients > 24)
    {
        self.ingredient0Label.text = [ingredients objectAtIndex:0];
        /*
        self.ingredient1Label.text = [ingredients objectAtIndex:1];
        self.ingredient2Label.text = [ingredients objectAtIndex:2];
        self.ingredient3Label.text = [ingredients objectAtIndex:3];
        self.ingredient4Label.text = [ingredients objectAtIndex:4];
        self.ingredient5Label.text = [ingredients objectAtIndex:5];
        self.ingredient6Label.text = [ingredients objectAtIndex:6];
        self.ingredient7Label.text = [ingredients objectAtIndex:7];
        self.ingredient8Label.text = [ingredients objectAtIndex:8];
        self.ingredient9Label.text = [ingredients objectAtIndex:9];
        self.ingredient10Label.text = [ingredients objectAtIndex:10];
        self.ingredient11Label.text = [ingredients objectAtIndex:11];
        self.ingredient12Label.text = [ingredients objectAtIndex:12];
        self.ingredient13Label.text = [ingredients objectAtIndex:13];
        self.ingredient14Label.text = [ingredients objectAtIndex:14];
        self.ingredient15Label.text = [ingredients objectAtIndex:15];
        self.ingredient16Label.text = [ingredients objectAtIndex:16];
        self.ingredient17Label.text = [ingredients objectAtIndex:17];
        self.ingredient18Label.text = [ingredients objectAtIndex:18];
        self.ingredient19Label.text = [ingredients objectAtIndex:19];
        self.ingredient20Label.text = [ingredients objectAtIndex:20];
        self.ingredient21Label.text = [ingredients objectAtIndex:21];
        self.ingredient22Label.text = [ingredients objectAtIndex:22];
         */
        self.ingredient23Label.text = @"tap to see more ingredients";
        self.ingredient23Label.textColor = [UIColor redColor];
        self.seeAllIngredientsButton.hidden = NO;
    }
    else
    {
        self.ingredient0Label.text = @" ";
        self.ingredient1Label.text = @" ";
        self.ingredient2Label.text = @" ";
        self.ingredient3Label.text = @" ";
        self.ingredient4Label.text = @" ";
        self.ingredient5Label.text = @" ";
        self.ingredient6Label.text = @" ";
        self.ingredient7Label.text = @" ";
        self.ingredient8Label.text = @" ";
        self.ingredient9Label.text = @" ";
        self.ingredient10Label.text = @" ";
        self.ingredient11Label.text = @" ";
        self.ingredient12Label.text = @" ";
        self.ingredient13Label.text = @" ";
        self.ingredient14Label.text = @" ";
        self.ingredient15Label.text = @" ";
        self.ingredient16Label.text = @" ";
        self.ingredient17Label.text = @" ";
        self.ingredient18Label.text = @" ";
        self.ingredient19Label.text = @" ";
        self.ingredient20Label.text = @" ";
        self.ingredient21Label.text = @" ";
        self.ingredient22Label.text = @" ";
        self.ingredient23Label.text = @" ";
    }
}


#pragma mark - Table view data source


#pragma mark
#pragma mark - Navigation   segues

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
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"GoToAllIngredients"])
    {
        UINavigationController *nc = segue.destinationViewController;
        //  retrieve ivar of all gradients view controller
        AllIngredientsTableViewController *allIngredientsViewController = (AllIngredientsTableViewController *) nc.topViewController;
        //  Passing data between view controllers
        [allIngredientsViewController setAllIngredients: self.recipe.ingredients];
    }
}


#pragma mark IB Action

- (IBAction)saveInFavoriteButtonDidTap:(id)sender
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

- (IBAction)seeAllIngredientsButtonDidTap:(id)sender
{

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

#pragma mark
#pragma mark       UITableViewDelegate

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
