//
//  EditRecipeViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "EditRecipeViewController.h"
#import "MyRecipeView.h"
#import "UIImage+Thumbnail.h"

#import <QuartzCore/QuartzCore.h>

#import "MyRecipeStore.h"
#import "MyImageStore.h"

#import "FlavorSet.h"

@interface EditRecipeViewController ()

{
    UIToolbar *tb;
    BOOL flagCreatingNewRecipe;
}

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIAlertView *alertAboutIncorrectInputFlavers;
@property (nonatomic, strong) UIAlertView *alertAboutIncorrectInputIngredientLines;
@property (nonatomic, strong) UIAlertView *alertAboutIncorrectInputRating;

@end

@implementation EditRecipeViewController


- (UIAlertView *) alertAboutIncorrectInputFlavers
{
    if (!_alertAboutIncorrectInputFlavers)
    {
        _alertAboutIncorrectInputFlavers = [[UIAlertView alloc] initWithTitle:@"Incorrect Input"
                                                                      message:@"Please enter decimal value from 0.0 till 1.0"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil, nil];
    }
    
    //[self.alertAboutIncorrectInputFlavers show];
    
    return _alertAboutIncorrectInputFlavers;

}


- (UIAlertView *) alertAboutIncorrectInputIngredientLines
{
    if (!_alertAboutIncorrectInputIngredientLines)
    {
        _alertAboutIncorrectInputIngredientLines = [[UIAlertView alloc] initWithTitle:@"Incorrect Input"
                                                                              message:@"Please earch ingredient line begin new row from'-' and end ','"
                                                                             delegate:nil
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil, nil];
    }
    
    return _alertAboutIncorrectInputIngredientLines;
}


- (UIAlertView *) alertAboutIncorrectInputRating
{
    if (!_alertAboutIncorrectInputRating)
    {
        _alertAboutIncorrectInputRating = [[UIAlertView alloc] initWithTitle:@"Incorrect Input"
                                                                     message:@"Please set rating from 1 till 5"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil, nil];
    }
    
    return _alertAboutIncorrectInputRating;
}

