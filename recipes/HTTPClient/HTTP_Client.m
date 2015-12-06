//
//  HTTP_Client.m
//  recipes
//
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import "HTTP_Client.h"
#import "Recipe.h"
#import "AppDelegate.h"
#import "ConnectionManager.h"
#import "Reachability.h"
#import "FlavorSet.h"


#define kAPPLICATION_ID @"3a3d9b11"
#define kAPPLICATION_KEY @"13312f01755996b3e9ed6b679b2d3c54"

#define kAPI_EndPoint @"http://api.yummly.com/v1"


@interface HTTP_Client ()

@property (nonatomic, strong) NSOperationQueue *myOperationQueue;

@end

@implementation HTTP_Client

- (id)init
{
    self = [super init];
    if (self)
    {
        _myOperationQueue = [[NSOperationQueue alloc] init];
        
    }
    return self;
}

static HTTP_Client *_sharedHTTP_Client = nil;

+ (HTTP_Client *) sharedHTTP_Client
{
    if( !_sharedHTTP_Client )
    {
		_sharedHTTP_Client = [[HTTP_Client alloc] init];
	}
	return _sharedHTTP_Client;
}

// http://api.yummly.com/v1/api/recipes?_app_id=3a3d9b11&_app_key=13312f01755996b3e9ed6b679b2d3c54&q=onion+soup
// responce on desktop in folder HANNA

-(void) seachRecipesWithName: (NSString *) nameOfRecipe

