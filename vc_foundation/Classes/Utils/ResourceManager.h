//
//  ResourceMananger.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 管理工程中的资源（音频文件、数据库、app key、url schema等问题）
 */
@interface ResourceManager : NSObject

/**
 单例

 @return 单实例
 */
+ (instancetype)sharedManager;

/**
 微信Key

 @return 微信Key
 */
- (NSString *)wxKey;

/**
 QQ id

 @return QQ id
 */
- (NSString *)qqID;

/**
 百度统计key

 @return 百度统计Key
 */
- (NSString *)baiduStatKey;

/**
 此应用的Schema

 @return 应用的schema
 */
- (NSString *)schema;

/**
 根据文件名查找相应的音频文件

 @param fileName 音频文件名, 如：`a.mp3`
 @return 文件名所在的URL
 */
- (NSURL *)fileURLForAudioFile:(NSString *)fileName;

/**
 Main Bundle中的内置数据库名字, 如:`WCSL.db`

 @return 数据库名
 */
- (NSString *)databaseName;

/**
 数据库路径

 @return 数据库所在的路径
 */
- (NSString *)pathForDatabase;

/**
 用户状态库名

 @return 路径
 */
- (NSString *)userDatabaseName;

/**
 用户状态库路径

 @return 路径
 */
- (NSString *)pathForUserDatabase;

/**
 应用的AppleID, 用于跳转到app store\支付验证等

 @return appleID
 */
- (NSString *)appleID;

/**
 内建商品, 过审使用

 @return 内建商品ID
 */
- (NSString *)builtInIAPProductID;

/**
 内建金句精练上，过审用

 @return 内建金句精练商品ID
 */
- (NSString *)validSentenceIAPProductID;

/**
 此方法会进行数据库的拷贝、升级处理(用户数据表的导出操作)

 @return 准备是否成功
 */
- (BOOL)prepareBasicDatas;

- (void)prepareSchoolDB;

/**
 友盟统计Key

 @return 返回友盟统计Key
 */
- (NSString *)umKey;
/**
 从本地目录中删除集合中的文件

 @param mediaNames 文件集合
 @return success `YES`, otherwize `NO`
 */
- (BOOL)deleteMedias:(NSArray<NSString *> *)mediaNames;

+ (NSNumber *)totalDiskSpace;
+ (NSNumber *)freeDiskSpace;
+ (NSNumber *)haveUseDiskSpace;
+ (NSString *)infoForUsedDiskSpace;
+ (NSString *)infoForFreeDiskSpace;
+ (UIImage *)avastar;
+ (void)setAvastar:(UIImage *)avastar;

@end
