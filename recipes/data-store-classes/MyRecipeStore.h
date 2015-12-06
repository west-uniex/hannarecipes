//
//  MyRecipeStore.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recipe;

@interface MyRecipeStore : NSObject

{
    NSMutableArray *allRecipes;
}

+ (MyRecipeStore *) defaultStore;

- (NSArray *) allRecipes;

- (void) addRecipe: (Recipe *) theRecipe
         withImage: (UIImage *) theRecipeImage;
- (void) removeRecipe:(Recipe *) theRecipe;
- (void) moveRecipeAtIndex:(int)from
                   toIndex:(int)to;
- (NSString *)recipesArchivePath;
- (BOOL)saveChanges;
- (void)fetchRecipesIfNecessary;

@end
