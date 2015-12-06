//
//  DetailRecipeTableViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 14.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@interface DetailRecipeTableViewController : UITableViewController

@property (strong,nonatomic) Recipe *recipe;
@property (strong, nonatomic) UIImage *iconRecipeImage;

@property (weak, nonatomic) IBOutlet UILabel *durationMakingRecipeInMinutes;

@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameRecipeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingRecipeLabel;


@property (weak, nonatomic) IBOutlet UILabel *bitterValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *meatyValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *piquantValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *saltyValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *sweetValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *ingredient0Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient12Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient1Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient13Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient2Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient14Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient3Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient15Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient4Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient16Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient5Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient17Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient6Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient18Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient7Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient19Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient8Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient20Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient9Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient21Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient10Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient22Label;

@property (weak, nonatomic) IBOutlet UILabel *ingredient11Label;
@property (weak, nonatomic) IBOutlet UILabel *ingredient23Label;

@property (weak, nonatomic) IBOutlet UIButton *seeAllIngredientsButton;

@property (weak, nonatomic) IBOutlet UITextView *ingredientLinesTextView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfServingsPersonLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *valueBitterProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *valueMeatyProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *valuePiquantProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *valueSaltyProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *valueSourProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *valueSweetyProgressView;

- (IBAction)saveInFavoriteButtonDidTap:(id)sender;

- (IBAction)sendButtonDidTap:(id)sender;

- (IBAction)seeAllIngredientsButtonDidTap:(id)sender;
- (IBAction)lookForRecipeInSafary:(id)sender;

@end

/*
flavors =     {
    Bitter = "0.1666666666666667";
    Meaty = "0.3333333333333333";
    Piquant = 0;
    Salty = "0.5";
    Sour = "0.3333333333333333";
    Sweet = "0.3333333333333333";
};
*/