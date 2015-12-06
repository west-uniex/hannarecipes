//
//  MyImageStore.h
//  recipes
//
//  Created by Kondratyuk Hanna on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyImageStore : NSObject

{
    NSMutableDictionary *dictionary;
}

+ (MyImageStore *) defaultImageStore;

- (void)setImage:(UIImage *)i
          forKey:(NSString *)s;

- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;

@end