#pragma mark
#pragma mark view life time methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DLog(@"recipe for editing:  %@", self.recipe);
    
    tb = nil;
	
    //self.myScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 64);
    self.myScrollView.delegate = self;
    //self.myScrollView.contentOffset = CGPointMake(0, 100);
    
    self.myRecipeView = [[[NSBundle mainBundle] loadNibNamed:@"MyRecipeView"
                                                       owner:self
                                                     options:nil] objectAtIndex:0];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if (screenHeight == 568)
    {
        // make for recipe view  shift for 44 points ???
        CGRect frameRecipeView = self.myRecipeView.frame;
        frameRecipeView.origin.y = frameRecipeView.origin.y + 44;
        self.myRecipeView.frame = frameRecipeView;
    }
    
    //  prepare for add toolbar to keyboard view
    self.myRecipeView.recipeNameTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeNumberOfServingsTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeRatingTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeDurationValueTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeBitterValueTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeMeatyValueTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipePiquantValueTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeSaltyValueTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeSourValueTextField.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeSweetValueTextField.inputAccessoryView = [self accessoryView];
    
    self.myRecipeView.recipeIngredientsLinesTextView.inputAccessoryView = [self accessoryView];
    self.myRecipeView.recipeFullDescriptionTextView.inputAccessoryView = [self accessoryView];
   
    // add recipe view to scroll view
    [self.myScrollView addSubview:_myRecipeView];
    
    
    if (self.recipe.recipeName.length > 0  && self.recipe.recipeId.length > 0)
    {
        // editing already existing recipe, we have to set up old value ...
        //  main part section
        self.myRecipeView.recipeImageView.image = [[MyImageStore defaultImageStore] imageForKey: self.recipe.imageKey];
        self.myRecipeView.recipeNameTextField.text = self.recipe.recipeName;
        if (self.recipe.numberOfServings)
        {
            self.myRecipeView.recipeNumberOfServingsTextField.text = [NSString stringWithFormat:@"%@", self.recipe.numberOfServings];
        }
        else
        {
            self.myRecipeView.recipeNumberOfServingsTextField.text = [NSString stringWithFormat:@"3"];
        }
        
        self.myRecipeView.recipeRatingTextField.text = [NSString stringWithFormat:@"%@", self.recipe.rating];
        self.myRecipeView.recipeDurationValueTextField.text = [NSString stringWithFormat:@"%d", [self.recipe.totalNumberInSeconds intValue]/60];
        //  flavor section
        self.myRecipeView.recipeBitterValueTextField.text = [NSString stringWithFormat:@"%.5g", [self.recipe.flavors.bitter floatValue]];
        self.myRecipeView.recipeMeatyValueTextField.text = [NSString stringWithFormat:@"%.5g", [self.recipe.flavors.meaty floatValue]];
        self.myRecipeView.recipePiquantValueTextField.text = [NSString stringWithFormat:@"%.5g", [self.recipe.flavors.piquant floatValue]];
        self.myRecipeView.recipeSaltyValueTextField.text = [NSString stringWithFormat:@"%.5g", [self.recipe.flavors.salty floatValue]];
        self.myRecipeView.recipeSourValueTextField.text = [NSString stringWithFormat:@"%.5g", [self.recipe.flavors.sour floatValue]];
        self.myRecipeView.recipeSweetValueTextField.text = [NSString stringWithFormat:@"%.5g", [self.recipe.flavors.sweet floatValue]];
        
        // ingredient lines section
        NSMutableString *text = [NSMutableString stringWithString:[NSString stringWithFormat:@"- %@,", [self.recipe.ingredientLines objectAtIndex:0]]];
        for (NSUInteger i = 1; i < self.recipe.ingredientLines.count - 1; i++)
        {
            [text appendString:[NSString stringWithFormat:@"\n- %@,", [self.recipe.ingredientLines objectAtIndex:i]]];
        }
        [text appendString:[NSString stringWithFormat:@"\n- %@", [self.recipe.ingredientLines objectAtIndex: self.recipe.ingredientLines.count -1 ]]];
        self.myRecipeView.recipeIngredientsLinesTextView.text = [text copy];

        //  full description of recipe section
        self.myRecipeView.recipeFullDescriptionTextView.text = self.recipe.recipeFullDescription;
    }
    else
    {
        // create new recipe
        flagCreatingNewRecipe = YES;
        self.recipe.recipeId = self.recipe.imageKey;
    }
    
    //  make scrolling
     self.myScrollView.contentSize = self.myRecipeView.bounds.size;
    
    //  set as delegate for all textView and textFields
    self.myRecipeView.recipeNameTextField.delegate = self;
    self.myRecipeView.recipeNumberOfServingsTextField.delegate = self;
    self.myRecipeView.recipeRatingTextField.delegate = self;
    self.myRecipeView.recipeDurationValueTextField.delegate = self;
    self.myRecipeView.recipeBitterValueTextField.delegate = self;
    self.myRecipeView.recipeMeatyValueTextField.delegate = self;
    self.myRecipeView.recipePiquantValueTextField.delegate = self;
    self.myRecipeView.recipeSaltyValueTextField.delegate = self;
    self.myRecipeView.recipeSourValueTextField.delegate = self;
    self.myRecipeView.recipeSweetValueTextField.delegate = self;
    
    self.myRecipeView.recipeIngredientsLinesTextView.delegate = self;
    self.myRecipeView.recipeFullDescriptionTextView.delegate = self;
    // make round borders for text views
    self.myRecipeView.recipeIngredientsLinesTextView.layer.cornerRadius = 20;
    self.myRecipeView.recipeFullDescriptionTextView.layer.cornerRadius = 20;
    
    //  make border line for them
    self.myRecipeView.recipeIngredientsLinesTextView.layer.borderWidth = 2;
    self.myRecipeView.recipeIngredientsLinesTextView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.myRecipeView.recipeFullDescriptionTextView.layer.borderWidth = 2;
    self.myRecipeView.recipeFullDescriptionTextView.layer.borderColor = [UIColor blackColor].CGColor;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
     [self updateSaveButton];
    
}


