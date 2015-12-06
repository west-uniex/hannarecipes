//
//  EditRecipeViewController.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
//#import "MyRecipeView.h"

@class MyRecipeView;

@interface EditRecipeViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet MyRecipeView *myRecipeView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) NSData *imageData;

- (IBAction)cancelButtonDidTap:(id)sender;

- (IBAction)saveButtonDidTap:(id)sender;


@end
