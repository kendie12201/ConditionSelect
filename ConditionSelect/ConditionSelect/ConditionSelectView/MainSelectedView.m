//
//  ConditionSelect
//
//  Created by DInG on 16/5/10.
//  Copyright © 2016年 DInG. All rights reserved.
//

#import "MainSelectedView.h"
#import "KindView.h"
#import "AppDelegate.h"
#import "UIView+Extension.h"
#import "StateView.h"
#import "PriceView.h"


@interface MainSelectedView()

@property (weak, nonatomic) IBOutlet UIButton *kindBtn;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@property (weak, nonatomic) IBOutlet UIButton *calendarBtn;

@property (assign, nonatomic) BtnSelected btnSelected;

@property (nonatomic, strong) KindView *kindView;

@property (nonatomic, strong) StateView *stateView;

@property (nonatomic, strong) PriceView *priceView;

@property (nonatomic, strong) UIView *blackView;

@end

@implementation MainSelectedView

//懒加载blackView
- (UIView *)blackView {
    if (_blackView == nil) {
        _blackView = [[UIView alloc]init];
        _blackView.width =[UIScreen mainScreen].bounds.size.width;
        _blackView.height = [UIScreen mainScreen].bounds.size.height;
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.3;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(balckTapAction)];
        [_blackView addGestureRecognizer:tap];
        
    }
    return _blackView;
}

//懒加载kindView
- (KindView *)kindView {
    if (_kindView == nil) {
        _kindView = [[KindView alloc] init];
        _kindView.width = self.width;
        _kindView.height = 300;
    }
    return _kindView;
}


//懒加载kindView
- (StateView *)stateView {
    if (_stateView == nil) {
        _stateView = [[StateView alloc] init];
        _stateView.width = self.width;
        _stateView.height = 300;
    }
    return _stateView;
}


//懒加载kindView
- (PriceView *)priceView {
    if (_priceView == nil) {
        _priceView = [[PriceView alloc] init];
        _priceView.width = self.width;
        _priceView.height = 300;
    }
    return _priceView;
}



//种类点击
- (IBAction)KindAction:(UIButton *)sender {
    self.stateBtn.selected = NO;
    self.calendarBtn.selected = NO;
    [self resetImage];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.btnSelected = kindSelected;
        [UIView animateWithDuration:0.25 animations:^{
            // 箭头翻转
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        [self setupCover];
    }
}


//状态点击
- (IBAction)stateAction:(UIButton *)sender {
    self.kindBtn.selected = NO;
    self.calendarBtn.selected = NO;
    [self resetImage];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.btnSelected = stateSelected;
        [UIView animateWithDuration:0.25 animations:^{
            // 箭头翻转
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        [self setupCover];
    }
}


//日历点击
- (IBAction)calendarAction:(UIButton *)sender {
    self.kindBtn.selected = NO;
    self.stateBtn.selected = NO;
    [self resetImage];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.btnSelected = priceSelected;
        [UIView animateWithDuration:0.25 animations:^{
            // 箭头翻转
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        [self setupCover];
    }
}



/**
 *  添加遮盖
 */
- (void)setupCover
{
    // 添加一个遮盖按钮
    UIWindow* window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    CGFloat conmonY = CGRectGetMaxY(self.frame);
    self.blackView.x = 0;
    self.blackView.y = conmonY;
    [window addSubview:self.blackView];
    switch (self.btnSelected) {
        case kindSelected:
        {
            self.kindView.x = 0;
            self.kindView.y = conmonY;
            [window addSubview:self.kindView];
        }
            break;
        case stateSelected:
        {
            self.stateView.x = 0;
            self.stateView.y = conmonY;
            [window addSubview:self.stateView];
        }
            break;
        case priceSelected:
        {
            self.priceView.x = 0;
            self.priceView.y = conmonY;
            [window addSubview:self.priceView];
        }
            break;
            
        default:
            break;
    }
}


/**
 *  旋转复位
 */
- (void)resetImage
{
    [self.kindView removeFromSuperview];
    [self.stateView removeFromSuperview];
    [self.priceView removeFromSuperview];
    [self.blackView removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        self.kindBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        self.stateBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        self.calendarBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }];
}


//点击blackView
- (void)balckTapAction {
    self.kindBtn.selected = NO;
    self.stateBtn.selected = NO;
    self.calendarBtn.selected = NO;
    [self resetImage];
}


//类方法
+ (instancetype)loadMainSelectedView {
    return [[NSBundle mainBundle] loadNibNamed:@"MainSelectedView" owner:nil options:0].lastObject;
}


- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(balckTapAction) name:@"kindCellNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(balckTapAction) name:@"stateCellNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(balckTapAction) name:@"priceCellNotification" object:nil];
}


@end