- (void) viewDidAppear:(BOOL)paramAnimated
{
    [super viewDidAppear:paramAnimated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(handleKeyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    [center addObserver:self
               selector:@selector(handleKeyboardWillHide:)
                   name:UIKeyboardWillHideNotification
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

#pragma mark
#pragma mark  internal methods for show advanced keyboard

- (UIToolbar *) accessoryView
{
    if (tb)
    {
        return tb;
    }
    
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
	//[self.enterNameRecipeTextField setText:@""];
    
    //  search active text view or textfield view
    for (UIView *view in self.myRecipeView.subviews)
    {
        if ([view isFirstResponder])
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField *textField = (UITextField *)view;
                textField.text = @"";
                break;
            }
            
            if ([view isKindOfClass:[UITextView class]])
            {
                UITextView *textView = (UITextView *)view;
                textView.text = @"";
                break;
            }
        }
    }
    
}

- (void) leaveKeyboardMode
{
	//[self.enterNameRecipeTextField resignFirstResponder];
    
    //  search active text view or textfield view
    for (UIView *view in self.myRecipeView.subviews)
    {
        if ([view isFirstResponder])
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField *textField = (UITextField *)view;
                [textField resignFirstResponder];
                break;
            }
            
            if ([view isKindOfClass:[UITextView class]])
            {
                UITextView *textView = (UITextView *)view;
                [textView resignFirstResponder];
                break;
            }
        }
    }

}



#pragma mark
#pragma mark  handling the keyboard notification

- (void) handleKeyboardWillHide:(NSNotification *)paramNotification
{
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.myScrollView.contentInset, UIEdgeInsetsZero))
    {
        /* Our table view's content inset is intact so no need to reset it */
        return;
    }
    
    NSDictionary *userInfo = [paramNotification userInfo];
    
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    [UIView beginAnimations:@"changeScrollViewContentInset"
                    context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    self.myScrollView.contentInset = UIEdgeInsetsZero;
    
    [UIView commitAnimations];
    
}

- (void) handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    NSDictionary *userInfo = [paramNotification userInfo];
    
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    DLog(@"keyboard frame: %@", keyboardEndRectObject);
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    //  add 44 point for toolbar in accessory view
    
    keyboardEndRect = CGRectMake(keyboardEndRect.origin.x,
                                 keyboardEndRect.origin.y,
                                 keyboardEndRect.size.width,
                                 keyboardEndRect.size.width + 44);
    
    // Convert the frame from window's coordinate system to our view's coordinate system
    keyboardEndRect = [self.view convertRect:keyboardEndRect
                                    fromView:window];
    
    [UIView beginAnimations:@"changeScrollViewContentInset"
                    context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    CGRect intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(window.frame, keyboardEndRect);
    
    CGFloat bottomInset = intersectionOfKeyboardRectAndWindowRect.size.height;
    
    self.myScrollView.contentInset = UIEdgeInsetsMake(0.0f,
                                                     0.0f,
                                                     bottomInset,
                                                     0.0f);
    
    [UIView commitAnimations];
    
}


#pragma mark   actions


- (IBAction)cancelButtonDidTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonDidTap:(id)sender
{
    [self resignFirstResponderForAllSubviewsInMyRecipeView];
    
    if (flagCreatingNewRecipe)
    {
        [[MyRecipeStore defaultStore] addRecipe:self.recipe
                                      withImage:self.myRecipeView.recipeImageView.image];
    }
    else
    {
        // change in recipe image, if need
        [[MyImageStore defaultImageStore] setImage:self.myRecipeView.recipeImageView.image
                                            forKey:self.recipe.imageKey];
    }
    
    [[MyRecipeStore defaultStore] saveChanges];
    
    DLog(@" recipe after editing: %@", self.recipe);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) updateSaveButton
{
    self.saveButton.enabled = self.myRecipeView.recipeNameTextField.text.length > 0 && self.recipe.ingredientLines.count > 0;
}


