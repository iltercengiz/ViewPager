
// To check if a library is compiled with CocoaPods you
// can use the `COCOAPODS` macro definition which is
// defined in the xcconfigs so it is available in
// headers also when they are imported in the client
// project.


// ViewPager
#define COCOAPODS_POD_AVAILABLE_ViewPager
#define COCOAPODS_VERSION_MAJOR_ViewPager 0
#define COCOAPODS_VERSION_MINOR_ViewPager 1
#define COCOAPODS_VERSION_PATCH_ViewPager 0

// Debug build configuration
#ifdef DEBUG

  // Reveal-iOS-SDK
  #define COCOAPODS_POD_AVAILABLE_Reveal_iOS_SDK
  #define COCOAPODS_VERSION_MAJOR_Reveal_iOS_SDK 1
  #define COCOAPODS_VERSION_MINOR_Reveal_iOS_SDK 5
  #define COCOAPODS_VERSION_PATCH_Reveal_iOS_SDK 1

#endif
