//
//  Heap.m
//  算法
//
//  Created by 珠珠 on 2020/7/6.
//  Copyright © 2020 zhuzhu. All rights reserved.
//

#import "Heap.h"

@interface Heap ()
{
    // 用数组做堆结构, 
    int *heap;
    // 指向最后一个元素后面的位置,heap[indexNum]总是为空
    int indexNum ;
}
// 堆中最大能放多少元素
@property (nonatomic, assign) int size;
@property (nonatomic, assign) HeapType type;


@end


@implementation Heap

/// 把数组放入到堆中,并构建一次
- (instancetype)initWithArray:(int [])array Size:(int)size heapType:(HeapType)type {
    self = [self initWithSize:size+1];
    if (self) {
        
        heap = (int * ) malloc(size * sizeof(int));
        // 把数组中的数据copy到堆上
        memcpy(heap, array, size);
        indexNum = size;
        _type = type;
        [self rebuildHeap];
    }
    return self;
}

- (instancetype)init{
    return [self initWithSize:100];
}


- (instancetype)initWithSize:(int)size {
    self = [super init];
    if (self) {
        if (size<=0) {
            size = 100;
        }
        _size = size;
        heap = (int * ) malloc(size * sizeof(int));
        indexNum = 0;
    }
    return self;
}

- (int)count {
    return indexNum;
}
- (int)topValue {

    if (indexNum == 0) {
        NSLog(@"已经是空堆了");
        return NAN;
    }
    return heap[0];
}
- (HeapType)type{
    return _type;
}


/// 把数字放入堆中,需要重新构造堆
- (void)addIntValue:(int)newValue {
    
    
    // 如果超出了,需要扩容, 容量增加1倍, 把旧数据移动到新数组中
    if (indexNum+1>_size) {
        _size *= 2;
        int * newHeap = (int * ) malloc(_size * sizeof(int));
        // 把原来数组中的数据copy到新的数组上
        memcpy(newHeap, heap, indexNum+1);
//        for (int i = 0; i<indexNum; i++) {
//
//            newHeap[i] = heap[i];
//        }
        free(heap);
        heap = newHeap;
        
    }
    
    
    heap[indexNum] = newValue;
    indexNum ++;
    [self rebuildHeap];
    
    NSLog(@"addIntValue  %d",newValue);
    NSLog(@"rebuildHeap  %@",self);

}

/// 返回堆中最大元素
- (int)popTopValue {
    
    if (indexNum == 0) {
        NSLog(@"已经是空堆了");
        return NAN;
    }
    
     // 如果堆中数字已经很少了,需要收回部分内存, 容量减少1倍, 把旧数据移动到新数组中
    if (indexNum<_size/4&&_size>100) {
        _size /= 2;
        
        int * newHeap = (int * ) malloc(_size * sizeof(int));
        for (int i = 0; i<indexNum; i++) {
            
            newHeap[i] = heap[i];
        }
        free(heap);
        heap = newHeap;
    }
    
    
    int result = heap[0];
    indexNum--;
    heap[0] = heap[indexNum];
    
    [self rebuildHeap];
    return result;
    
}


/// 重新构造大顶堆 : 比较并调整使当前节点的值大于左右叶子
- (void)rebuildHeap {
    // 从第一个有叶子的节点开始
    for (int i = indexNum/2-1; i>=0; i--) {
        int left = 2*i+1;
        int right = 2*i+2;
        // 保证 i>左叶子,
        if (heap[i]<heap[left]) {
            int temp = heap[i];
            heap[i] = heap[left];
            heap[left] = temp;
        }
        // right节点可能是没有值的
        if (right>=indexNum) {
            continue;
        }
        
        // 保证i>右叶子
        if (heap[i]<heap[right]) {
            int temp = heap[i];
            heap[i] = heap[right];
            heap[right] = temp;
        }
        
    }
}

- (NSString *)description {
    
    NSString * str = @"";
    for (int i = 0; i<indexNum; i++) {
        str = [str stringByAppendingFormat:@"%d  ",heap[i]];
    }
    return str;
}


- (void)dealloc {
    free(heap);
    heap = NULL;
}

@end
