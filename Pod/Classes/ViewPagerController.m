//
//  ViewPagerController.m
//  Pods
//
//  Created by Ilter Cengiz on 26/02/15.
//
//

#import "ViewPagerController.h"

@interface ViewPagerController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (nonatomic) UIPageViewController *pageViewController;

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (nonatomic) UICollectionViewController *collectionViewController;

@end

@implementation ViewPagerController

#pragma mark - View life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Create and add page view controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionInterPageSpacingKey: @2.0}];
    
    self.pageViewController.dataSource = self;
    
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.pageViewController willMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Create and add collection view controller
    self.collectionViewController = [[UICollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    
    self.collectionViewController.collectionView.dataSource = self;
    self.collectionViewController.collectionView.delegate = self;
    
    self.collectionViewController.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionViewController.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.collectionViewController.collectionView];
    
#if DEBUG
    self.pageViewController.view.backgroundColor = [UIColor greenColor];
    self.collectionViewController.collectionView.backgroundColor = [UIColor blueColor];
#endif
    
    // Add constraints
    NSDictionary *views = @{@"pageView": self.pageViewController.view,
                            @"collectionView": self.collectionViewController.collectionView,
                            @"topLayoutGuide": self.topLayoutGuide};
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[collectionView(49)]" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-0-[collectionView]-0-[pageView]-0-|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pageView]-0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:constraints];
    
    [self.view setNeedsLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection view data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

#pragma mark - Collection view delegate

#pragma mark - Collection view delegate flow layout

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return nil;
}

#pragma mark - Page view controller delegate

@end
