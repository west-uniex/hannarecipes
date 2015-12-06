//
//  FlavorSet.h
//  recipes
//
//  Created by Kondratyuk Mykola P. on 18.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlavorSet : NSObject

@property (nonatomic, strong) NSNumber * salty;
@property (nonatomic, strong) NSNumber * sour;
@property (nonatomic, strong) NSNumber * sweet;
@property (nonatomic, strong) NSNumber * bitter;
@property (nonatomic, strong) NSNumber * meaty;
@property (nonatomic, strong) NSNumber * piquant;

+ (FlavorSet *) flavorsWithSalty: (NSNumber *) salty
                            sour: (NSNumber *) sour
                           sweet: (NSNumber *) sweet
                          bitter: (NSNumber *) bitter
                           meaty: (NSNumber *) meaty
                         piquant: (NSNumber *) piquant;

- (NSInteger) counterNonzeroValue;


@end


//"flavors": { "salty": 0.6666666666666666,  "sour": 0.8333333333333334, "sweet": 0.6666666666666666, "bitter": 0.5, "meaty": 0.16666666666666666, "piquant": 0.5 }