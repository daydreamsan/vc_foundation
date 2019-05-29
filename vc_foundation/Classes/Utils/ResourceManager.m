//
//  ResourceMananger.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "ResourceManager.h"
#import "UserDefaultsUtility.h"
#import "Env.h"
#import "../VCFKFoundation.h"

const NSString *const RM_WXAppKey               = @"RM_WXAppKey";
const NSString *const RM_BaiduStatKey           = @"RM_BaiduStatKey";
const NSString *const RM_Schema                 = @"RM_Schema";
const NSString *const RM_DefaultIAPProduct      = @"RM_DefaultIAPProduct";
const NSString *const RM_ValidSentenceProduct   = @"RM_ValidSentenceProduct";
const NSString *const RM_MediaName              = @"RM_MediaName";
const NSString *const RM_DatabaseName           = @"RM_DatabaseName";
const NSString *const RM_UserDatabaseName       = @"RM_UserDatabaseName";
const NSString *const RM_AppleID                = @"RM_AppleID";
const NSString *const RM_QQAppID                = @"RM_QQAppID";
const NSString *const RM_UMAppKey               = @"RM_UMAppKey";

@implementation ResourceManager
{
    NSDictionary *_resourceDict;
}

- (instancetype)init {
    if (self = [super init]) {
        _resourceDict = configuration_dict();
    }
    return self;
}

+ (instancetype)sharedManager {
    static ResourceManager *mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[ResourceManager alloc] init];
    });
    return mgr;
}

- (NSString *)wxKey {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_WXAppKey];
    return key;
}

- (NSString *)qqID {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_QQAppID];
    return key;
}

- (NSString *)baiduStatKey {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_BaiduStatKey];
    return key;
}

- (NSString *)schema {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_Schema];
    return key;
}

- (NSString *)mediaName {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_MediaName];
    return key;
}

- (NSBundle *)mediaBundle {
    NSString *mediaName = [self mediaName];
    NSString *soundBundlePath = [[NSBundle mainBundle] pathForResource:mediaName ofType:nil];
    if (soundBundlePath.length == 0) {
        return nil;
    }
    NSBundle *soundBundle = [NSBundle bundleWithPath:soundBundlePath];
    return soundBundle;
}

- (NSURL *)fileURLForAudioFile:(NSString *)fileName {
    
    if (fileName.length == 0) {
        return nil;
    }
    //[0].判断是否为网络文件
    if ([fileName hasPrefix:@"http"]) {
        NSString *urlString = [fileName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //>[1].到/Documents/offline_media/sound/目录下找
    NSString *DIR = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *internalDIR = [DIR stringByAppendingPathComponent:@"offline_media/sound"];
    NSString *p_ = [internalDIR stringByAppendingPathComponent:fileName];
    
    BOOL exist = [fm fileExistsAtPath:p_];
    if (exist) {
        return [NSURL fileURLWithPath:p_];
    }
    //[2].main bundle中去找
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if (path) {
        return [NSURL fileURLWithPath:path];
    }
    return nil;
}

- (NSString *)databaseName {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_DatabaseName];
    return key;
}

- (NSString *)userDatabaseName{
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_UserDatabaseName];
    return key;
}

- (NSString *)pathForUserDatabase {
    return [kDocumentPath stringByAppendingPathComponent:[self userDatabaseName]];
}

- (NSString *)pathForDatabase {
    static NSString *kDBDIR = @"db_dir";
    NSString *dbDir = [kDocumentPath stringByAppendingPathComponent:kDBDIR];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *items = [fm contentsOfDirectoryAtPath:dbDir error:nil];
    for (NSString *src in items) {
        if ([[src pathExtension] isEqualToString:@"db"]) {
            return [dbDir stringByAppendingPathComponent:src];
        }
    }
    NSString *path = [dbDir stringByAppendingPathComponent:items.firstObject];
    return path;
}

- (NSString *)appleID {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_AppleID];
    return key;
}

- (NSString *)builtInIAPProductID {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_DefaultIAPProduct];
    return key;
}

- (NSString *)validSentenceIAPProductID {
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_ValidSentenceProduct];
    return key;
}

- (NSString *)umKey{
    NSDictionary *versionConfig = [self->_resourceDict objectForKey:@([Env appID])];
    NSString *key = [versionConfig objectForKey:RM_UMAppKey];
    return key;
}

