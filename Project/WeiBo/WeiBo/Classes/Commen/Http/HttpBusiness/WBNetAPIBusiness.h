//
//  WBNetAPIBusiness.h
//  WeiBo
//
//  Created by wbs on 17/2/10.
//  Copyright © 2017年 xiaomaolv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBHomeStatusesParamter;
@class WBHomeStatusesResult;

@class WBUserContentParamter;
@class WBUserContentResult;

@interface WBNetAPIBusiness : NSObject


+ (void)currentUserContent:(WBUserContentParamter *)paramter completion:(void(^)(WBUserContentResult *result, NSError *error))completion; // 返回当前用户的个人信息

+ (void)homeStatuses:(WBHomeStatusesParamter *)paramter completion:(void(^)(WBHomeStatusesResult *result, NSError *error))completion; // 返回当前用户的最新的微博

@end
