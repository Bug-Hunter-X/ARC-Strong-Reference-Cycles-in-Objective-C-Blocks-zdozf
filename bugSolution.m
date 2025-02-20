@interface MyClass : NSObject
@property (strong, nonatomic) NSString *myString;
@end

@implementation MyClass
- (void)doSomething {
    __weak MyClass *weakSelf = self; // Create a weak reference to self
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        MyClass *strongSelf = weakSelf; // Create a strong reference if needed inside the block
        if (strongSelf) { // Check if self is still valid before accessing self.myString
            [strongSelf.myString stringByAppendingString:@"New Text"];
        }
    });
}
@end

By using `__weak` we prevent the block from strongly capturing `self`. The `strongSelf` variable within the block ensures `self.myString` can be accessed safely.  The `if (strongSelf)` check guards against accessing `self.myString` after `self` has been deallocated.