- (IBAction)didChangeNameRecipeText:(id)sender

{
    //self.birthday.name = self.nameTextField.text;
    self.recipe.recipeName = self.myRecipeView.recipeNameTextField.text;
    [self updateSaveButton];
}

#pragma mark method

- (void) resignFirstResponderForAllSubviewsInMyRecipeView
{
    for (UIView *view in self.myRecipeView.subviews)
    {
        if ([view isFirstResponder])
        {
            [view resignFirstResponder];
            break;
        }
    }

}


#pragma mark
#pragma mark     UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    DLog(@" ");
    // Gets called when user scrolls or drags
    //self.myScrollView.alpha = 0.50f;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     DLog(@" ");
    // Gets called only after scrolling
    //self.myScrollView.alpha = 1.0f;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
     DLog(@" ");
    // Make sure the alpha is reset even if the user is dragging
    //self.myScrollView.alpha = 1.0f;
}


#pragma mark
#pragma mark     UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing: (UITextField *)textField
{
    if (textField == self.myRecipeView.recipeNameTextField)
    {
        //CGPoint origin = self.myRecipeView.recipeNameTextField.frame.origin;
        //self.myScrollView.contentOffset = CGPointMake (0, origin.y - 20);
        //[self.myScrollView setContentOffset:CGPointMake (0, origin.y - 20)animated:YES];
    }
    
    if (textField == self.myRecipeView.recipeNumberOfServingsTextField)
    {
        CGPoint origin = self.myRecipeView.recipeNumberOfServingsTextField.frame.origin;
        [self.myScrollView setContentOffset:CGPointMake (0, origin.y - 10) animated:YES];
    }
    
    if (textField == self.myRecipeView.recipeBitterValueTextField)
    {
        CGPoint origin = self.myRecipeView.recipeBitterValueTextField.frame.origin;
        [self.myScrollView setContentOffset:CGPointMake (0, origin.y - 10) animated:YES];
    }
    
    if (textField == self.myRecipeView.recipeMeatyValueTextField)
    {
        CGPoint origin = self.myRecipeView.recipeMeatyValueTextField.frame.origin;
        [self.myScrollView setContentOffset:CGPointMake (0, origin.y - 10) animated:YES];
    }

    
    //self.myScrollView.contentOfset = CGPointMake ();
    return YES;
}

