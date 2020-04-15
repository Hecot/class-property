//
//  ViewController.m
//  class methods
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // storing self in static variable to be used as target on timer restart
    contr = self;
    
    [self restartAlert];
    
}

// We asign a instance variable from class variable and declare them as static
// so we can use it in class methods

static NSTimer *_timer;
static UIViewController *contr;

// we have to create custom getter and setter methods for class variable
+ (void)setTimer:(NSTimer*)newTimer{
    if (_timer == nil)
        _timer = newTimer;
}

+ (NSTimer*)timer{
    return _timer;
}


// in case we awake from background the timer needs to start again

// This is a class method to be called from Scene delegate, problem is to pass self
// because self would be the the class inside class methods and we can not
// use an instance variable for target, so we need to store a static variable "contr"
// before to pass as target

+ (void)resumeTimer:(NSTimeInterval)seconds {

    NSLog(@"resume timer at: %f",seconds);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ViewController.timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                                     target:contr // here we pass the static self
                                                   selector:@selector(restartAlert)
                                                   userInfo:nil
                                                    repeats:NO]; // only one time!!!
            
    });
}

- (void)restartAlert{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"End of time"
                                      message:@"Do you want to restart timer?"
                                      preferredStyle:UIAlertControllerStyleAlert];
         
        UIAlertAction* yes = [UIAlertAction
                             actionWithTitle:@"YES"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                    [self startTimer];
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                             }];

         
        [alert addAction:yes];
        alert.preferredAction = yes;
        
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)startTimer{
    
    NSTimeInterval startTime = 10.0;
    
    NSLog(@"start timer with: %f",startTime);
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                             target:self
                                        selector:@selector(restartAlert)
                                           userInfo:nil
                                            repeats:NO]; // only one time!!!
}

@end
