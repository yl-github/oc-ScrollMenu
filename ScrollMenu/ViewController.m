//
//  SearchViewController.m
//  QFB
//
//  Created by yl on 2016/11/2.
//  Copyright © 2016年 shujuyun. All rights reserved.
//

#import "ViewController.h"
#import "PageTitleView.h"
#import "PageContentView.h"

#define kTitleViewH 50
@interface ViewController ()<PageContentViewDelegate,PageTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) PageTitleView *titleView;
@property (nonatomic,strong) PageContentView *pageContentView;
@end

@implementation ViewController
// 懒加载初始化数组
- (NSMutableArray *)childVcs
{
    if (!_childVcs) {
        self.childVcs = [NSMutableArray arrayWithCapacity:2];
    }
    return _childVcs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 不需要调整UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
    
    
}
- (void)setupUI {
    // 添加titleView
    NSArray *titlesArr = @[@"最近搜索",@"浏览记录"];
    PageTitleView *titleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarH + kNavigationBarH, kScreenW, kTitleViewH) titles:titlesArr];
    titleView.delegate = self;
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    // 添加pageContentView
    [self addPageContentView];
}

- (void)addPageContentView
{
    CGFloat contentViewH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH;
    CGRect contentViewFrame = CGRectMake(0, kStatusBarH + kNavigationBarH + kTitleViewH, kScreenW, contentViewH);
    for (int i = 0; i < 2; i++) {
        UIViewController *VC = [[UIViewController alloc] init];
        [self.childVcs addObject:VC];
    }
    PageContentView *pageContentView = [[PageContentView alloc] initWithFrame:contentViewFrame childVcs:self.childVcs parentViewController:self];
    pageContentView.delegate = self;
    self.pageContentView = pageContentView;
    
    [self.view addSubview:pageContentView];
}

#pragma mark ----- 代理
- (void)pageContentViewProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex
{
    [self.titleView setTitleChangeProgress:progress beforeIndex:beforIndex targetIndex:targetIndex];
}

- (void)pageTitleViewCurrentIndex:(NSInteger)currentIndex
{
    [self.pageContentView setPageContentViewChangeCurrentIndex:currentIndex];
}


@end
