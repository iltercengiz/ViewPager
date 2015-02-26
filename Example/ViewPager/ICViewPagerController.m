//
//  ICViewPagerController.m
//  ViewPager
//
//  Created by Ilter Cengiz on 26/02/15.
//  Copyright (c) 2015 Ilter Cengiz. All rights reserved.
//

#import "ICViewPagerController.h"

@interface ICViewPagerController () <ViewPagerControllerDataSource>

@property (nonatomic) NSMutableArray *cache;

@end

@implementation ICViewPagerController

#pragma mark - View life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"View Pager";
    
    self.cache = [NSMutableArray arrayWithCapacity:10];
    
    for (NSInteger index = 0; index < 10; index++) {
        [self.cache addObject:[NSNull null]];
    }
    
    self.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View pager controller data source

- (UIViewController *)viewPagerController:(ViewPagerController *)viewPagerController controllerForTabAtIndex:(NSUInteger)index {
    
    UIViewController *vc;
    
    if ([[self.cache objectAtIndex:index] isEqual:[NSNull null]]) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
        
        vc.view.backgroundColor = [UIColor colorWithWhite:244.0/255.0 alpha:1.0];
        
        UILabel *label = (UILabel *)[vc.view viewWithTag:1];
        label.text = [NSString stringWithFormat:@"%li", index];
    } else {
        vc = [self.cache objectAtIndex:index];
    }
    
    return vc;
    
}

- (UIView *)viewPagerController:(ViewPagerController *)viewPagerController viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *l;
    
    if ([[self.cache objectAtIndex:index] isEqual:[NSNull null]]) {
        l = [UILabel new];
        
        l.backgroundColor = [UIColor colorWithWhite:192.0/255.0 alpha:1.0];
        l.text = [NSString stringWithFormat:@"%li", index];
        l.textAlignment = NSTextAlignmentCenter;
        
        [l sizeToFit];
    } else {
        l = [self.cache objectAtIndex:index];
    }
    
    return l;
    
}

- (NSInteger)numberOfTabsInViewPagerController:(ViewPagerController *)viewPagerController {
    return 10;
}

@end
