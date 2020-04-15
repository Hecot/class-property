# class-property
Example how to use class properties and methods in Objective C

In this example I show you how to use class property and class methods in  a simple project. 

Since Xcode 8 you can define a class property in the header file of YourClass, using the "class" identifier like:

        @interface YourClass : NSObject

        @property (class, strong, nonatomic) NSTimer *timer;

        @end
To use the class property in class methods in your implementation you need to asign a static instance variable to your class property. This allows you to use this instance variable in class methods (class methods start with "+").

        @implementation YourClass

static NSTimer *_timer;
You have to create getter and setter methods for the class property, as these will not be synthesized automatic.

        + (void)setTimer:(NSTimer*)newTimer{
            if (_timer == nil)
            _timer = newTimer;
        }

        + (NSTimer*)timer{
            return _timer;
        }

        // your other code here ...

        @end
Now you can access the class property from all over the app and other methods with the following syntax - here are some examples:

        NSTimeInterval seconds = YourClass.timer.fireDate.timeIntervalSinceNow;

        [[YourClass timer] invalidate];
        You will always send messages to the same object, no problems with multiple instances!



# class-methods

To call another class's method you could simply do this throughout the app:

        NSObject *newClass = [[YourClass alloc]init];

        [newClass resumeTimer];

The only problematic side effect is that you will get a new instance of your class!

Sometimes this doesn't matter and could work fine, but when your class has an initializer like UIViewController for example this could cause your app to crash.

A better way is to define the method you want to call from outside as a class method! You do this in your header (class methods start with "+") and also in the corresponding implementation !

        @interface YourClass : NSObject

        + (void)resumeTimer;

        @end
Now you can call the method from all over your app and from other methods with the following syntax:

        [YourClass resumeTimer];
        
There is only one side effect you need to know! Inside the class methods implementation you can only use static variables! So if your method process any information from the outside you would need to make this variable static like this:

        @implementation

        static NSTimeInterval seconds;

        + (void)resumeTimer{

            NSLog(@"resume playing time: %f",seconds);

        }

        .... more code here ....

        @end
