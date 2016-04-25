//
//  ViewController.h
//  iADbannerDemo
//
//  Created by lanmao on 16/3/19.
//  Copyright © 2016年 小霸道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) UIImageView *page1;
@property (nonatomic,strong) UIImageView *page2;
@property (nonatomic,strong) UIImageView *page3;
@property (nonatomic,strong) UIImageView *page4;
@property (nonatomic,strong) ADBannerView *bannerView;
 
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;


@end

