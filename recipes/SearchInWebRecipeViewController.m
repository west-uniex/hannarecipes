//
//  SearchInWebRecipeViewController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 13.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "SearchInWebRecipeViewController.h"
#import "SearchTableViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "Recipe.h"
#import "RecipeStore.h"

@interface SearchInWebRecipeViewController ()
{
    UIToolbar *tb;
}

@end

@implementation SearchInWebRecipeViewController

/*

CGSize size = CGSizeMake(280, 40);

// Shadow
CALayer *shadowLayer = [CALayer new];
shadowLayer.frame = CGRectMake(20,100,size.width,size.height);
shadowLayer.cornerRadius = 10;

shadowLayer.backgroundColor = [UIColor clearColor].CGColor;
shadowLayer.shadowColor = [UIColor blackColor].CGColor;
shadowLayer.shadowOpacity = 0.6;
shadowLayer.shadowOffset = CGSizeMake(0,0);
shadowLayer.shadowRadius = 3;

// Label
UILabel *label = [UILabel new];
label.text = @"Hello World";
label.textAlignment = UITextAlignmentCenter;
label.frame = CGRectMake(0, 0, size.width, size.height);
label.backgroundColor = [UIColor clearColor];
label.layer.cornerRadius = 10;
[label.layer setMasksToBounds:YES];
//  customLabel.backgroundColor = [UIColor whiteColor];
label.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"options.png"]];

// Add the Label to the shawdow layer
[shadowLayer addSublayer:label.layer];

[self.view.layer addSublayer:shadowLayer];

*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	{
        self.activityYummlyServiceIndicator.hidden = YES;
        self.showResultOfRequestToYummlyButton.hidden = YES;
        self.reloadButton.hidden = YES;
    }
    // set up web search for yummly service
    HTTP_Client *client = [HTTP_Client sharedHTTP_Client];
    client.delegate = self;
    
    //  prepare for add toolbar to keyboard view
    self.enterNameRecipeTextField.inputAccessoryView = [self accessoryView];
    
    // make round borders
    _showResultOfRequestToYummlyButton.layer.cornerRadius = 5;
    _reloadButton.layer.cornerRadius = 5;
    
    //
    self.yummlyImageView.layer.borderWidth = 5;
    self.yummlyImageView.layer.borderColor = [UIColor yellowColor].CGColor;
    //self.yummlyImageView.layer.cornerRadius = 10;
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
	[self.enterNameRecipeTextField setText:@""];
}

- (void) leaveKeyboardMode
{
	[self.enterNameRecipeTextField resignFirstResponder];
}


#pragma mark
#pragma mark   handle keyboard notifications

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
    DLog(@" %@", [userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"]);
}


#pragma mark
#pragma mark  handling the keyboard notification

- (void) handleKeyboardWillHide:(NSNotification *)paramNotification
{
    /*
    if (UIEdgeInsetsEqualToEdgeInsets(self.myScrollView.contentInset, UIEdgeInsetsZero))
    {
        // Our table view's content inset is intact so no need to reset it
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
    
    [UIView beginAnimations:@"changeTableViewContentInset"
                    context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    self.myScrollView.contentInset = UIEdgeInsetsZero;
    
    [UIView commitAnimations];
    */
}

- (void) handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    NSDictionary *userInfo = [paramNotification userInfo];
    
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    DLog(@" keyboard frame: %@", keyboardEndRectObject);
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    // Convert the frame from window's coordinate system to our view's coordinate system
    keyboardEndRect = [self.view convertRect:keyboardEndRect
                                    fromView:window];
    /*
    [UIView beginAnimations:@"changeTableViewContentInset"
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
     */
    
}

#pragma mark
#pragma mark   IB actions

- (IBAction)showResultOfRequestToYummlyButtonDidTap:(id)sender
{
    DLog(@" ");
}

- (IBAction)reloadButtonDidTap:(id)sender
{
    {
        self.activityYummlyServiceIndicator.hidden = YES;
        self.showResultOfRequestToYummlyButton.hidden = YES;
        self.reloadButton.hidden = YES;
    }
}


#pragma mark
#pragma mark     UITextFieldDelegate
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
    
    if (textField.text.length == 0)
    {
        return YES;
    }
    
    HTTP_Client *client = [HTTP_Client sharedHTTP_Client];
    //client.delegate = self;
    [client seachRecipesWithName: textField.text];
    
    self.activityYummlyServiceIndicator.hidden = YES;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DLog(@" text for search: %@", textField.text);
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark  conform HTTP_ClientDelegate

- (void) httpClient: (HTTP_Client *) client
            request: (NSURLRequest *) request
      doneWithError: (NSError *) error
{
    DLog(@" ");
}


- (void) httpClient: (HTTP_Client *) client
        haveRecipes: (NSArray *) recipes
    forNameOfRecipe: (NSString *) recipeName

{
    DLog(@" recipes arrives ...: %@", recipes);
    //self.recipesArray = recipes;
    _recipesArray = recipes;
    
    /*
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    DLog(@"Current thread = %@", [NSThread currentThread]);
    dispatch_async(mainQueue, ^(void)
                   {
                       DLog(@"Main thread = %@", [NSThread mainThread]);
                       self.activityYummlyServiceIndicator.hidden = YES;
                       self.showResultOfRequestToYummlyButton.hidden = NO;
                       self.reloadButton.hidden = NO;
                   });
    
    */
    
}


- (void) httpClient: (HTTP_Client *) client
    ingredientLines: (NSArray *) ingredientLines
   numberOfServings: (NSNumber *)numberOfServings
 nutritionEstimates: (NSArray *)nutritionEstimates
    sourceRecipeUrl: (NSString *)sourceRecipeUrl
        forRecipeId: (NSString *) recipeId

{
    DLog(@"recipe ID: %@  ingredient lines: %@", recipeId ,ingredientLines);
    
    Recipe *recipe = nil;
    for (NSUInteger i = 0; i <[_recipesArray count]; i++)
    {
        recipe = [_recipesArray objectAtIndex:i];
        if ([recipe.recipeId isEqualToString:recipeId])
        {
            // we find needed recipe
            recipe.ingredientLines = ingredientLines;
            recipe.nutritionEstimates = nutritionEstimates;
            recipe.numberOfServings = numberOfServings;
            recipe.sourceRecipeUrl = sourceRecipeUrl;
            DLog(@"recipe updated to full form: \n%@", recipe);
        }
    }
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    DLog(@"Current thread = %@", [NSThread currentThread]);
    dispatch_async(mainQueue, ^(void)
                   {
                       DLog(@"Main thread = %@", [NSThread mainThread]);
                       self.activityYummlyServiceIndicator.hidden = YES;
                       self.showResultOfRequestToYummlyButton.hidden = NO;
                       self.reloadButton.hidden = NO;
                   });
    
}



#pragma mark
#pragma mark  segues

- (void) displayTextIsRequired
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:@"Please enter some text in the text field"
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier
                                   sender:(id)sender
{
    /* Check if there is some text and if there isn't, display a message
     to the user and prevent her from going to the next screen */
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToSearchRecipe"])
    {
        SearchTableViewController *nextController = segue.destinationViewController;
        [nextController setRecipesArray:self.recipesArray];
    }
}


@end
