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
    
    
}

- (void)heapSort {
    /*
     堆排序
     */
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