/*
 - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
 - (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
 - (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
 - (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
 
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
 
 - (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
 - (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
 */

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    DLog(@" ");
    
    NSNumberFormatter * formater = [[NSNumberFormatter alloc] init];
    [formater setNumberStyle:NSNumberFormatterDecimalStyle];
    //[formater setNumberStyle:NSNumberFormatterScientificStyle];
    NSDecimalNumber *resultNumber = nil;
    NSNumber *intNumber = nil;
    float fValue = -1.0;
    NSInteger intValue = 0;
    
    if (textField == self.myRecipeView.recipeRatingTextField)
    {
        intNumber = [formater numberFromString:self.myRecipeView.recipeRatingTextField.text];
        
        //resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipeBitterValueTextField.text];
        DLog(@"My Number : %@",intNumber);
        
        intValue = [intNumber integerValue];
        if (intValue > 5 || intValue < 1)
        {
            // incorrect input
            self.myRecipeView.recipeRatingTextField.text = @"";
            [self.alertAboutIncorrectInputRating show];
        }
        else
        {
            if (!self.recipe.rating)
            {
                self.recipe.rating = @0;
            }
            self.recipe.rating = intNumber;
            self.myRecipeView.recipeRatingTextField.text = [NSString stringWithFormat:@"%d", intValue];
        }
    }

    if (textField == self.myRecipeView.recipeNumberOfServingsTextField)
    {
        intNumber = [formater numberFromString:self.myRecipeView.recipeNumberOfServingsTextField.text];
        intValue = [intNumber integerValue];
        if (intValue < 0)
        {
            // incorrect input
            self.myRecipeView.recipeNumberOfServingsTextField.text = @"";
            //[self.alertAboutIncorrectInputRating show];
        }
        else
        {
            if (!self.recipe.numberOfServings)
            {
                self.recipe.numberOfServings = @3;
            }
            self.recipe.numberOfServings = intNumber;
            self.myRecipeView.recipeNumberOfServingsTextField.text = [NSString stringWithFormat:@"%d", intValue];
        }
    }
    
    if (textField == self.myRecipeView.recipeDurationValueTextField)
    {
        intNumber = [formater numberFromString:self.myRecipeView.recipeDurationValueTextField.text]; // in minutes !!!
        intValue = [intNumber integerValue];
        if (intValue < 0)
        {
            // incorrect input
            self.myRecipeView.recipeDurationValueTextField.text = @"";
            //[self.alertAboutIncorrectInputRating show];
        }
        else
        {
            if (!self.recipe.totalNumberInSeconds)
            {
                self.recipe.totalNumberInSeconds = @0;
            }
            self.recipe.totalNumberInSeconds = [NSNumber numberWithInteger:intValue * 60];
            self.myRecipeView.recipeDurationValueTextField.text = [NSString stringWithFormat:@"%d", intValue];
        }
    }

    
    if (textField == self.myRecipeView.recipeBitterValueTextField)
    {
        //resultNumber = [formater numberFromString:self.myRecipeView.recipeBitterValueTextField.text];
        
        resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipeBitterValueTextField.text];
        DLog(@"My Number : %@",resultNumber);
        
        fValue = [resultNumber floatValue];
        if (fValue > 1.0 || fValue < 0.0)
        {
            // incorrect input
            self.myRecipeView.recipeBitterValueTextField.text = @"";
            [self.alertAboutIncorrectInputFlavers show];
        }
        else
        {
            if (!self.recipe.flavors)
            {
                self.recipe.flavors = [FlavorSet flavorsWithSalty:@0 sour:@0 sweet:@0 bitter:@0 meaty:@0 piquant:@0];
            }
            self.recipe.flavors.bitter = resultNumber;
            self.myRecipeView.recipeBitterValueTextField.text = [NSString stringWithFormat:@"%.5g", fValue];
            //self.sweetValueLabel.text = [NSString stringWithFormat:@"%.5f", [self.recipe.flavors.sweet floatValue]];
        }
    }
    
    if (textField == self.myRecipeView.recipeMeatyValueTextField)
    {
        //resultNumber = [formater numberFromString:self.myRecipeView.recipeBitterValueTextField.text];
        
        resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipeMeatyValueTextField.text];
        fValue = [resultNumber floatValue];
        if (fValue > 1.0 || fValue < 0.0)
        {
            // incorrect input
            self.myRecipeView.recipeMeatyValueTextField.text = @"";
            [self.alertAboutIncorrectInputFlavers show];
        }
        else
        {
            if (!self.recipe.flavors)
            {
                self.recipe.flavors = [FlavorSet flavorsWithSalty:@0 sour:@0 sweet:@0 bitter:@0 meaty:@0 piquant:@0];
            }
            self.recipe.flavors.meaty = resultNumber;
            self.myRecipeView.recipeMeatyValueTextField.text = [NSString stringWithFormat:@"%.5g", fValue];
        }
    }
    
    if (textField == self.myRecipeView.recipePiquantValueTextField)
    {
        //resultNumber = [formater numberFromString:self.myRecipeView.recipeBitterValueTextField.text];
        
        resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipePiquantValueTextField.text];
        fValue = [resultNumber floatValue];
        if (fValue > 1.0 || fValue < 0.0)
        {
            // incorrect input
            self.myRecipeView.recipePiquantValueTextField.text = @"";
            [self.alertAboutIncorrectInputFlavers show];
        }
        else
        {
            if (!self.recipe.flavors)
            {
                self.recipe.flavors = [FlavorSet flavorsWithSalty:@0 sour:@0 sweet:@0 bitter:@0 meaty:@0 piquant:@0];
            }
            self.recipe.flavors.piquant = resultNumber;
            self.myRecipeView.recipePiquantValueTextField.text = [NSString stringWithFormat:@"%.5g", fValue];
        }
    }
    
    if (textField == self.myRecipeView.recipeSaltyValueTextField)
    {
        resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipeSaltyValueTextField.text];
        fValue = [resultNumber floatValue];
        if (fValue > 1.0 || fValue < 0.0)
        {
            // incorrect input
            self.myRecipeView.recipeSaltyValueTextField.text = @"";
            [self.alertAboutIncorrectInputFlavers show];
        }
        else
        {
            if (!self.recipe.flavors)
            {
                self.recipe.flavors = [FlavorSet flavorsWithSalty:@0 sour:@0 sweet:@0 bitter:@0 meaty:@0 piquant:@0];
            }
            self.recipe.flavors.salty = resultNumber;
            self.myRecipeView.recipeSaltyValueTextField.text = [NSString stringWithFormat:@"%.5g", fValue];
        }
    }
    
    if (textField == self.myRecipeView.recipeSourValueTextField)
    {
        resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipeSourValueTextField.text];
        fValue = [resultNumber floatValue];
        if (fValue > 1.0 || fValue < 0.0)
        {
            // incorrect input
            self.myRecipeView.recipeSaltyValueTextField.text = @"";
            [self.alertAboutIncorrectInputFlavers show];
        }
        else
        {
            if (!self.recipe.flavors)
            {
                self.recipe.flavors = [FlavorSet flavorsWithSalty:@0 sour:@0 sweet:@0 bitter:@0 meaty:@0 piquant:@0];
            }
            self.recipe.flavors.sour = resultNumber;
            self.myRecipeView.recipeSourValueTextField.text = [NSString stringWithFormat:@"%.5g", fValue];
        }
    }

    if (textField == self.myRecipeView.recipeSweetValueTextField)
    {
        resultNumber = [NSDecimalNumber decimalNumberWithString: self.myRecipeView.recipeSweetValueTextField.text];
        fValue = [resultNumber floatValue];
        if (fValue > 1.0 || fValue < 0.0)
        {
            // incorrect input
            self.myRecipeView.recipeSweetValueTextField.text = @"";
            [self.alertAboutIncorrectInputFlavers show];
        }
        else
        {
            if (!self.recipe.flavors)
            {
                self.recipe.flavors = [FlavorSet flavorsWithSalty:@0 sour:@0 sweet:@0 bitter:@0 meaty:@0 piquant:@0];
            }
            self.recipe.flavors.sweet = resultNumber;
            self.myRecipeView.recipeSweetValueTextField.text = [NSString stringWithFormat:@"%.5g", fValue];
        }
    }

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DLog(@" text for search: %@", textField.text);
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark    UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == self.myRecipeView.recipeFullDescriptionTextView)
    {
        CGPoint origin = self.myRecipeView.recipeFullDescriptionTextView.frame.origin;
        //CGRect frame = self.myRecipeView.recipeNumberOfServingsTextField.frame;
        //self.myScrollView.contentOffset = CGPointMake (0, origin.y - 20);
        [self.myScrollView setContentOffset:CGPointMake (0, origin.y - 10) animated:YES];
    }
    
    if (textView == self.myRecipeView.recipeIngredientsLinesTextView)
    {
        CGPoint origin = self.myRecipeView.recipeIngredientsLinesTextView.frame.origin;
        //CGRect frame = self.myRecipeView.recipeNumberOfServingsTextField.frame;
        //self.myScrollView.contentOffset = CGPointMake (0, origin.y - 20);
        [self.myScrollView setContentOffset:CGPointMake (0, origin.y - 10) animated:YES];
    }
    
    return YES;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

