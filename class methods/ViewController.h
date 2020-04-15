//
//  ViewController.h
//  class methods
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// timer to display restart UIAlert
// note that this is a CLASS property!!!
@property (class, strong, nonatomic) NSTimer *timer;

+ (void)resumeTimer:(NSTimeInterval)seconds;


@end

