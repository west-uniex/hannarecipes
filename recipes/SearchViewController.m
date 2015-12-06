//
//  SearchViewController.m
//  recipes
//
//  Created by Anna Kondratyuk on 10/30/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "SearchViewController.h"
#import "SimpleRecipeCell.h"

@interface SearchViewController ()
{
    UIToolbar *tb;
}

@property (strong, nonatomic) NSString *searchBarText;

@end

@implementation SearchViewController

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
	[self.searchBar setText:@""];
}

- (void) leaveKeyboardMode
{
	[self.searchBar resignFirstResponder];
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adjustForKeyboard:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
     self.searchBar.inputAccessoryView = [self accessoryView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark  UISearchBarDelegate protocol conforms

/*
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar;                   // called when bookmark button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;                    // called when cancel button pressed
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2); // called when search results button pressed

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0);
*/

/*
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar

{
    NSLog(@"WE ARE HERE  !!!! ");

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"WE ARE HERE  !!!! %@", NSStringFromSelector(_cmd));

}
;

 */

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // called when text starts editing
    DLog(@" ");
    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    [aSearchBar resignFirstResponder];
    [self searchString: aSearchBar.text];
    [self viewWillAppear:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar
{
    //[aSearchBar resignFirstResponder];
    self.searchBar.text = @"";
    self.searchBarText = nil;
    
}

- (void)searchBar:(UISearchBar *)aSearchBar
    textDidChange:(NSString *)aSearchText
{
    [self searchString: aSearchBar.text];
    [self viewWillAppear:YES];
    
}




#pragma mark 
#pragma mark  internal methods

-(void)searchString:(NSString*)s
{
    self.searchBarText = s;
    
    //[self setFrameMyTableView];
    //[self.myTableView reloadData];
    
}

@end




@interface TestBedViewController : UIViewController
{
	UITextView *tv;
	UIToolbar *tb;
}
@end

@implementation TestBedViewController

CGRect CGRectShrinkHeight(CGRect rect, CGFloat amount)
{
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - amount);
}

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
	[tv setText:@""];
}

- (void) leaveKeyboardMode
{
	[tv resignFirstResponder];
}

- (void) keyboardWillHide: (NSNotification *) notification
{
	// return to previous text view size
	tv.frame = self.view.bounds;
}

- (void) adjustForKeyboard: (NSNotification *) notification
{
    
	// Retrieve the keyboard bounds via the notification userInfo dictionary
	CGRect kbounds;
	NSDictionary *userInfo = [notification userInfo];
	[(NSValue *)[userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] getValue:&kbounds];
    
	// Shrink the textview frame -- comment this out to see the default behavior
    CGRect destRect = CGRectShrinkHeight(self.view.bounds, kbounds.size.height);
	tv.frame = destRect;
}

- (void) loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
    
    tv = [[UITextView alloc] initWithFrame:self.view.bounds];
	tv.font = [UIFont fontWithName:@"Georgia" size:(IS_IPAD) ? 24.0f : 14.0f];
    tv.inputAccessoryView = [self accessoryView];
    
	[self.view addSubview:tv];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustForKeyboard:) name:UIKeyboardDidShowNotification object:nil];
}

@end
