#import <Foundation/Foundation.h>
#import <malloc/malloc.h>
#include <stdio.h>

@interface Student : NSObject
@property (nonatomic, strong) NSString *student_name_;
@property (nonatomic, assign) int id_;

- (void)dealloc;
- (instancetype)initWithName:(NSString *)name id:(int)id;
@end

@implementation Student
@synthesize student_name_ = _student_name_, id_ = _id_;
- (void)dealloc {
    printf("deallocated %d\n", _id_);
}
- (instancetype)initWithName:(NSString *)name id:(int)id {
    self = [super init];
    if (self) {
        _student_name_=name;
        _id_ = id;
    }
    return self;
}
@end

Student * createStudent(NSString * name, int id)
{
    Student * stu = [[Student alloc] initWithName: name id: id]; 
    return stu;
}

extern void _objc_autoreleasePoolPrint();

int main(int argc, char * argv[])
{
    __weak NSString *weak_str_release;
    __weak NSString *weak_str_autorelease;
    __weak Student *weak_stu_release;
    __weak Student *weak_stu_autorelease;
    Student * strong_stu_release;

    
    int i = 0;
    //@autoreleasepool
    {
        NSString *const_str = @"常量string-no-release";
        NSString *stack_str = [NSString stringWithFormat: @"111"];
        NSString *heap_str_release = [[NSString alloc] initWithFormat:@"堆区string-release"];
        NSString *heap_str_autorelease = [NSString stringWithFormat:@"堆区string-autorelease"];

        Student * heap_stu_release = [[Student alloc] initWithName: @"张三-student-release" id: i];        
        Student * heap_stu_autorelease = createStudent(@"李四-student-auto-release",  i+1);
        Student * heap_stu_release_2 = [[Student alloc] initWithName: @"王五-student-release" id: i+2];

        printf("const_str size: %lu\n", malloc_size((__bridge const void *)const_str));
        printf("stack_str size: %lu\n", malloc_size((__bridge const void *)stack_str));
        printf("heap_str_release size: %lu\n", malloc_size((__bridge const void *)heap_str_release));
        printf("heap_str_autorelease size: %lu\n", malloc_size((__bridge const void *)heap_str_autorelease));

        printf("heap_stu_release size: %lu\n", malloc_size((__bridge const void *)heap_stu_release));
        printf("heap_stu_autorelease size: %lu\n", malloc_size((__bridge const void *)heap_stu_autorelease));

        weak_str_release = heap_str_release;
        weak_str_autorelease = heap_str_autorelease;
        weak_stu_release = heap_stu_release;
        weak_stu_autorelease = heap_stu_autorelease;
        strong_stu_release = heap_stu_release_2;
        _objc_autoreleasePoolPrint();
    }

    NSLog(@"weak_str_release: %@\n", weak_str_release);
    NSLog(@"weak_str_autorelease: %@\n", weak_str_autorelease);
    NSLog(@"weak_stu_release: %p\n", weak_stu_release);
    NSLog(@"weak_stu_autorelease: %p\n", weak_stu_autorelease);
    NSLog(@"strong_stu_release: %p\n", strong_stu_release);
    _objc_autoreleasePoolPrint();
    printf("finish!!!\n");
    return 0;
}