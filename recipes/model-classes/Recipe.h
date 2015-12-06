//
//  Recipe.h
//  recipes
//
//  Created by Anna Kondratyuk on 11/25/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlavorSet;

@interface Recipe : NSObject <NSCoding>

@property (nonatomic, strong) NSString * recipeId;
@property (nonatomic, strong) NSString * recipeName;
@property (nonatomic, strong) NSNumber * rating;
@property (nonatomic, strong) NSNumber * totalNumberInSeconds;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) FlavorSet *flavors;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *imageLenthAndWidth;
// full part of recipe
@property (nonatomic, strong) NSArray *ingredientLines;
@property (nonatomic, strong) NSNumber *numberOfServings;
@property (nonatomic, strong) NSArray *nutritionEstimates;
@property (nonatomic, strong) NSString *sourceRecipeUrl;
//
@property (nonatomic, strong, readonly) NSString *imageKey;  // may be copy attribute for all properties ?

// for created by me recipe

@property (nonatomic, strong) NSString *recipeFullDescription;


+ (Recipe *) recipeWithRecipeId: (NSString *) recipeId
                     recipeName: (NSString *) recipeName
                         rating: (NSNumber *) rating
                  totalDuration: (NSNumber *) totalNumberInSecond
                    ingredients: (NSArray *) ingredients
                        flavors: (FlavorSet *) flavors
                       imageUrl: (NSString *) imageUrl
                      imageSize: (NSString *) imageLenthAndWidth ;

@end
/*
{
    "attributes": { "course": [  "Soups"], "cuisine": [ "Italian" ] },
    "flavors": { "salty": 0.6666666666666666,  "sour": 0.8333333333333334, "sweet": 0.6666666666666666, "bitter": 0.5, "meaty": 0.16666666666666666, "piquant": 0.5 },
    "rating": 4.6,
    "id": "Vegetarian-Cabbage-Soup-Recipezaar",
    "smallImageUrls": [],
    "sourceDisplayName": "Food.com",
    "totalTimeInSeconds": 4500,
    "ingredients": [ "garlic cloves", "ground pepper",    "diced tomatoes", "celery", "tomato juice", "salt", "cabbage", "bell peppers", "oregano", "carrots", "basil", "vegetable broth",
                    "chili pepper flakes", "green beans", "onions", "onion soup mix"],
    "recipeName": "Vegetarian Cabbage Soup"
}
 
 
 {
 attributes =             { };
 flavors =             { bitter = "0.1666666666666667"; meaty = "0.1666666666666667"; piquant = "0.3333333333333333"; salty = "0.1666666666666667"; sour = "0.3333333333333333"; sweet = "0.6666666666666666"; };
 id = "Chicken-Fritz-466963";
 imageUrlsBySize = {  90 = "http://lh3.ggpht.com/UxAXD4WzOGsSRbRH1MGq8BiiDJn-CQ95khtRooSe8vQL9ISciXr1vBxie2YCsrzdiwVd-Kf9IQ7YpGtk_zmBf1o=s90-c"; };
 ingredients =             ( "safflower oil",  onion,  "kosher salt", "freshly ground pepper", "cooked chicken", "sweet paprika" );
 rating = 5;
 recipeName = "Chicken Fritz";
 smallImageUrls = ( "http://lh4.ggpht.com/CUG6ENZ5ZaOi-gbcTkFZ9A123PAzek15qTk53pHTVPnC1PH92O-ayqt4PDPgp_OycTTLVgU4m8e-Kv7daA7lcxs=s90"  );
 sourceDisplayName = "Big Girls Small Kitchen";
 totalTimeInSeconds = 3000;
 },

 
*/