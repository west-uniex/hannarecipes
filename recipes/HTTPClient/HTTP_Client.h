//
//  HTTP_Client.h
//  recipes
//
//  
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTP_ClientDelegate;


@interface HTTP_Client : NSObject

@property (nonatomic, weak) id<HTTP_ClientDelegate> delegate;

+(HTTP_Client *) sharedHTTP_Client;

-(void) seachRecipesWithName: (NSString *) nameOfRecipe;
-(void) loadFullRecipeWithID: (NSString *) recipeID;

@end


@protocol HTTP_ClientDelegate <NSObject>

- (void) httpClient: (HTTP_Client *) client
            request: (NSURLRequest *) request
      doneWithError: (NSError *) error;

@optional
- (void) httpClient: (HTTP_Client *) client
        haveRecipes: (NSArray *) recipes
    forNameOfRecipe: (NSString *) recipeName;

- (void) httpClient: (HTTP_Client *) client
    ingredientLines: (NSArray *) ingredientLines
   numberOfServings: (NSNumber *)numberOfServings
 nutritionEstimates: (NSArray *)nutritionEstimates
    sourceRecipeUrl: (NSString *)sourceRecipeUrl 
        forRecipeId: (NSString *) recipeId;




@end


/*         short answer
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


#pragma mark
#pragma mark   EXAMPLE of responce for soup


/*
 
 2013-11-28 15:51:50.936 TestYummlyApp[1062:1303] __38-[ViewController getRecipeFromServer:]_block_invoke [Line 92]
 server return in JSON ARRAY OF RECIPES: {
 attribution =     {
 html = "Recipe search powered by <a href='http://www.yummly.com/recipes'><img alt='Yummly' src='http://static.yummly.com/api-logo.png'/></a>";
 logo = "http://static.yummly.com/api-logo.png";
 text = "Recipe search powered by Yummly";
 url = "http://www.yummly.com/recipes/"; };
 criteria =     { allowedIngredients = "<null>"; excludedIngredients = "<null>"; terms = "<null>"; };
 facetCounts =     { };
 matches =     
 (
 
 
 {
 attributes =             {
 };
 flavors =             {
 bitter = "0.1666666666666667";
 meaty = "0.1666666666666667";
 piquant = "0.3333333333333333";
 salty = "0.1666666666666667";
 sour = "0.3333333333333333";
 sweet = "0.6666666666666666";
 };
 id = "Chicken-Fritz-466963";
 imageUrlsBySize =             {
 90 = "http://lh3.ggpht.com/UxAXD4WzOGsSRbRH1MGq8BiiDJn-CQ95khtRooSe8vQL9ISciXr1vBxie2YCsrzdiwVd-Kf9IQ7YpGtk_zmBf1o=s90-c";
 };
 ingredients =             (
 "safflower oil",
 onion,
 "kosher salt",
 "freshly ground pepper",
 "cooked chicken",
 "sweet paprika"
 );
 rating = 5;
 recipeName = "Chicken Fritz";
 smallImageUrls =             (
 "http://lh4.ggpht.com/CUG6ENZ5ZaOi-gbcTkFZ9A123PAzek15qTk53pHTVPnC1PH92O-ayqt4PDPgp_OycTTLVgU4m8e-Kv7daA7lcxs=s90"
 );
 sourceDisplayName = "Big Girls Small Kitchen";
 totalTimeInSeconds = 3000;
 },
 
 
 
 
 
 {
 attributes =             {
 course =                 (
 Appetizers,
 Desserts
 );
 cuisine =                 (
 american
 );
 };
 
 flavors =             {
 bitter = "0.1666666666666667";
 meaty = "0.1666666666666667";
 salty = "0.1666666666666667";
 sweet = 1;
 };
 id = "Sugared-Pecans-My-Recipes";
 imageUrlsBySize =             {
 90 = "http://lh5.ggpht.com/8PTJ_-GWIVfHOdRttuVX7kPxLJY84D-klyu-a4EL9cYkGJXMwC2HMMMhBMD6YLNJYFQ4etxWSMCRzKkhGWvI=s90-c";
 };
 ingredients =             (
 "light brown sugar",
 "egg whites",
 "pecan halv",
 "granulated sugar"
 );
 rating = 4;
 recipeName = "Sugared Pecans";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Sugared-Pecans-My-Recipes-115244.s.png"
 );
 sourceDisplayName = MyRecipes;
 totalTimeInSeconds = 5100;
 },
 {
 attributes =             {
 };
 flavors =             {
 bitter = "0.1666666666666667";
 meaty = "0.3333333333333333";
 salty = "0.5";
 sour = "0.3333333333333333";
 sweet = "0.3333333333333333";
 };
 id = "Roasted-Sweet-Potatoes-and-Red-Onions-with-Feta-471055";
 imageUrlsBySize =             {
 90 = "http://lh3.ggpht.com/52EgxyVcu7bX12RRzWYn6vy3YZypYJnrTgm5H3Dk6f-OR7hUEjfOS0nfELAh9Y9oZb5Ffoc8a_axItjYMhs_=s90-c";
 };
 ingredients =             (
 "feta cheese",
 "olive oil",
 orange,
 "red onion",
 seasoning
 );
 rating = 5;
 recipeName = "Roasted Sweet Potatoes and Red Onions with Feta";
 smallImageUrls =             (
 "http://lh4.ggpht.com/fApSfqxoIr7QrwdvdXZe547JKGz9NBIW87_iTcTX7gUHLTpAxAJ_L2XYf9OTd_jipwgzRrq5Po3uxdC7YoRSmw=s90"
 );
 sourceDisplayName = "Kalyn's Kitchen";
 totalTimeInSeconds = 6300;
 },
 {
 attributes =             {
 holiday =                 (
 spring
 );
 };
 flavors =             {
 meaty = 0;
 salty = "0.1666666666666667";
 sour = "0.1666666666666667";
 sweet = "0.5";
 };
 id = "Grilled-Asparagus-_-Red-Onions-with-Olive-Oil_and-Balsamic-Vinegar-Once-Upon-A-Chef-199953";
 imageUrlsBySize =             {
 90 = "http://lh5.ggpht.com/agyh_d0hvssHNE1pRi0xNIEG-QOBmEl72Y4gmu2RGI4OSHVUUhpOMz2QBKSpdoiXAaBpNeHfrqBSeHcJaKrbrA=s90-c";
 };
 ingredients =             (
 "black pepper",
 "kosher salt",
 asparagus,
 sugar,
 "extra-virgin olive oil",
 "balsamic vinegar",
 "red onion"
 );
 rating = 5;
 recipeName = "Grilled Asparagus & Red Onions with Olive Oil\U00a0and Balsamic Vinegar";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Grilled-Asparagus-_-Red-Onions-with-Olive-Oil_and-Balsamic-Vinegar-Once-Upon-A-Chef-199953-39770.s.png"
 );
 sourceDisplayName = "Once Upon A Chef";
 totalTimeInSeconds = "<null>";
 },
 {
 attributes =             {
 course =                 (
 Salads
 );
 cuisine =                 (
 american
 );
 };
 flavors =             {
 meaty = "0.3333333333333333";
 piquant = "0.6666666666666666";
 salty = 0;
 sour = "0.1666666666666667";
 sweet = "0.1666666666666667";
 };
 id = "Rice_Wine-Vinaigrette-Martha-Stewart";
 imageUrlsBySize =             {
 90 = "http://lh4.ggpht.com/t5ePWm7cU8nxwLrH1uMMs0d9pK1zdJj5iNgOoGB1wBQT1BsMw1rR8WfExSZkvuHLvoqfofD-ilOuclf6VM9luw=s90-c";
 };
 ingredients =             (
 "coarse salt",
 "dijon mustard",
 "vegetable oil",
 "lime juice",
 "freshly ground pepper",
 honey,
 "rice wine vinegar"
 );
 rating = 5;
 recipeName = "Rice-Wine Vinaigrette";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Rice_Wine-Vinaigrette-Martha-Stewart-108071.s.png"
 );
 sourceDisplayName = "Martha Stewart";
 totalTimeInSeconds = 1200;
 },
 {
 attributes =             {
 holiday =                 (
 fall,
 thanksgiving,
 winter
 );
 };
 flavors =             {
 bitter = "0.1666666666666667";
 meaty = "0.1666666666666667";
 salty = 0;
 sour = "0.8333333333333334";
 sweet = 1;
 };
 id = "Cranberry-Sauce-with-Red-Wine-and-Figs-477223";
 imageUrlsBySize =             {
 90 = "http://lh4.ggpht.com/iYc08iMM0Jyn-wXt6GVSe-fLQjISTYoZ56vEHIgg_FlV2P9u1Me9Gvyk2sR2vFd8wD74oHoX41q1duyXDWHmcA=s90-c";
 };
 ingredients =             (
 allspice,
 orange,
 "apple cider vinegar",
 sugar,
 cranberries,
 "red wine",
 "dried fig"
 );
 rating = 0;
 recipeName = "Cranberry Sauce with Red Wine and Figs";
 smallImageUrls =             (
 "http://lh6.ggpht.com/C6dYfwWBjEFxmfTJ8gp10FVVgHne4cj5I3TdutL4e32AioLhOKOyQfPStdla7MuAunl_ZrC1MuheX4wBXuQZ=s90"
 );
 sourceDisplayName = "David Lebovitz";
 totalTimeInSeconds = "<null>";
 },
 {
 attributes =             {
 course =                 (
 Cocktails
 );
 };
 flavors = "<null>";
 id = "Traditional-eggnog-recipe-306258";
 imageUrlsBySize =             {
 90 = "http://lh3.ggpht.com/n7_ipHFGd4iiTokeeBoxHhGr8gzGpYql_1_m-g24avnETRkKvIY3NGaXjg7-_wieojhwivSre3Cz3vWywKfr1g=s90-c";
 };
 ingredients =             (
 "dark rum",
 "egg yolks",
 "whole milk",
 "heavy cream",
 bourbon,
 "granulated sugar",
 "ground nutmeg"
 );
 rating = 5;
 recipeName = "Traditional Eggnog Recipe";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Traditional-eggnog-recipe-306258-269611.s.jpg"
 );
 sourceDisplayName = "Food Republic";
 totalTimeInSeconds = 1800;
 },
 {
 attributes =             {
 };
 flavors =             {
 bitter = "0.1666666666666667";
 meaty = "0.1666666666666667";
 salty = "0.1666666666666667";
 sour = 1;
 };
 id = "Orange-Bitters-Recipe-Chow-55919";
 imageUrlsBySize =             {
 90 = "http://lh5.ggpht.com/2sncAA7AHxCDpRKEq6wg-jnwfXXG1kFbFV68vDVazMMU8v7BhFTv_jSgpmrIz41sE_WiBYDkPVbzznSzhWDu9w=s90-c";
 };
 ingredients =             (
 coriander,
 "fennel seeds",
 "grain alcohol",
 "orange peel",
 "gentian extract",
 "cardamom pods"
 );
 rating = 0;
 recipeName = "Orange Bitters Recipe";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Orange-Bitters-Recipe-Chow-55919-100049.s.png"
 );
 sourceDisplayName = Chow;
 totalTimeInSeconds = 2400;
 },
 {
 attributes =             {
 };
 flavors = "<null>";
 id = "Baked-shells-with-tomato-and-mozzarella-310024";
 imageUrlsBySize =             {
 90 = "http://lh5.ggpht.com/g-A40xXqaApKWNDOH2nzUZkzGcMmRJzydjKpf3bvNImJT-XlwYAPlVK3XVgwo-p2R31_8sg9mNi7j7aVw8X0GA=s90-c";
 };
 ingredients =             (
 pepper,
 shells,
 onion,
 "grated parmesan cheese",
 "olive oil",
 garlic,
 mozzarella,
 "tomato sauce",
 salt,
 "fresh basil leaves",
 tomatoes
 );
 rating = 5;
 recipeName = "Baked Shells with Tomato and Mozzarella";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Baked-shells-with-tomato-and-mozzarella-310024-274477.s.jpg"
 );
 sourceDisplayName = "Big Girls Small Kitchen";
 totalTimeInSeconds = 4200;
 },
 {
 attributes =             {
 };
 flavors = "<null>";
 id = "Eggless-chocolate-mousse-recipe-306530";
 imageUrlsBySize =             {
 90 = "http://lh3.ggpht.com/aU4UqpKIJE-j-Cu5d6YNEKKTld7ODiCSV9XgWXeDNltFZOWSLnxziYjH3qwVpR-EuxeCxzaXHGkE0s76voOfIg=s90-c";
 };
 ingredients =             (
 "heavy cream",
 "unsalted butter",
 "vanilla extract",
 "unflavor gelatin",
 "semisweet chocolate"
 );
 rating = 5;
 recipeName = "Eggless Chocolate Mousse Recipe";
 smallImageUrls =             (
 "http://yummly-recipeimages-compressed.s3.amazonaws.com/Eggless-chocolate-mousse-recipe-306530-270121.s.jpg"
 );
 sourceDisplayName = "Food Republic";
 totalTimeInSeconds = 2400;
 }
 );
 
 totalMatchCount = 731819;
 }
 
 */


