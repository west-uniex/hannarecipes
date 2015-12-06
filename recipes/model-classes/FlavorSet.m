//
//  FlavorSet.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 18.12.13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//


#define kSaltyKee @"salty"
#define kSour @"sour"
#define kSweet @"sweet"
#define kBitter @"bitter"
#define kMeaty @"meaty"
#define kPiquant @"piquant"

#import "FlavorSet.h"

@implementation FlavorSet


+ (FlavorSet *) flavorsWithSalty: (NSNumber *) salty
                            sour: (NSNumber *) sour
                           sweet: (NSNumber *) sweet
                          bitter: (NSNumber *) bitter
                           meaty: (NSNumber *) meaty
                         piquant: (NSNumber *) piquant
{
    FlavorSet *newFlavorSet = [[FlavorSet alloc] init];
    
    newFlavorSet.salty = salty;
    newFlavorSet.sour = sour;
    newFlavorSet.sweet = sweet;
    newFlavorSet.bitter = bitter;
    newFlavorSet.piquant = piquant;
    newFlavorSet.meaty = meaty;
    
    return newFlavorSet;
}


-(NSString *) description
{
    [super description];
    
    NSString *descriptionString = nil;
    
    descriptionString = [NSString stringWithFormat:@" %@  salty: %@  sour: %@ sweet: %@  bitter: %@ meaty: %@  piquant: %@ ", NSStringFromClass([self class]), self.salty, self.sour, self.sweet, self.bitter, self.meaty, self.piquant];
    
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
        [self setSalty:[decoder decodeObjectForKey:kSaltyKee]];
        [self setSour:[decoder decodeObjectForKey:kSour]];
        [self setSweet:[decoder decodeObjectForKey:kSweet]];
        
        [self setBitter:[decoder decodeObjectForKey: kBitter]];
        [self setMeaty:[decoder decodeObjectForKey: kMeaty]];
        [self setPiquant:[decoder decodeObjectForKey: kPiquant]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    // For each instance variable, archive it under its variable name
    // These objects will also be sent encodeWithCoder:
    [encoder encodeObject:_salty forKey: kSaltyKee];
    [encoder encodeObject:_sour forKey: kSour];
    [encoder encodeObject:_sweet forKey: kSweet];
    [encoder encodeObject:_bitter forKey: kBitter];
    [encoder encodeObject:_meaty forKey: kMeaty];
    [encoder encodeObject:_piquant forKey: kPiquant];
    
}

#pragma mark external methods(messages)

- (NSInteger) counterNonzeroValue
{
    NSInteger counter = 0;
    
    if (self.salty != nil  && [self.salty floatValue] != 0.0)
    {
        counter++;
    }
    
    if (self.sour != nil && [self.sour floatValue] != 0.0)
    {
        counter++;
    }
    
    if (self.sweet != nil && [self.sweet floatValue] != 0.0)
    {
        counter++;
    }
    
    if (self.bitter != nil && [self.bitter floatValue] != 0.0)
    {
        counter++;
    }
    
    if (self.meaty != nil && [self.meaty floatValue] != 0.0)
    {
        counter++;
    }
    
    if (self.piquant != nil && [self.piquant floatValue] != 0.0)
    {
        counter++;
    }
    
    return counter;
}



@end
