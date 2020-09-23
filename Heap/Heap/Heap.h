//
//  Heap.h
//  算法
//
//  Created by 珠珠 on 2020/7/6.
//  Copyright © 2020 zhuzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HeapType) {
    HeapBigTop,// 默认大顶堆
    HeapSmallTop,// 小顶堆
};

NS_ASSUME_NONNULL_BEGIN

/// 做一个堆结构, https://blog.csdn.net/u014600626/article/details/103752297
@interface Heap : NSObject

/// 查看堆中元素的数量
@property (nonatomic, readonly,assign) int count;
/// 查看堆顶的值
@property (nonatomic, readonly,assign) int topValue;
/// 堆的类型,一旦设置就不允许更改了
@property (nonatomic, readonly,assign) HeapType type;


/// 把数组放入到堆中,并完成构建
- (instancetype)initWithArray:(int [_Nonnull])array Size:(int)size heapType:(HeapType)type;

/// 默认size=100, 堆中可放100个元素
- (instancetype)initWithSize:(int)size heapType:(HeapType)type;

/// 把数字放入堆中, 并重构堆
- (void)addIntValue:(int)newValue ;

/// 移除堆中最大元素并重构堆
- (int)popTopValue ;
    

@end

NS_ASSUME_NONNULL_END
