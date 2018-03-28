//
//  ViewController.m
//  SKDynamicCellHeight
//
//  Created by AY on 2018/3/28.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "ViewController.h"
#define kSecondSelectedCellHeight SCREEN_HEIGHT * 0.321
#define kSecondNormalCellHeight SCREEN_HEIGHT * 0.24

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 数据源数组 */
@property (nonatomic,strong)NSMutableArray *dataArray;

/** 背景 tableview */
@property (nonatomic,strong)UITableView *mainTableView;

/** 用户选中按钮的数组 */
@property (nonatomic,strong)NSMutableArray *btnSelectedIdxArr;

@end

@implementation ViewController
- (NSMutableArray *)dataArray
{
	if (!_dataArray) {
	
		NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
		_dataArray = [NSMutableArray arrayWithArray:arr];
	}
	return _dataArray;

}

- (NSMutableArray *)btnSelectedIdxArr
{
	if (!_btnSelectedIdxArr) {
		_btnSelectedIdxArr = [NSMutableArray array];
	}
	return _btnSelectedIdxArr;

}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self createMainTB];
}


#pragma mark - 2 Create UI
- (void)createMainTB
{
	
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.bounces = NO;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleBlue;
    self.mainTableView.showsVerticalScrollIndicator = NO;
	// self.mainTableView.backgroundColor = kMainColor;
    [self.view addSubview:self.mainTableView];
	
}

#pragma mark - 4 Delegate Method 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArray.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
	return 0.01;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = @"123456";
	
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[btn setTitle:@"打开菜单" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	btn.tag = indexPath.row;
	btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
	btn.backgroundColor = [UIColor brownColor];
	btn.frame = CGRectMake(100, 50, 150, 40);
	[cell.contentView addSubview:btn];
	
	
	// cell 刷新的时候 去改变按钮的标题
	if ([self.btnSelectedIdxArr containsObject:@(indexPath.row)]) {
		[btn setTitle:@"关闭" forState:UIControlStateNormal];
		btn.backgroundColor = [UIColor cyanColor];
	}else{
		[btn setTitle:@"打开菜单" forState:UIControlStateNormal];
		btn.backgroundColor = [UIColor brownColor];
	}
	

	return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

	
	
	// 进行过滤 如果有改变 就改变高度
	NSNumber * idxNum = [NSNumber numberWithInteger:indexPath.row];
	if ([self.btnSelectedIdxArr containsObject:idxNum]) {
		return kSecondSelectedCellHeight;
	}else{
		return kSecondNormalCellHeight;
	}
	
}


- (void)btnClick:(UIButton *)btn
{
	
		// 打开菜单按钮的点击 的索引
	NSInteger idx = btn.tag;
	
	// 按钮每一次点击的时候 记录索引 放进数组 再次点击的话 如果有的话 进行剔除
	// 然后刷新cell 高度
	if ([_btnSelectedIdxArr containsObject:@(idx)]) {
		[_btnSelectedIdxArr removeObject:@(idx)];
	}else{
		[_btnSelectedIdxArr addObject:@(idx)];
	}
	
	[self.mainTableView reloadData];
	

}



- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
