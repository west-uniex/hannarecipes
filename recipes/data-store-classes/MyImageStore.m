//
//  MyImageStore.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 05.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "MyImageStore.h"

static MyImageStore *defaultImageStore = nil;


@implementation MyImageStore

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultImageStore];
}

+ (MyImageStore *)defaultImageStore
{
    if (!defaultImageStore)
    {
        // Create the singleton
        defaultImageStore = [[super allocWithZone:NULL] init];
    }
    return defaultImageStore;
}

- (id)init
{
    if (defaultImageStore)
    {
        return defaultImageStore;
    }
    
    self = [super init];
    if (self)
    {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(clearCache:)
               name:UIApplicationDidReceiveMemoryWarningNotification
             object:nil];
    
    return self;
}


- (void)clearCache:(NSNotification *)note
{
    DLog(@"flushing %d images out of the cache", [dictionary count]);
    [dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)i
          forKey:(NSString *)s
{
    
    if ([dictionary objectForKey:s])
    {
        [dictionary removeObjectForKey:s];
    }
    
    [dictionary setObject:i forKey:s];
    
    // Create full path for image
    NSString *imagePath = pathInDocumentDirectory(s);
    
    // Turn image into JPEG data,
    NSData *d = UIImageJPEGRepresentation(i, 1.0);
    
    // Write it to full path
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s
{
    // If possible, get it from the dictionary
    UIImage *result = [dictionary objectForKey:s];
    
    if (!result)
    {
        // Create UIImage object from file
        result = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(s)];
        
        // If we found an image on the file system, place it into the cache
        if (result)
            [dictionary setObject:result forKey:s];
        else
            DLog(@"Error: unable to find %@", pathInDocumentDirectory(s));
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)s
{
    if (!s)
        return;
    [dictionary removeObjectForKey:s];
    
    NSString *path = pathInDocumentDirectory(s);
    [[NSFileManager defaultManager] removeItemAtPath:path
                                               error:nil];
}

@end
