//
//  ConditionSelect
//
//  Created by DInG on 16/5/10.
//  Copyright © 2016年 DInG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kindSelected,
    stateSelected,
    priceSelected,
} BtnSelected;

@interface MainSelectedView : UIView

+ (instancetype)loadMainSelectedView;

@end
