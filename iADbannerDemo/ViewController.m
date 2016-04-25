//
//  ViewController.m
//  iADbannerDemo
//
//  Created by lanmao on 16/3/19.
//  Copyright © 2016年 小霸道. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
@interface ViewController ()<UIScrollViewDelegate,ADBannerViewDelegate>
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64 )];
    [self.view addSubview:self.scrollView];
    self.pageControl.numberOfPages = 4;
    self.scrollView.frame = self.view.frame;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.delegate = self;
    CGSize result = [UIScreen mainScreen].bounds.size;
    int statusBarHeight = 20;
    
    CGFloat height = result.height - statusBarHeight - 40;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        height = result.height - 40;
    }
    
    self.scrollView.contentSize = CGSizeMake(4 * 320, height);
    self.page1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, result.width, height)];
    self.page1.image = [UIImage  imageNamed:@"shoujiqq"];
    [self.scrollView addSubview:self.page1];
    
    self.page2 = [[UIImageView alloc] initWithFrame:CGRectMake(result.width * 1, 0, result.width, height)];
    self.page2.image = [UIImage  imageNamed:@"shoucang_select"];
    [self.scrollView addSubview:self.page2];
    
    self.page3 = [[UIImageView alloc] initWithFrame:CGRectMake(result.width * 2, 0, result.width, height)];
    self.page3.image = [UIImage  imageNamed:@"service_select"];
    [self.scrollView addSubview:self.page3];
    
    self.page4 = [[UIImageView alloc] initWithFrame:CGRectMake(result.width * 3, 0, result.width, height)];
    self.page4.image = [UIImage  imageNamed:@"searchLogo"];
    [self.scrollView addSubview:self.page4];

    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        
        self.bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        self.bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }else
    {
        self.bannerView = [[ADBannerView alloc] init];
    }
    
    self.bannerView .delegate = self;
    
    [self.view insertSubview:self.bannerView aboveSubview:self.scrollView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s",__func__);
}
- (void)layoutAnimated:(BOOL)animated
{
#if  __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    CGRect contentFrame = self.view.frame;
    if (contentFrame.size.width < contentFrame.size.height) {
        
        self.bannerView .currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }else
    {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
    
#endif
    
    CGRect bannerFrame = _bannerView.frame;
    
    if (self.bannerView.bannerLoaded) {
        
        bannerFrame.origin.y = 0;
    }else
    {
        bannerFrame.origin.y -=self.bannerView.frame.size.height;
    }
    
    [UIView animateWithDuration:animated?0.25:0.0  animations:^{
       
        self.bannerView.frame = bannerFrame;
    }];
}
#if  __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
#endif
- (NSInteger)supportedInterfaceOrientation
{
    NSLog(@"%s",__func__);
    return UIInterfaceOrientationMaskAll;
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"%s",__func__);
    [MBProgressHUD hideHUDForView:self.view animated:YES ];
    [self layoutAnimated:YES];
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
    [self layoutAnimated:YES];
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"%s",__func__);
    
    [self layoutAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
