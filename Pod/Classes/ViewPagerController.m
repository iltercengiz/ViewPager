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

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (nonatomic) NSInteger numberOfTabs;

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (nonatomic) NSUInteger currentIndex;

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (nonatomic) NSMutableArray *viewControllers;

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
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor clearColor];
    
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.pageViewController willMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Create and add collection view controller
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionViewController = [[UICollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    self.collectionViewController.collectionView.dataSource = self;
    self.collectionViewController.collectionView.delegate = self;
    
    self.collectionViewController.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionViewController.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionViewController.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.collectionViewController.collectionView];
    
#if DEBUG
    self.pageViewController.view.backgroundColor = [UIColor colorWithRed:0.27 green:0.37 blue:0.46 alpha:1];
    self.collectionViewController.collectionView.backgroundColor = [UIColor colorWithRed:0.36 green:0.47 blue:0.71 alpha:1];
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
    
    // Register tab cell for collection view
    [self.collectionViewController.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TabCollectionViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (void)setDataSource:(id<ViewPagerControllerDataSource>)dataSource {
    // Set the new data source
    _dataSource = dataSource;
    
    // Reload data
    [self reloadData];
}

#pragma mark - Public methods

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (void)reloadData {
    
    // Set current index to zero
    self.currentIndex = 0;
    
    // Get number of tabs
    if ([self.dataSource respondsToSelector:@selector(numberOfTabsInViewPagerController:)]) {
        self.numberOfTabs = [self.dataSource numberOfTabsInViewPagerController:self];
    } else {
        self.numberOfTabs = 0;
    }
    
    // Reload tabs
    [self.collectionViewController.collectionView reloadData];
    
    // Reload pages
    if ([self.dataSource respondsToSelector:@selector(viewPagerController:controllerForTabAtIndex:)] && self.numberOfTabs != 0) {
        
        self.viewControllers = [NSMutableArray arrayWithCapacity:self.numberOfTabs];
        
        for (NSInteger index = 0; index < self.numberOfTabs; index++) {
            [self.viewControllers addObject:[NSNull null]];
        }
        
        UIViewController *viewController = [self viewControllerAtIndex:0];
        
        [self.viewControllers replaceObjectAtIndex:0 withObject:viewController];
        
        [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
    } else {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor clearColor];
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    
}

#pragma mark - Private methods

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    
    if ([viewController isEqual:[NSNull null]]) {
        
        if ([self.dataSource respondsToSelector:@selector(viewPagerController:controllerForTabAtIndex:)]) {
            viewController = [self.dataSource viewPagerController:self controllerForTabAtIndex:index];
            [self.viewControllers replaceObjectAtIndex:index withObject:viewController];
        } else {
            @throw [NSException exceptionWithName:@"Could not get a view controller from dataSource exception" reason:@"Data source is not available or does not implement -viewPagerController:controllerForTabAtIndex: to get the view controller at index" userInfo:nil];
        }
        
    }
    
    return viewController;
    
}

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    return [self.viewControllers indexOfObject:viewController];
}

#pragma mark - Collection view data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TabCollectionViewCell" forIndexPath:indexPath];
    
    UIView *tabView = [cell viewWithTag:1];
    
    if (tabView) {
        [tabView removeFromSuperview];
    }
    
    if ([self.dataSource respondsToSelector:@selector(viewPagerController:viewForTabAtIndex:)]) {
        tabView = [self.dataSource viewPagerController:self viewForTabAtIndex:indexPath.item];
        
        tabView.frame = cell.bounds;
        tabView.tag = 1;
        
        [cell addSubview:tabView];
    } else {
        @throw [NSException exceptionWithName:@"nil view for tab at index" reason:[NSString stringWithFormat:@"There should not be any nil view for tab within the given range, that is 0 to numberOfTabsInViewPagerController:! Index %li", self.currentIndex] userInfo:nil];
    }
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfTabs;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(viewPagerController:didSelectTabAtIndex:)]) {
        [self.delegate viewPagerController:self didSelectTabAtIndex:indexPath.item];
    }
    
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = 96.0;
    
    if ([self.dataSource respondsToSelector:@selector(viewPagerController:widthForTabAtIndex:)]) {
        width = [self.dataSource viewPagerController:self widthForTabAtIndex:indexPath.item];
    }
    
    return CGSizeMake(width, CGRectGetHeight(self.collectionViewController.collectionView.frame));
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    index--;
    
    if (index < self.viewControllers.count) {
        return [self viewControllerAtIndex:index];
    } else {
        return nil;
    }
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    index++;
    
    if (index < self.viewControllers.count) {
        return [self viewControllerAtIndex:index];
    } else {
        return nil;
    }
    
}

#pragma mark - Page view controller delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    
    
}

@end