{
    __block NSArray *members = nil;
    
    //int indexInt = [index intValue];
    NSString *urlAsString = @"http://api.yummly.com/v1/api/recipes";
    
    //NSString * myString = @"Hello,";
    
    NSString * newString = [nameOfRecipe stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSLog(@"%@xx",newString);
    urlAsString = [urlAsString stringByAppendingString:[NSString stringWithFormat:@"?q=%@",newString]];
    DLog(@"url string: %@", urlAsString)
    // 2013-12-13 23:04:25.080 recipes[4834:907] -[HTTP_Client seachRecipesWithName:] [Line 60] url string: http://api.yummly.com/v1/api/recipes?q=onion+soup
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set time out interval for various type of
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    if ([appDelegate.connectionManager.internetReachability currentReachabilityStatus] == ReachableViaWWAN)
    {
        [urlRequest setTimeoutInterval:60.0f];
    }
    else
    {
        [urlRequest setTimeoutInterval:30.0f];        
    }
    
       [urlRequest setHTTPMethod:@"GET"];
    
    //  set header ...
    
    [urlRequest setValue: kAPPLICATION_ID  forHTTPHeaderField:@"X-Yummly-App-ID"];
    [urlRequest setValue: kAPPLICATION_KEY forHTTPHeaderField:@"X-Yummly-App-Key"];
    //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //
    
    [NSURLConnection    sendAsynchronousRequest:urlRequest
                                          queue:self.myOperationQueue
                              completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error != nil)
         {
             DLog(@"Error on load = %@", [error localizedDescription]);
             [self.delegate httpClient:self request:urlRequest doneWithError:error];
             return ;
         }
         else
         {   // check the HTTP status
             if ([response isKindOfClass:[NSHTTPURLResponse class]])
             {
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                 DLog(@"Headers: %@", [httpResponse allHeaderFields]);
                 if (httpResponse.statusCode != 200)
                 {
                     DLog(@"WE HAVE WRONG RESPONSE FROM SERVER http response status code %d",httpResponse.statusCode);
                     //[self updateTimeToStartInEvents];
                     return;
                 }
             }
             else
             {
                 DLog(@"ERROR ");
             }
             
             // parse the results and make a dictionary
             NSError *error = nil;
             NSDictionary *payload = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:NSJSONReadingAllowFragments
                                                                                        error:&error];
             if (error)
             {
                 DLog(@"wrong  JSON serialization");
                 members = nil;
                 return;
             }
             else
             {
                 members = [payload objectForKey:@"matches"];
                 DLog(@"\n server return in JSON ARRAY OF RECIPES: %@ ",members);
                 DLog(@" %@", [members class]);
                 NSMutableArray *recipes = [NSMutableArray arrayWithCapacity: members.count];
                 Recipe *recipe = nil;
                 FlavorSet *flavor = nil;
                 NSNumber *saltyValue = nil;
                 NSNumber *sourValue = nil;
                 NSNumber *sweetValue = nil;
                 NSNumber *bitterValue = nil;
                 NSNumber *meatyValue = nil;
                 NSNumber *piquantValue = nil;
                 
                 NSArray *allKeys = nil;
                 NSDictionary *memberDictionary = nil;
                 
                 for ( NSUInteger i = 0; i < members.count ; i ++ )
                 {
                     recipe = nil;
                     flavor = nil;
                     saltyValue = nil;
                     sourValue = nil;
                     sweetValue = nil;
                     bitterValue = nil;
                     meatyValue = nil;
                     piquantValue = nil;
                     
                     memberDictionary = [members objectAtIndex:i];
                     
                     id flavors = [memberDictionary objectForKey:@"flavors"] ;
                     
                     DLog(@" %@", [flavors class]);
                     
                     if ([flavors isKindOfClass:[NSDictionary class]] )
                     {
                         allKeys = [(NSDictionary *)flavors allKeys];
                         
                         if ([allKeys containsObject:@"salty"])
                         {
                             saltyValue = [[memberDictionary  objectForKey:@"flavors"] objectForKey:@"salty"];
                         }
                         else
                         {
                             saltyValue = @0.0;
                         }
                         
                         if ([allKeys containsObject:@"sour"])
                         {
                             sourValue = [[memberDictionary  objectForKey:@"flavors"] objectForKey:@"sour"];
                         }
                         else
                         {
                             sourValue = @0.0;
                         }
                         
                         if ([allKeys containsObject:@"sweet"])
                         {
                             sweetValue = [[memberDictionary  objectForKey:@"flavors"] objectForKey:@"sweet"];
                         }
                         else
                         {
                             sweetValue = @0.0;
                         }
                         
                         if ([allKeys containsObject:@"bitter"])
                         {
                             bitterValue = [[memberDictionary  objectForKey:@"flavors"] objectForKey:@"bitter"];
                         }
                         else
                         {
                             bitterValue = @0.0;
                         }
                         
                         if ([allKeys containsObject:@"meaty"])
                         {
                             meatyValue = [[memberDictionary  objectForKey:@"flavors"] objectForKey:@"meaty"];
                         }
                         else
                         {
                             meatyValue = @0.0;
                         }
                         
                         if ([allKeys containsObject:@"piquant"])
                         {
                             piquantValue = [[memberDictionary  objectForKey:@"flavors"] objectForKey:@"piquant"];
                         }
                         else
                         {
                             piquantValue = @0.0;
                         }

                     }
                     else
                     {
                         saltyValue = @0.0;
                         sourValue = @0.0;
                         sweetValue = @0.0;
                         bitterValue = @0.0;
                         meatyValue = @0.0;
                         piquantValue = @0.0;
                     }
                     
                     
                     flavor = [FlavorSet flavorsWithSalty: saltyValue
                                                     sour: sourValue
                                                    sweet: sweetValue
                                                   bitter: bitterValue
                                                    meaty: meatyValue
                                                  piquant: piquantValue ];
                     
                     recipe = [Recipe recipeWithRecipeId:[memberDictionary objectForKey:@"id"]
                                              recipeName:[memberDictionary objectForKey:@"recipeName"]
                                                  rating:[memberDictionary objectForKey:@"rating" ]
                                           totalDuration:[memberDictionary objectForKey:@"totalTimeInSeconds"]
                                             ingredients:[memberDictionary objectForKey:@"ingredients"]
                                                 flavors:flavor
                                                imageUrl:[[memberDictionary  objectForKey:@"imageUrlsBySize"] objectForKey:@"90"]
                                               imageSize:@"90"];
                     //
                     [self loadFullRecipeWithID:recipe.recipeId];
                     
                     [recipes addObject:recipe];
                 }
                 
                 NSArray *recipesToSending = [recipes copy];
                 
                 [self.delegate httpClient:self
                               haveRecipes:recipesToSending
                           forNameOfRecipe:nameOfRecipe];
             }
             // end block with NO ERROR FROM SERVER
         }
     }
     ];
    
    return;
}

