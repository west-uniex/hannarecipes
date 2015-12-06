//
//  MyRecipeView.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 06.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyRecipeViewDelegate;

@interface MyRecipeView : UIView
//
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UITextField *recipeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeNumberOfServingsTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeRatingTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeDurationValueTextField;
//
@property (weak, nonatomic) IBOutlet UITextField *recipeBitterValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeMeatyValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipePiquantValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeSaltyValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeSourValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *recipeSweetValueTextField;
//
@property (weak, nonatomic) IBOutlet UITextView *recipeIngredientsLinesTextView;
@property (weak, nonatomic) IBOutlet UITextView *recipeFullDescriptionTextView;

- (IBAction)buttonPicPhotoDidTap:(id)sender;
- (IBAction)didChangeNameRecipeText:(id)sender;

@end


