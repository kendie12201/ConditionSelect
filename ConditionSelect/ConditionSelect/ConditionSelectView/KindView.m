//
//  ConditionSelect
//
//  Created by DInG on 16/5/10.
//  Copyright © 2016年 DInG. All rights reserved.
//

#define FOOTHEIGHT   10
#define     COLOR_BUTTON_COMMON                     [UIColor colorWithRed:51.f/255.f green:148.f/255.f blue:166.f/255.f alpha:1.f]


#import "KindView.h"




@interface KindView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIView *footView;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation KindView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //tableView
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //footView
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = COLOR_BUTTON_COMMON;
        self.footView = footView;
        [self addSubview:footView];
        
        
        //cell高度
        if (self.cellHeigh) {
            self.tableView.rowHeight = self.cellHeigh;
        }else {
            self.tableView.rowHeight = 44;
        }
    }
    return self;
}


//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


//cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = COLOR_BUTTON_COMMON;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:@"kind_checkmark"];
    NSInteger select = [number integerValue];
    if (indexPath.row == select) {
       cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"类型%lu",indexPath.row];
    return cell;
}


//选中cell做的事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[NSUserDefaults standardUserDefaults] setValue:[[NSNumber alloc] initWithInteger:indexPath.row] forKey:@"kind_checkmark"];
    [self.tableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kindCellNotification" object:nil];
    });
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect tabRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - FOOTHEIGHT);
    self.tableView.frame = tabRect;
    
    
    CGRect rect = CGRectMake(0, self.bounds.size.height - FOOTHEIGHT, self.bounds.size.width, FOOTHEIGHT);
    self.footView.frame = rect;
}

@end