//- (void)textViewDidBeginEditing:(UITextView *)textView;

- (void)textViewDidEndEditing:(UITextView *)textView
{
    DLog(@" ");
    
    if(textView == self.myRecipeView.recipeIngredientsLinesTextView)
    {
        // parse from string to array...
        NSString *stringToParse = self.myRecipeView.recipeIngredientsLinesTextView.text;
        NSMutableArray *arrayIngredient = [NSMutableArray arrayWithCapacity:0];
        NSString *substring = nil;
        NSRange rangeSubstring;
        do
        {
            substring = [self getSubstringFromString:stringToParse
                                    betweenSeparator:@"-"
                                        andSeparator:@",\n"];
            DLog(@" string to parse: %@ ", stringToParse);
            if (substring)
            {
                [arrayIngredient addObject:substring];
            }
            else
            {
                if (arrayIngredient.count > 0)
                {
                    // cut from the text of the dash symbol
                    [arrayIngredient addObject:[stringToParse substringFromIndex:1]];
                }
                break;
            }
            rangeSubstring = [stringToParse rangeOfString:substring];
            stringToParse = [stringToParse substringFromIndex:rangeSubstring.location + rangeSubstring.length + 2];
        } while (substring);
    
        if (arrayIngredient.count > 0)
        {
            self.recipe.ingredientLines = [arrayIngredient copy];
        }
        else
        {
            // incorrect input
            self.myRecipeView.recipeIngredientsLinesTextView.text = @"";
            [self.alertAboutIncorrectInputIngredientLines show];
        }
    }
    
    if(textView == self.myRecipeView.recipeFullDescriptionTextView)
    {
        self.recipe.recipeFullDescription = self.myRecipeView.recipeFullDescriptionTextView.text;
    }

    
    [self updateSaveButton];
}