#pragma mark
#pragma mark    EXAMPLE page of FULL recipe


/*
 {
 attributes =     {
 course =         (
 "Side Dishes"
 );
 };
 attribution =     {
 html = "<a href='http://www.yummly.com/recipe/Roasted-Sweet-Potatoes-and-Red-Onions-with-Feta-471055'>Roasted Sweet Potatoes and Red Onions with Feta recipe</a> information powered by <img alt='Yummly' src='http://static.yummly.com/api-logo.png'/>";
 logo = "http://static.yummly.com/api-logo.png";
 text = "Roasted Sweet Potatoes and Red Onions with Feta recipes: information powered by Yummly";
 url = "http://www.yummly.com/recipe/Roasted-Sweet-Potatoes-and-Red-Onions-with-Feta-471055";
 };
 flavors =     {
 Bitter = "0.1666666666666667";
 Meaty = "0.3333333333333333";
 Piquant = 0;
 Salty = "0.5";
 Sour = "0.3333333333333333";
 Sweet = "0.3333333333333333";
 };
 id = "Roasted-Sweet-Potatoes-and-Red-Onions-with-Feta-471055";
 images =     (
 {
 hostedLargeUrl = "http://lh4.ggpht.com/fApSfqxoIr7QrwdvdXZe547JKGz9NBIW87_iTcTX7gUHLTpAxAJ_L2XYf9OTd_jipwgzRrq5Po3uxdC7YoRSmw=s360";
 hostedSmallUrl = "http://lh4.ggpht.com/fApSfqxoIr7QrwdvdXZe547JKGz9NBIW87_iTcTX7gUHLTpAxAJ_L2XYf9OTd_jipwgzRrq5Po3uxdC7YoRSmw=s90";
 imageUrlsBySize =             {
 360 = "http://lh3.ggpht.com/52EgxyVcu7bX12RRzWYn6vy3YZypYJnrTgm5H3Dk6f-OR7hUEjfOS0nfELAh9Y9oZb5Ffoc8a_axItjYMhs_=s360-c";
 90 = "http://lh3.ggpht.com/52EgxyVcu7bX12RRzWYn6vy3YZypYJnrTgm5H3Dk6f-OR7hUEjfOS0nfELAh9Y9oZb5Ffoc8a_axItjYMhs_=s90-c";
 };
 }
 );
 ingredientLines =     (
 "2 large orange-fleshed sweet potatoes (sometimes called yams in U.S. grocery stores), cut in 1 inch cubes",
 "2 small red onions, cut into pieces just larger than 1 inch",
 "2 T olive oil (or slightly more, enough to coat all the veggies with oil)",
 "1 T seasoning for Spicy Sweet Potato Fries",
 "1/3 cup Feta cheese"
 );
 name = "Roasted Sweet Potatoes and Red Onions with Feta";
 numberOfServings = 5;
 nutritionEstimates =     (
 {
 attribute = "FAT_KCAL";
 description = "<null>";
 unit =             {
 abbreviation = kcal;
 id = "fea252f8-9888-4365-b005-e2c63ed3a776";
 name = calorie;
 plural = calories;
 pluralAbbreviation = kcal;
 };
 value = 70;
 },
 {
 attribute = FAPU;
 description = "Fatty acids, total polyunsaturated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.71";
 },
 {
 attribute = FOLDFE;
 description = "Folate, DFE";
 unit =             {
 abbreviation = "mcg_DFE";
 id = "4d783ee4-aa07-4958-84bf-3f4b528049dc";
 name = "mcg_DFE";
 plural = "mcg_DFE";
 pluralAbbreviation = "mcg_DFE";
 };
 value = "34.88";
 },
 {
 attribute = FOLFD;
 description = "Folate, food";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = MN;
 description = "Manganese, Mn";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = TOCPHA;
 description = "Vitamin E (alpha-tocopherol)";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = FAMS;
 description = "Fatty acids, total monounsaturated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "4.45";
 },
 {
 attribute = VITC;
 description = "Vitamin C, total ascorbic acid";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.06";
 },
 {
 attribute = CARTB;
 description = "Carotene, beta";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = VITB12;
 description = "Vitamin B-12";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = FOL;
 description = "Folate, total";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = GLUS;
 description = "Glucose (dextrose)";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.88";
 },
 {
 attribute = CHOLE;
 description = Cholesterol;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.01";
 },
 {
 attribute = "LEU_G";
 description = Leucine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = "THR_G";
 description = Threonine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = NIA;
 description = Niacin;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = "ASP_G";
 description = "Aspartic acid";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = TOCPHG;
 description = "Tocopherol, gamma";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = "SER_G";
 description = Serine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = "VAL_G";
 description = Valine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = "VITD-";
 description = "Vitamin D";
 unit =             {
 abbreviation = IU;
 id = "ed46fe0c-44fe-4c1f-b3a8-880f92e30930";
 name = IU;
 plural = IU;
 pluralAbbreviation = IU;
 };
 value = "1.6";
 },
 {
 attribute = FRUS;
 description = Fructose;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.44";
 },
 {
 attribute = VITK;
 description = "Vitamin K (phylloquinone)";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = "ILE_G";
 description = Isoleucine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = K;
 description = "Potassium, K";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.22";
 },
 {
 attribute = FASAT;
 description = "Fatty acids, total saturated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "2.28";
 },
 {
 attribute = "VITA_IU";
 description = "Vitamin A, IU";
 unit =             {
 abbreviation = IU;
 id = "ed46fe0c-44fe-4c1f-b3a8-880f92e30930";
 name = IU;
 plural = IU;
 pluralAbbreviation = IU;
 };
 value = "250.77";
 },
 {
 attribute = VITB6A;
 description = "Vitamin B-6";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = CHOLN;
 description = "Choline, total";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = "LYS_G";
 description = Lysine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = P;
 description = "Phosphorus, P";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.06";
 },
 {
 attribute = PHYSTR;
 description = Phytosterols;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.02";
 },
 {
 attribute = F10D0;
 description = "10:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.2";
 },
 {
 attribute = "ENERC_KJ";
 description = Energy;
 unit =             {
 abbreviation = kcal;
 id = "fea252f8-9888-4365-b005-e2c63ed3a776";
 name = calorie;
 plural = calories;
 pluralAbbreviation = kcal;
 };
 value = "587.47";
 },
 {
 attribute = CU;
 description = "Copper, Cu";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = CRYPX;
 description = "Cryptoxanthin, beta";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = SUCS;
 description = Sucrose;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.44";
 },
 {
 attribute = SE;
 description = "Selenium, Se";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = FIBTG;
 description = "Fiber, total dietary";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "4.66";
 },
 {
 attribute = NA;
 description = "Sodium, Na";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.12";
 },
 {
 attribute = F12D0;
 description = "12:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = LYCPN;
 description = Lycopene;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = ZN;
 description = "Zinc, Zn";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = "ENERC_KCAL";
 description = Energy;
 unit =             {
 abbreviation = kcal;
 id = "fea252f8-9888-4365-b005-e2c63ed3a776";
 name = calorie;
 plural = calories;
 pluralAbbreviation = kcal;
 };
 value = "140.87";
 },
 {
 attribute = "PHE_G";
 description = Phenylalanine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = "TYR_G";
 description = Tyrosine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = "PRO_G";
 description = Proline;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = F14D0;
 description = "14:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.31";
 },
 {
 attribute = "LUT+ZEA";
 description = "Lutein + zeaxanthin";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = SUGAR;
 description = "Sugars, total";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "2.19";
 },
 {
 attribute = ASH;
 description = Ash;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "1.29";
 },
 {
 attribute = WATER;
 description = Water;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "105.09";
 },
 {
 attribute = F16D0;
 description = "16:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "1.1";
 },
 {
 attribute = "VITA_RAE";
 description = "Vitamin A, RAE";
 unit =             {
 abbreviation = "mcg_RAE";
 id = "0fcf76b3-891a-403d-883f-58c8809ef151";
 name = "mcg_RAE";
 plural = "mcg_RAE";
 pluralAbbreviation = "mcg_RAE";
 };
 value = "23.26";
 },
 {
 attribute = F16D1;
 description = "16:1 undifferentiated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.05";
 },
 {
 attribute = "GLU_G";
 description = "Glutamic acid";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.2";
 },
 {
 attribute = PANTAC;
 description = "Pantothenic acid";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = F18D0;
 description = "18:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.21";
 },
 {
 attribute = FAT;
 description = "Total lipid (fat)";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "7.57";
 },
 {
 attribute = MG;
 description = "Magnesium, Mg";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.02";
 },
 {
 attribute = F4D0;
 description = "4:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = F18D1;
 description = "18:1 undifferentiated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "4.24";
 },
 {
 attribute = RIBF;
 description = Riboflavin;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = F18D2;
 description = "18:2 undifferentiated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.55";
 },
 {
 attribute = CHOCDF;
 description = "Carbohydrate, by difference";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "16.73";
 },
 {
 attribute = F6D0;
 description = "6:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = F18D3;
 description = "18:3 undifferentiated";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.06";
 },
 {
 attribute = PROCNT;
 description = Protein;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "2.67";
 },
 {
 attribute = FLD;
 description = "Fluoride, F";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = CA;
 description = "Calcium, Ca";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.12";
 },
 {
 attribute = F8D0;
 description = "8:0";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = RETOL;
 description = Retinol;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 },
 {
 attribute = "ALA_G";
 description = Alanine;
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = "0.1";
 },
 {
 attribute = FE;
 description = "Iron, Fe";
 unit =             {
 abbreviation = g;
 id = "12485d26-6e69-102c-9a8a-0030485841f8";
 name = gram;
 plural = grams;
 pluralAbbreviation = grams;
 };
 value = 0;
 }
 );
 rating = 5;
 source =     {
 sourceDisplayName = "Kalyn's Kitchen";
 sourceRecipeUrl = "http://www.kalynskitchen.com/2013/11/roasted-sweet-potatoes-red-onion-feta.html";
 sourceSiteUrl = "http://www.kalynskitchen.com/";
 };
 totalTime = "1 hr 45 min";
 totalTimeInSeconds = 6300;
 yield = "makes 4-6 ";
 }
 
 */

// http://kalynsprintablerecipes.blogspot.com/2013/11/roasted-sweet-potatoes-and-red-onions.html
