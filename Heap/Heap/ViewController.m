//
//  ViewController.m
//  Heap
//
//  Created by 珠珠 on 2020/9/23.
//  Copyright © 2020 zhuzhu. All rights reserved.
//

#import "ViewController.h"
#import "Heap.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self heapSort];
    
    [self findTopKItem];

}

// 找出数组中前k大的元素
- (void)findTopKItem{
    
    int a[10] = {1,2,23, 3,4,35, 5,7,10, 33};
    int k = 3;
    
    // 维护一个大小为k的小顶堆,超出时pop,pop出去的就是堆中的最小值,循环完成后,最大的k个元素就保留在堆中了
    Heap * heap = [[Heap alloc] initWithSize:k heapType:HeapSmallTop];
    for (int i = 0; i<10; i++) {
        
        [heap addIntValue:a[i]];
        if (heap.count>k) {
            [heap popTopValue];
        }
        
    }
    
    for (int i = k; i>0; i--) {
        NSLog(@"前%d大的元素: %d",k,heap.popTopValue);
    }
    
}




/*
  堆排序
  */
- (void)heapSort {
 
    int num = 20;
    int a[num];
    
    for (int i = 0; i<num; i++) {
        a[i] = arc4random()%(num*10);
        printf("%d -> ",a[i]);
    }
    printf("初始化完成\n");
    // 开始排序,小顶堆
//    Heap * heap = [[Heap alloc] initWithArray:a Size:num heapType:HeapSmallTop];
//    for (int i = 0; i<num; i++) {
//         a[i] = heap.popTopValue;
//     }
    
    // 开始排序,大顶堆
    Heap * heap = [[Heap alloc] initWithArray:a Size:num heapType:HeapBigTop];
    for (int i = num-1; i>=0; i--) {
         a[i] = heap.popTopValue;
     }
    
    for (int i = 0; i<num; i++) {
        printf("%d -> ",a[i]);
    }
    printf("排序完成\n");
    for (int i = 0; i<num-1; i++) {
        if (a[i]>a[i+1]) {
            NSLog(@"出错了 %d",i);
            NSAssert(NO, @"排序不对");
        }
        
    }
    
}



@end