- (NSString *)getSubstringFromString: (NSString *)fullString
                    betweenSeparator: (NSString *)separator1
                        andSeparator: (NSString *) separator2
{
    NSString *result = nil;
    NSRange firstSeparatorRange = [fullString rangeOfString:separator1];
    NSRange secondSeparatorRange = [fullString rangeOfString:separator2];
    
    //  check for true value ...
    if (firstSeparatorRange.location == NSNotFound || secondSeparatorRange.location == NSNotFound)
    {
        return nil;
    }
    
    if (!(firstSeparatorRange.location != NSNotFound && secondSeparatorRange.location != NSNotFound))
    {
        return nil;
    }
    
    NSInteger locationResult = firstSeparatorRange.location + firstSeparatorRange.length;
    NSInteger lengthResult = secondSeparatorRange.location - locationResult;
    if (lengthResult <= 0)
    {
        return nil;
    }
    
    NSRange resultRange = NSMakeRange (locationResult, lengthResult);
    
    result = [fullString substringWithRange:resultRange];
    
    DLog(@" result string: %@", result);
    
    return result;
}


#pragma mark  implement make photo of recipe

- (IBAction)buttonPicPhotoDidTap:(id)sender

{
    DLog(@"Did Tap Photo! ");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        DLog(@"No camera detected!");
        [self pickPhoto];
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take a Photo",@"Pick from Photo Library", nil];
    [actionSheet showInView:self.view];
}

-(UIImagePickerController *) imagePicker
{
    if (_imagePicker == nil)
    {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

-(void) takePhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:self.imagePicker
                                            animated:YES
                                          completion:nil];
}

-(void) pickPhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (self.imagePicker == nil)
    {
        DLog(@"It's nil!");
    }
    else
    {
        DLog(@"Not nil!");
    }
    
    [self.navigationController presentViewController:self.imagePicker
                                            animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGFloat side = 90.f;
    side *= [[UIScreen mainScreen] scale];
    //  make thumbnail image
    UIImage *thumbnail = [image createThumbnailToFillSize:CGSizeMake(side, side)];
    self.myRecipeView.recipeImageView.image = thumbnail;
    self.imageData = UIImageJPEGRepresentation (thumbnail,1.f);
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    switch (buttonIndex)
    {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self pickPhoto];
            break;
    }
}




@end
