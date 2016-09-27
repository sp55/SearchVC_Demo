//
//  ViewController.m
//  SearchVC_Demo
//
//  Created by admin on 16/9/27.
//  Copyright © 2016年 AlezJi. All rights reserved.
//http://www.jianshu.com/p/83dc57e78544

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)UISearchController *searchVC;
@property(strong,nonatomic)NSArray *dataArr;
@property(strong,nonatomic)NSMutableArray *searchArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView =[UIView new];
    
    self.dataArr=@[@"1",@"12",@"2",@"21"];
    
    self.searchArr =[NSMutableArray array];
    
    _searchVC=[[UISearchController alloc] initWithSearchResultsController:nil];
    _searchVC.delegate= self;
    _searchVC.searchResultsUpdater = self;
    
    _searchVC.searchBar.barTintColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [_searchVC.searchBar setBackgroundImage:[UIImage new]];//去掉黑线
    _searchVC.disablesAutomaticKeyboardDismissal = YES;
    _searchVC.hidesNavigationBarDuringPresentation = YES;
    _searchVC.searchBar.frame = CGRectMake(self.searchVC.searchBar.frame.origin.x, self.searchVC.searchBar.frame.origin.y, self.searchVC.searchBar.frame.size.width, 44);
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchVC.active? self.searchArr.count:self.dataArr.count;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return self.searchVC.active?1:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *textStr;
    if (self.searchVC.active) {
        textStr =[NSString stringWithFormat:@"SEARCH%@",self.searchArr[indexPath.row]];
    }else{
        textStr =[NSString stringWithFormat:@"SEARCH%@",self.dataArr[indexPath.row]];
    }
    cell.textLabel.text = textStr;

    
    return cell;
}

#pragma mark - searchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.edgesForExtendedLayout = UIRectEdgeNone;//不加的话，UISearchBar返回后会上移
    
    
    [_searchVC.searchBar setShowsCancelButton:YES animated:NO];
    UIButton *cancelBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    if (cancelBtn) {
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:66/255.0 green:215/255.0 blue:232/255.0 alpha:1] forState:UIControlStateNormal];
    }
    
    NSString *searchStr = [self.searchVC.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchStr];
    if (self.searchArr!=nil) {
        [self.searchArr removeAllObjects];
    }
    //过滤数据
    self.searchArr = [NSMutableArray arrayWithArray:[self.dataArr filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
}

#pragma mark - search
-(void)willPresentSearchController:(UISearchController *)searchController{
}
-(void)didPresentSearchController:(UISearchController *)searchController{
    self.tableView.frame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
}
-(void)willDismissSearchController:(UISearchController *)searchController{
}
-(void)didDismissSearchController:(UISearchController *)searchController{
    self.tableView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
}
-(void)presentSearchController:(UISearchController *)searchController{
}









































@end
