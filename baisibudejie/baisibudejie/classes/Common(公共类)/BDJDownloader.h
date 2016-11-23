//
//  BDJDownloader.h
//  baisibudejie
//
//  Created by HJY on 2016/11/22.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import <Foundation/Foundation.h>

//将block定义成一个类型
typedef void(^SUCCESS_BLOCK)(NSData *data);
typedef void(^FAIL_BLOCK)(NSError *error);

@interface BDJDownloader : NSObject

+ (void)downloadWithURLString:(NSString *)urlString success:(void(^)(NSData *data))finishBlock fail:(void(^)(NSError *error))failBlock;

//参数名可以省略，下面这么写也可以
//+ (void)downloadWithURLString:(NSString *)urlString success:(void(^)(NSData *))finishBlock fail:(void(^)(NSError *))failBlock;


//也可以这么写
//+ (void)downloadWithURLString:(NSString *)urlString success:(SUCCESS_BLOCK)finishBlock fail:(FAIL_BLOCK)failBlock;

@end
