//
//  AllIngredientsNavigationController.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 03.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "AllIngredientsNavigationController.h"
#import "AllIngredientsTableViewController.h"

@interface AllIngredientsNavigationController ()

@end

@implementation AllIngredientsNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    DLog(@" %@", self.allIngredients);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
