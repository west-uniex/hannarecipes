//
//  Recipe.m
//  recipes
//
//  Created by Anna Kondratyuk on 11/25/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

/*
 // Get picked image from info dictionary
 UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
 
 
 
 // Store image in the ImageStore with this key
 [[ImageStore defaultImageStore] setImage:image
 forKey:[possession imageKey]];
 
*/


- (id)init
{
    self = [super init];
    if (self)
    {
        // Create a CFUUID object - it knows how to create unique identifier strings
        CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
        
        // Create a string from unique identifier
        CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
        
        // Use that unique ID to set our recipe imageKey
        _imageKey = (__bridge NSString *)newUniqueIDString;
        
        // We used "Create" in the functions to make objects, we need to release them
        CFRelease(newUniqueIDString);
        CFRelease(newUniqueID);
        
    }
    return self;
}



+ (Recipe *) recipeWithRecipeId: (NSString *) recipeId
                     recipeName: (NSString *) recipeName
                         rating: (NSNumber *) rating
                  totalDuration: (NSNumber *) totalNumberInSecond
                    ingredients: (NSArray *) ingredients
                        flavors: (FlavorSet *) flavors
                       imageUrl: (NSString *) imageUrl
                      imageSize: (NSString *) imageLenthAndWidth
{
    Recipe *newRecipe = [[Recipe alloc] init];
    
    newRecipe.recipeId = recipeId;
    newRecipe.recipeName = recipeName;
    newRecipe.rating = rating;
    newRecipe.totalNumberInSeconds = totalNumberInSecond;
    newRecipe.ingredients = ingredients;
    newRecipe.flavors = flavors;
    newRecipe.imageUrl = imageUrl;
    newRecipe.imageLenthAndWidth = imageLenthAndWidth;
   
    return newRecipe;
}


-(NSString *) description
{
    [super description];
    
    NSString *descriptionString = nil;
    
    descriptionString = [NSString stringWithFormat:@"\n<%@> recipe id: %@  recipeName: %@ total Duration: %@  ingredients: %@ flavors: %@  image URL: %@ image size: %@ ingredient lines: %@ number of servings = %@ nutritions estimates: %@ source Recipe Url: %@\nimage key: %@ \n full recipe description: %@", NSStringFromClass([self class]), self.recipeId, self.recipeName, self.totalNumberInSeconds, self.ingredients, self.flavors, self.imageUrl, self.imageLenthAndWidth, self.ingredientLines, self.numberOfServings, self.nutritionEstimates, self.sourceRecipeUrl, self.imageKey, self.recipeFullDescription];
    
    
    return descriptionString;
    
}

#pragma mark
#pragma mark    conforming NSCoding protocol

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self)
    {
        // For each instance variable that is archived, we decode it,
        // and pass it to our setters. (Where it is retained)
        [self setRecipeId:[decoder decodeObjectForKey:@"recipeId"]];
        [self setRecipeName:[decoder decodeObjectForKey:@"recipeName"]];
        _imageKey = [decoder decodeObjectForKey:@"imageKey"];
        
        [self setRating:[decoder decodeObjectForKey:@"rating"]];
        [self setTotalNumberInSeconds:[decoder decodeObjectForKey:@"totalNumberInSeconds"]];
        [self setIngredients:[decoder decodeObjectForKey:@"ingredients"]];
        [self setFlavors:[decoder decodeObjectForKey:@"flavors"]];
        [self setImageUrl:[decoder decodeObjectForKey:@"imageURL"]];
        [self setImageLenthAndWidth:[decoder decodeObjectForKey:@"imageLenthAndWidth"]];
        //  part of full recipe
        [self setIngredientLines:[decoder decodeObjectForKey:@"ingredientLines"]];
        [self setNumberOfServings:[decoder decodeObjectForKey:@"numberOfServings"]];
        [self setNutritionEstimates:[decoder decodeObjectForKey:@"nutritionEstimates"]];
        [self setSourceRecipeUrl:[decoder decodeObjectForKey:@"sourceRecipeUrl"]];
        //  part for mine recipes
        [self setRecipeFullDescription:[decoder decodeObjectForKey:@"recipeFullDescription"]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    // For each instance variable, archive it under its variable name
    // These objects will also be sent encodeWithCoder:
    [encoder encodeObject:_recipeId forKey:@"recipeId"];
    [encoder encodeObject:_recipeName forKey:@"recipeName"];
    [encoder encodeObject:_imageKey forKey:@"imageKey"];
    [encoder encodeObject:_rating forKey:@"rating"];
    [encoder encodeObject:_totalNumberInSeconds forKey:@"totalNumberInSeconds"];
    [encoder encodeObject:_ingredients forKey:@"ingredients"];
    [encoder encodeObject:_flavors forKey:@"flavors"];
    [encoder encodeObject:_imageUrl forKey:@"imageURL"];
    [encoder encodeObject:_imageLenthAndWidth forKey:@"imageLenthAndWidth"];
    //  part full recipe
    [encoder encodeObject:_ingredientLines forKey:@"ingredientLines"];
    [encoder encodeObject:_numberOfServings forKey:@"numberOfServings"];
    [encoder encodeObject:_nutritionEstimates forKey:@"nutritionEstimates"];
    [encoder encodeObject:_sourceRecipeUrl forKey:@"sourceRecipeUrl"];
    // part for only for mine recipes
    [encoder encodeObject:_recipeFullDescription forKey:@"recipeFullDescription"];
}

@end
