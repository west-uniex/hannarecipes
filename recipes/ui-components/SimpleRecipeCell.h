//
//  SimpleRecipeCell.h
//  recipes
//
//  Created by Anna Kondratyuk on 11.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleRecipeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewRecipe;
@property (weak, nonatomic) IBOutlet UILabel *nameRecipe;

@property (weak, nonatomic) IBOutlet UILabel *ratingRecipeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationRecipeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfServingsRecipeValueLabel;



@end
