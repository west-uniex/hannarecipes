//
//  RecipeStore.h
//  recipes
//
//  Created by Hanna Kondratyuk on 12/19/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recipe;

@interface RecipeStore : NSObject

{
    NSMutableArray *allRecipes;
}

+ (RecipeStore *) defaultStore;

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

