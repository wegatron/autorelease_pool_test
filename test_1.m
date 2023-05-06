#import <Foundation/Foundation.h>
#include <stdio.h>

@interface Student : NSObject
@property (nonatomic, strong) NSString *student_name_;
@property (nonatomic, assign) int id_;

- (void)dealloc;
@end

@implementation Student
@synthesize student_name_ = _student_name_, id_ = _id_;

- (void)dealloc {
    printf("deallocated %d\n", _id_);
}
@end

extern void _objc_autoreleasePoolPrint();

int main(int argc, char * argv[])
{
    @autoreleasepool
    {
        for(int i=0; i<3; ++i)
        {
            printf("init %d\n", i);
            Student *stu = [Student new];
            stu.student_name_ = @"张三";
            stu.id_ = i;  
        }
        _objc_autoreleasePoolPrint();
    }
    printf("finish!!!\n");
    return 0;
}