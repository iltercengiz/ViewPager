//
//  ICViewPagerController.m
//  ViewPager
//
//  Created by Ilter Cengiz on 26/02/15.
//  Copyright (c) 2015 Ilter Cengiz. All rights reserved.
//

#import "ICViewPagerController.h"

@interface ICViewPagerController () <ViewPagerControllerDataSource>

@end

@implementation ICViewPagerController

#pragma mark - View life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"View Pager";
    
    self.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View pager controller data source

- (UIViewController *)viewPagerController:(ViewPagerController *)viewPagerController controllerForTabAtIndex:(NSUInteger)index {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];;
    
    vc.view.backgroundColor = [UIColor colorWithWhite:244.0/255.0 alpha:1.0];
    
    UILabel *label = (UILabel *)[vc.view viewWithTag:1];
    label.text = [NSString stringWithFormat:@"%li", index];
    
    return vc;
    
}

- (UIView *)viewPagerController:(ViewPagerController *)viewPagerController viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *l = [UILabel new];
    
    l.backgroundColor = [UIColor colorWithWhite:192.0/255.0 alpha:1.0];
    l.text = [NSString stringWithFormat:@"%li", index];
    l.textAlignment = NSTextAlignmentCenter;
    
    [l sizeToFit];
    
    return l;
    
}

- (NSInteger)numberOfTabsInViewPagerController:(ViewPagerController *)viewPagerController {
    return 10;
}

@end
