//
//  RecipeStore.m
//  recipes
//
//  Created by Hanna Kondratyuk on 12/19/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "RecipeStore.h"
#import "Recipe.h"
#import "FlavorSet.h"
#import "ImageStore.h"

static RecipeStore *defaultStore = nil;

@implementation RecipeStore

+ (RecipeStore *) defaultStore
{
    if (!defaultStore)
    {
        // Create the singleton
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

// Prevent creation of additional instances - override

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    // If we already have an instance of PossessionStore...
    if (defaultStore)
    {
        // Return the old one
        return defaultStore;
    }
    
    self = [super init];
    return self;
}



- (NSArray *)allRecipes
{
    // This ensures allPossessions is created
    [self fetchRecipesIfNecessary];
    
    return allRecipes;
}

- (Recipe *)createRecipeWithId: (NSString *) recipeId
                    recipeName: (NSString *) recipeName
                        rating: (NSNumber *) rating
                 totalDuration: (NSNumber *) theDuration
                   ingredients: (NSArray *) ingredients
                       flavors: (FlavorSet *) flavorSet
                      imageURL: (NSString *) imageURL
                     imageSize: (NSString *) imageSize
{
    // This ensures allPossessions is created
    [self fetchRecipesIfNecessary];
    
    Recipe *recipe = [Recipe recipeWithRecipeId:recipeId
                                     recipeName:recipeName
                                         rating:rating
                                  totalDuration:theDuration
                                    ingredients:ingredients
                                        flavors:flavorSet
                                       imageUrl:imageURL
                                      imageSize:imageSize];
    
    [allRecipes addObject:recipe];
    
    return recipe;
}

- (void) addRecipe: (Recipe *) theRecipe
         withImage: (UIImage *) theRecipeImage
{
    NSString *key = [theRecipe imageKey];
    [[ImageStore defaultImageStore] setImage:theRecipeImage forKey:key];
    
    //  add check for recipe with the same name
    BOOL flagOfExistingRecipeWithTheSameName = NO;
    
    for (Recipe *recipe in allRecipes)
    {
        if ([recipe.recipeName isEqualToString:theRecipe.recipeName])
        {
            flagOfExistingRecipeWithTheSameName = YES;
            break;
        }
    }
    
    if (flagOfExistingRecipeWithTheSameName)
    {
        
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //DLog(@"Current thread = %@", [NSThread currentThread]);
        dispatch_async(mainQueue, ^(void)
                       {
                           UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:nil
                                                                             message:@"Recipe with the same name already exist in local data"
                                                                            delegate:nil
                                                                   cancelButtonTitle:nil
                                                                   otherButtonTitles:@"OK", nil];
                           [alert show];

                       });
        return;
    }
    
    [allRecipes addObject:theRecipe];

}


- (void)removeRecipe:( Recipe *) recipe
{
    NSString *key = [recipe imageKey];
    [[ImageStore defaultImageStore] deleteImageForKey:key];
    
    [allRecipes removeObjectIdenticalTo: recipe];
}

- (void)moveRecipeAtIndex:(int)from
                  toIndex:(int)to
{
    if (from == to)
    {
        return;
    }
    // Get pointer to object being moved
    Recipe *recipe = [allRecipes objectAtIndex:from];
    
    // Remove p from array
    [allRecipes removeObjectAtIndex:from];
    
    // Insert p in array at new location
    [allRecipes insertObject:recipe atIndex: to];
}

- (NSString *) recipesArchivePath
{
    // The returned path will be Sandbox/Documents/possessions.data
    // Both the saving and loading methods will call this method to get the same path,
    // preventing a typo in the path name of either method
    
    return pathInDocumentDirectory(@"recipes.data");
}

- (BOOL)saveChanges
{
    // returns success or failure
    return [NSKeyedArchiver archiveRootObject:allRecipes
                                       toFile:[self recipesArchivePath]];
}

- (void)fetchRecipesIfNecessary
{
    // If we don't currently have an allPossessions array, try to read one from disk
    if (!allRecipes)
    {
        NSString *path = [self recipesArchivePath];
        allRecipes = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    
    // If we tried to read one from disk but does not exist, then create a new one
    if (!allRecipes)
    {
        allRecipes = [[NSMutableArray alloc] init];
    }
}

@end
