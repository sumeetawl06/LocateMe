//
//  ToDoViewController.m
//  LocateMe
//
//  Created by Sumeet Agrawal on 12/17/17.
//  Copyright © 2017 Personal. All rights reserved.
//

#import "ToDoViewController.h"
#import <PureLayout/PureLayout.h>
#import "ToDoTableViewCell.h"
#import "DetailsViewController.h"

@interface ToDoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ToDoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addTableView];
    
}

- (void)addTableView {
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:0];
    [_tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:0];
}

#pragma mark - TablewView Delegate DAtaSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoTableViewCell *cell;
    NSString *cellIdentifier = @"cellIdentifier";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[ToDoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld",(long)indexPath.row+1]];
    cell.titleLabel.text = @"Big Ben";
    cell.streetAddressLabel.text = @"London SW1AOAA";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailsViewController *detaiVC = [[DetailsViewController alloc]init];
    detaiVC.imageNumber = indexPath.row+1;
    [self.navigationController pushViewController:detaiVC animated:YES];
    [self setTitle:@"Ben Den"];
}

@end
