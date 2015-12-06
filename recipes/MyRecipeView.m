//
//  MyRecipeView.m
//  recipes
//
//  Created by Kondratyuk Mykola P. on 06.01.14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import "MyRecipeView.h"

@implementation MyRecipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)buttonPicPhotoDidTap:(id)sender
{
    // it's method have to implement the  owner of this view !!!
    
}

- (IBAction)didChangeNameRecipeText:(id)sender
{
    // it's method have to implement the  owner of this view !!!
}



@end