/*
for (NSDictionary *member in members)
{
    
    id flavors = [member objectForKey:@"flavors"] ;
    
    DLog(@" %@", [flavors class]);
    
    allKeys = [(NSDictionary *)flavors allKeys];
    
    if ([allKeys containsObject:@"salty"])
    {
        saltyValue = [[member  objectForKey:@"flavors"] objectForKey:@"salty"];
    }
    else
    {
        saltyValue = @0.0;
    }
    
    if ([allKeys containsObject:@"sour"])
    {
        sourValue = [[member  objectForKey:@"flavors"] objectForKey:@"sour"];
    }
    else
    {
        sourValue = @0.0;
    }
    
    if ([allKeys containsObject:@"sweet"])
    {
        sweetValue = [[member  objectForKey:@"flavors"] objectForKey:@"sweet"];
    }
    else
    {
        sweetValue = @0.0;
    }
    
    if ([allKeys containsObject:@"bitter"])
    {
        bitterValue = [[member  objectForKey:@"flavors"] objectForKey:@"bitter"];
    }
    else
    {
        bitterValue = @0.0;
    }
    
    if ([allKeys containsObject:@"meaty"])
    {
        meatyValue = [[member  objectForKey:@"flavors"] objectForKey:@"meaty"];
    }
    else
    {
        meatyValue = @0.0;
    }
    
    if ([allKeys containsObject:@"piquant"])
    {
        piquantValue = [[member  objectForKey:@"flavors"] objectForKey:@"piquant"];
    }
    else
    {
        piquantValue = @0.0;
    }
    
    flavor = [FlavorSet flavorsWithSalty: saltyValue
                                    sour: sourValue
                                   sweet: sweetValue
                                  bitter: bitterValue
                                   meaty: meatyValue
                                 piquant: piquantValue ];
    
    recipe = [Recipe recipeWithRecipeId:[member objectForKey:@"id"]
                             recipeName:[member objectForKey:@"recipeName"]
                                 rating:[member objectForKey:@"rating" ]
                          totalDuration:[member objectForKey:@"totalTimeInSeconds"]
                            ingredients:[member objectForKey:@"ingredients"]
                                flavors:flavor
                               imageUrl:[[member  objectForKey:@"imageUrlsBySize"] objectForKey:@"90"]
                              imageSize:@"90"];
    [recipes addObject:recipe];
}

NSArray *recipesToSending = [recipes copy];

[self.delegate httpClient:self
              haveRecipes:recipesToSending
          forNameOfRecipe:nameOfRecipe];

}

*/



// http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY

// http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY

// recipe page

-(void) loadFullRecipeWithID: (NSString *) recipeID

{
    __block NSArray *members = nil;
    
    //int indexInt = [index intValue];
    NSString *urlAsString = @"http://api.yummly.com/v1/api/recipe";
    urlAsString = [urlAsString stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",recipeID]];
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    //  set header ...
    
    [urlRequest setValue: kAPPLICATION_ID  forHTTPHeaderField:@"X-Yummly-App-ID"];
    [urlRequest setValue: kAPPLICATION_KEY forHTTPHeaderField:@"X-Yummly-App-Key"];
    //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection    sendAsynchronousRequest:urlRequest
                                          queue:self.myOperationQueue
                              completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error != nil)
         {
             DLog(@"Error on load = %@", [error localizedDescription]);
             [self.delegate httpClient:self
                               request:urlRequest
                         doneWithError:error];
         }
         else
         {   // check the HTTP status
             if ([response isKindOfClass:[NSHTTPURLResponse class]])
             {
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                 //DLog(@"Headers: %@", [httpResponse allHeaderFields]);
                 if (httpResponse.statusCode != 200)
                 {
                     DLog(@"WE HAVE WRONG RESPONSE FROM SERVER http response status code %d",httpResponse.statusCode);
                     //[self updateTimeToStartInEvents];
                     return;
                 }
             }
             
             // parse the results and make a dictionary
             NSError *error = nil;
             //members = (NSArray *) [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
             
             NSDictionary *fullRecipe = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:NSJSONReadingAllowFragments
                                                                                           error:&error];
             if (error)
             {
                 DLog(@"wrong  JSON serialization");
                 members = nil;
                 return;
             }
             else
             {
                 DLog(@"\n server return in JSON FULL RECEPTE: %@ ",members);
                 
                 NSArray *ingredientLines = [fullRecipe objectForKey:@"ingredientLines"];
                 NSNumber *numberOfServings = [fullRecipe objectForKey:@"numberOfServings"];
                 NSArray *nutritionEstimates = [fullRecipe objectForKey:@"nutritionEstimates"];
                 NSDictionary *source = [fullRecipe objectForKey:@"source"];
                 NSString *sourceRecipeUrl = [source objectForKey:@"sourceRecipeUrl"];
                 [self.delegate httpClient:self
                           ingredientLines:ingredientLines
                          numberOfServings:numberOfServings
                        nutritionEstimates:nutritionEstimates
                           sourceRecipeUrl: sourceRecipeUrl
                               forRecipeId:recipeID];
                 
             }
             // end block with NO ERROR FROM SERVER
         }
     }
     ];
    
    return;
}



@end