- (BOOL)prepareBasicDatas {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *userDBName = [self userDatabaseName];
    NSString *userDBPath = [kDocumentPath stringByAppendingPathComponent:userDBName];
    BOOL userDBPathExist = [fm fileExistsAtPath:userDBPath];
    if (!userDBPathExist) {
        NSString *userDBPathForBundle = [[NSBundle mainBundle] pathForResource:[self userDatabaseName] ofType:nil];
        if (userDBPathForBundle.length) {
            [fm copyItemAtPath:userDBPathForBundle toPath:userDBPath error:nil];
        } else {
            return NO;
        }
    }
    
    static NSString *kDBDIR = @"db_dir";
    static NSString *kDBBackupDIR = @"db_bak";
    NSString *bkName;
    BOOL hasDeleteOldDB = NO;
    //[1].db目录
    NSString *dbDir = [kDocumentPath stringByAppendingPathComponent:kDBDIR];
    
    BOOL isDIR = NO;
    BOOL exist = [fm fileExistsAtPath:dbDir isDirectory:&isDIR];
    if (!exist || !isDIR) {
        if (!isDIR) {
            [fm removeItemAtPath:dbDir error:nil];
        }
        NSError *e;
        BOOL success = [fm createDirectoryAtPath:dbDir withIntermediateDirectories:YES attributes:nil error:&e];
#if DEBUG
        if (!success) {
            return NO;
        }
#endif
    }
    
    //[2].db 备份目录
    NSString *dbBakDIR = [kDocumentPath stringByAppendingPathComponent:kDBBackupDIR];
    BOOL isDBBakDIR = NO;
    BOOL ex = [fm fileExistsAtPath:dbBakDIR isDirectory:&isDBBakDIR];
    if (!ex || !isDBBakDIR) {
        BOOL success = [fm createDirectoryAtPath:dbBakDIR withIntermediateDirectories:YES attributes:nil error:nil];
#if DEBUG
        if (!success) {
            return NO;
        }
#endif
    }
    
    NSArray *items = nil;
    NSError *error;
    items = [fm contentsOfDirectoryAtPath:dbDir error:&error];
    NSAssert(!error, @"error:%@", error);
    if (error) {
        return NO;
    }
    for (NSString *fileName in items) {
        XLog(@"filename: %@", fileName);
        NSString *extension = [fileName pathExtension];
        if (![extension isEqualToString:@"db"]) {
            continue;
        }
        NSString *db = [NSString stringWithFormat:@"%@_%@.db", [Env releaseVesion], [Env buildVersion]];
        if ([db isEqualToString:fileName]) {
            return NO;
        } else {
            //[1].将旧库移到备份目录中
            NSError *error;
            bkName = [dbBakDIR stringByAppendingPathComponent:fileName];
            exist = [fm fileExistsAtPath:bkName];
            if (exist) {
                [fm removeItemAtPath:bkName error:nil];
            }
            BOOL success = [fm moveItemAtPath:[self pathForDatabase] toPath:bkName error:&error];
            NSAssert(success && !error, @"delete db error - %@ !!!", error);
            //[2].标记调整WCSQLiteLogic 的路径指向
            hasDeleteOldDB = YES;
            break;
        }
    }
    NSString *dbName = [self databaseName];
    NSString *src = [[NSBundle mainBundle] pathForResource:dbName ofType:nil];
    NSString *targetDBName = [NSString stringWithFormat:@"%@_%@.db", [Env releaseVesion], [Env buildVersion]];
    NSString *target = [dbDir stringByAppendingPathComponent:targetDBName];
    NSError *cpError;
    BOOL success = [fm copyItemAtPath:src toPath:target error:&cpError];
    if (success && !cpError) {
        //[3].清空dbbak目录
        NSArray *items = [fm contentsOfDirectoryAtPath:dbBakDIR error:nil];
        for (NSString *file in items) {
            NSString *target = [dbBakDIR stringByAppendingPathComponent:file];
            [fm removeItemAtPath:target error:nil];
        }
        return YES;
    }
    if (bkName) {
        NSString *target = [dbDir stringByAppendingPathComponent:bkName];
        NSError *error;
        BOOL success = [fm moveItemAtPath:bkName toPath:target error:&error];
        if (!success) {
            NSAssert(NO, @"reset db error: %@", error);
        }
    }
    return NO;
}

