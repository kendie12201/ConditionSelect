//
//  ConditionSelect
//
//  Created by DInG on 16/5/10.
//  Copyright © 2016年 DInG. All rights reserved.
//

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define     COLOR_BUTTON_COMMON                     [UIColor colorWithRed:51.f/255.f green:148.f/255.f blue:166.f/255.f alpha:1.f]


#import "ViewController.h"
#import "MainSelectedView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MainSelectedView *mainSelectedView = [MainSelectedView loadMainSelectedView];
    mainSelectedView.frame = CGRectMake(0, 64, SCREENWIDTH, 30);
    [self.view addSubview:mainSelectedView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
