//
//  ProgressLineCell.h
//  recipes
//
//  Created by Mykola Kondratyuk on 1/29/14.
//  Copyright (c) 2014 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressLineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameTaste;
@property (weak, nonatomic) IBOutlet UIProgressView *valueProgressView;

@end