- (void)prepareSchoolDB {
    NSString *path = [kDocumentPath stringByAppendingPathComponent:@"school"];
    BOOL isDIR = NO;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDIR];
    if (!exist || !isDIR) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *schoolDBName = [NSString stringWithFormat:@"weici_senior_%@_%@.db", [Env releaseVesion], [Env buildVersion]];
    NSString *dbpath = [path stringByAppendingPathComponent:schoolDBName];
    exist = [[NSFileManager defaultManager] fileExistsAtPath:dbpath];
    if (!exist) {
        //清除旧版本
        NSArray<NSString *> *names = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        [names enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *p = [path stringByAppendingPathComponent:obj];
            [[NSFileManager defaultManager] removeItemAtPath:p error:nil];
        }];
        NSString *s = [[NSBundle mainBundle] pathForResource:@"weici_senior.db" ofType:nil];
        NSError *error;
        BOOL success = [[NSFileManager defaultManager] copyItemAtPath:s toPath:dbpath error:&error];
        if (success && !error) {
            //拷贝成功, 清空学校库时间戳
            [UserDefaultsUtility setNewAddSchoolTimestamp:0];
        }
    }
}

- (BOOL)deleteMedias:(NSArray<NSString *> *)mediaNames {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dir = [kDocumentPath stringByAppendingPathComponent:@"WCMedia"];
    for (NSString *name in mediaNames) {
        NSString *file = [dir stringByAppendingPathComponent:name];
        BOOL exist = [fm fileExistsAtPath:file];
        if (exist) {
            NSError *error;
            BOOL success = [fm removeItemAtPath:file error:&error];
            if (!success || error) {
                return NO;
            }
        }
    }
    return YES;
}

+ (NSNumber *)totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (NSNumber *)haveUseDiskSpace {
    CGFloat totalDiskSpace = [[self totalDiskSpace] floatValue];
    CGFloat freeDiskSpace = [[self freeDiskSpace] floatValue];
    CGFloat haveUseDiskSpace = totalDiskSpace - freeDiskSpace;
    return [NSNumber numberWithFloat:haveUseDiskSpace];
}

+ (NSString *)infoForUsedDiskSpace {
    CGFloat haveUseDiskSpace = [[self haveUseDiskSpace] floatValue];
    if (haveUseDiskSpace >= 1024*1024*1024) {
        return [NSString stringWithFormat:@"%.2fG", haveUseDiskSpace/(1024*1024*1024.00)];
    }
    return [NSString stringWithFormat:@"%.2fM",haveUseDiskSpace/(1024*1024.00)];
}

+ (NSString *)infoForFreeDiskSpace {
    CGFloat freeDiskSpace = [[self freeDiskSpace] floatValue];
    if (freeDiskSpace >= 1024*1024*1024) {
        return [NSString stringWithFormat:@"%.2fG",freeDiskSpace/(1024*1024*1024.00)];
    }
    return [NSString stringWithFormat:@"%.2fM",freeDiskSpace/(1024*1024.00)];
}

static inline NSDictionary *configuration_dict() {
    NSDictionary *dict = @{
                           @(AppIdEdition):@{
                                   RM_WXAppKey:@"wx5c5cb988245a65b5",
                                   RM_BaiduStatKey:@"030b53dc15",
                                   RM_Schema:@"vcistudent",
                                   RM_DefaultIAPProduct:@"com.nonconsume.50",
                                   RM_ValidSentenceProduct:@"com.validsentenceRefine.nonconsume.packge50",
                                   RM_MediaName:@"",
                                   RM_DatabaseName:@"weicigz.db",
                                   RM_UserDatabaseName:@"wc_gz_user.db",
                                   RM_AppleID:@"1354318292",    //应用的apple_id,不是iap的product的apple_id
                                   RM_QQAppID:@"1106749312",
                                   RM_UMAppKey:@"5ab1d25ff29d9874c10001b9"
                                   }
                           };
    return dict;
}

+ (UIImage *)avastar {
    [UserDefaultsUtility cleanUDAvastar];
    NSString *path = [kDocumentPath stringByAppendingPathComponent:@"userAvastar.jpg"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    return img;
}
+ (void)setAvastar:(UIImage *)avastar{
    NSString *path = [kDocumentPath stringByAppendingPathComponent:@"userAvastar.jpg"];
    if (avastar) {
        NSData *data = UIImageJPEGRepresentation(avastar, 1.f);
        [data writeToFile:path atomically:YES];
    } else {
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:path error:nil];
    }
    
}

@end
