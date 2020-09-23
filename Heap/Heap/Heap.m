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
    self = [super init];
    if (self) {
        
        _size = size;
        if (size<100) {
            _size = 100;
        }
        
        heap = (int * ) malloc(_size * sizeof(int));
        // 把数组中的数据copy到堆上
        memcpy(heap, array, (size * sizeof(int)));
        indexNum = size;
        _type = type;
        
        // 初始化堆, 假设有一种最差的情况,初始化的时候堆顶为最小元素, 此时需要把最小元素放到叶子节点上,每次循环都会把最小元素下移一层,需要循环的次数为树的深度
        int leftNum = size;
        while (leftNum>0) {
            // 把最小的元素向下移动一层,循环次数为完全二叉树的深度
            [self initHeap];
            leftNum /=2;
        }
        
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
        memcpy(newHeap, heap, (indexNum-1)*sizeof(int));
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
    if (indexNum<_size/4&&_size>=100) {
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


/// 重新构造堆 : 比较并调整使当前节点的值与左右叶子
- (void)initHeap {
    // 从第一个有叶子的节点开始
    for (int i = indexNum/2-1; i>=0; i--) {
        int left = 2*i+1;
        int right = 2*i+2;
        //  (大顶堆&&i<左叶子,进行交换) || (小顶堆&&i>左叶子,进行交换)
        if ( (_type==HeapBigTop && heap[i]<heap[left]) || (_type==HeapSmallTop && heap[i]>heap[left]) ) {
            int temp = heap[i];
            heap[i] = heap[left];
            heap[left] = temp;
        }
        // right节点可能是没有值的
        if (right>=indexNum) {
            continue;
        }
        
        //  (大顶堆&&i<右叶子,进行交换) || (小顶堆&&i>右叶子,进行交换)
        if ( (_type==HeapBigTop && heap[i]<heap[right]) || (_type==HeapSmallTop && heap[i]>heap[right]) ) {
            int temp = heap[i];
            heap[i] = heap[right];
            heap[right] = temp;
        }
        
    }
}


/// 重构堆, 把堆顶元素放到堆中的合适位置
- (void)rebuildHeap {

    // 堆在前面已经初始化完成了,但是进行了add/pop操作,需要重新构建堆,堆顶元素是一个比较小的值,需要重新再堆中找合适的位置
    // 从第一个根节点开始构建,然后构建左子树或者右子树,
    // 比如堆顶为3, 左节点为5,右节点为7, 此时把堆顶和右节点交换, 重构右子树,左子树不需要处理, 这样时间复杂度度就是O(logN)
    int nextIndex = 0; // 下一个要重构的节点
    // 最后一个带叶子的节点endIndex/2-1,
    for (int i = 0; i<=indexNum/2-1; i=nextIndex) {
        int left = 2*i+1;
        int right = 2*i+2;
        
        // 找出左右节点中需要交换的那个,大顶堆,找大节点; 小顶堆,找小节点
        nextIndex = left;
        // 大顶堆 && 有右节点 && 右节点>左节点
        if (_type==HeapBigTop && right<indexNum && heap[left] < heap[right] ) {
            nextIndex = right;
        }
        // 小顶堆 && 有右节点 && 右节点<左节点
        if (_type == HeapSmallTop && right<indexNum && heap[left] > heap[right] ) {
            nextIndex = right;
        }
        // 现在nextIndex就是是否要交换的节点了
        
        
        if (_type==HeapBigTop) {
            
            if (heap[i]<heap[nextIndex]) {
                int temp = heap[i];
                heap[i] = heap[nextIndex];
                heap[nextIndex] = temp;
            } else {
                // 说明 已经满足条件了, 节点>左节点 && 节点>右节点, 堆顶元素找到了合适的位置, 结束循环
                break;
            }
            
        }
        
        if (_type==HeapSmallTop) {
            
            if (heap[i]>heap[nextIndex]) {
                int temp = heap[i];
                heap[i] = heap[nextIndex];
                heap[nextIndex] = temp;
            } else {
                // 说明 小顶堆已经满足条件了, 节点<左节点 && 节点<右节点, 堆顶元素找到了合适的位置, 结束循环
                break;
            }
            
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
