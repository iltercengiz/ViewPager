//
//  ViewPagerController.h
//  Pods
//
//  Created by Ilter Cengiz on 26/02/15.
//
//

#import <UIKit/UIKit.h>

@protocol ViewPagerControllerDataSource;
@protocol ViewPagerControllerDelegate;

@interface ViewPagerController : UIViewController

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (weak, nonatomic) id<ViewPagerControllerDataSource> dataSource;

/**
 <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
@property (weak, nonatomic) id<ViewPagerControllerDelegate> delegate;

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (void)reloadData;

@end

@protocol ViewPagerControllerDataSource <NSObject>

@required

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (UIViewController *)viewPagerController:(ViewPagerController *)viewPagerController controllerForTabAtIndex:(NSUInteger)index;

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (UIView *)viewPagerController:(ViewPagerController *)viewPagerController viewForTabAtIndex:(NSUInteger)index;

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (NSInteger)numberOfTabsInViewPagerController:(ViewPagerController *)viewPagerController;

@optional

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (CGFloat)viewPagerController:(ViewPagerController *)viewPagerController widthForTabAtIndex:(NSUInteger)index;

@end

@protocol ViewPagerControllerDelegate <NSObject>

@optional

/**
 <#description#>
 
 @param <#parameter#> <#description#>
 
 @return <#description#>
 
 @see <#selector#>
 @warning <#description#>
 */
- (void)viewPagerController:(ViewPagerController *)viewPagerController didSelectTabAtIndex:(NSUInteger)index;

@end
