In Objective-C, a common yet subtle error arises when dealing with memory management using ARC (Automatic Reference Counting).  Specifically, strong reference cycles can occur unexpectedly within blocks or closures. Consider this example:

```objectivec
@interface MyClass : NSObject
@property (strong, nonatomic) NSString *myString;
@end

@implementation MyClass
- (void)doSomething {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        [self.myString stringByAppendingString:@"New Text"]; //Potential strong reference cycle
    });
}
@end
```

The problem lies in the block within `doSomething`.  If `self` (the MyClass instance) retains the block implicitly (as it might within certain contexts such as a GCD block), and the block strongly captures `self` (which it implicitly does through `self.myString`), a retain cycle is created. Neither object can be deallocated, leading to memory leaks.