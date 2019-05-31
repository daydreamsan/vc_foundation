//
//  UserDefaultsUtility.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "UserDefaultsUtility.h"
#import "Env.h"
#import "VCFKBase.h"

#ifndef kUserDefaults
#define kUserDefaults   user_defaults()
#endif

#define WCSYNC(...)   \
__VA_ARGS__; \
[kUserDefaults synchronize]

/*********************************************************/
/****************所有的键值必须在此处定义*********************/
/* 1. 若该字段需要在退出登录时自动被清除，当前缀定义为com.UD*******/
/* 2. 若该字段在退出时不必清除，将前缀定义为com.RMUD*************/
/*********************************************************/

static NSString *const UDSession        = @"com.UDSession";
static NSString *const UDSessionDue     = @"com.UDSessionDue";
static NSString *const UDApproved       = @"com.UDApproved";
static NSString *const UDUserCode       = @"com.UDUserCode";
static NSString *const UDUserSex        = @"com.UDUserSex";
static NSString *const UDUserAvastar    = @"com.UDUserAvastar";
static NSString *const UDMaxWordCount   = @"com.UDMaxWordCount";
static NSString *const UDCountLocal     = @"com.UDCountLocal";
static NSString *const UDCurrentCount   = @"com.UDCurrentCount";
static NSString *const UDLastLookupWordTime   = @"com.UDLastLookupWordTime";
static NSString *const UDDayWordCount   = @"com.UDDayWordCount";
static NSString *const UDDefaultDayWordCountLimit = @"com.UDDefaultDayWordCountLimit";
static NSString *const UDHasActivity    = @"com.UDHasActivity";
static NSString *const UDVerUpdateTime  = @"com.UDVerUpdateTime";
static NSString *const UDDetailGuide    = @"com.UDDetailGuide";
static NSString *const UDUserActivation = @"com.UDUserActivation";
static NSString *const UDUserPrivacy    = @"com.UDUserPrivacy";
static NSString *const UDPersistedDays  = @"com.UDPersistedDays";
static NSString *const UDMasteredCount  = @"com.UDMasteredCount";
static NSString *const UDLearnPower     = @"com.UDLearnPower";
static NSString *const UDServerLearnPower     = @"com.UDServerLearnPower";
static NSString *const UDEdition        = @"com.UDEdition";
static NSString *const UDGrade          = @"com.UDGrade";
static NSString *const UDPatchVersion   = @"com.UDPatchVersion";
static NSString *const UDMsgTimestamp   = @"com.UDMsgTimestamp";
static NSString *const UDNesMessageFlag = @"com.UDNesMessageFlag";
static NSString *const UDHasDownloaded  = @"com.UDHasDownloaded";
static NSString *const UDHasUnzip       = @"com.UDHasUnzip";
static NSString *const UDLocalMediaDIR  = @"com.UDLocalMediaDIR";
static NSString *const UDAppStoreGrade  = @"com.UDAppStoreGrade";
static NSString *const UDGotoUpdate     = @"com.UDGotoUpdate";
static NSString *const UDMedalNameArray      = @"com.UDMedalNameArray";
static NSString *const UDTeacherFlag    = @"com.UDTeacherFlag";
static NSString *const UDReminderTimes  = @"com.UDReminderTimes";
static NSString *const UDAdjustTime     = @"com.UDAdjustTime";
static NSString *const UDLearnPowerGuide     = @"com.UDLearnPowerGuide";

static NSString *const UDReleaseAPI     = @"com.UDReleaseAPI";
static NSString *const UDPreparedBD     = @"com.UDPreparedBD";
static NSString *const UDBDVersion      = @"com.UDBDVersion";
static NSString *const UDOTShowToolBar  = @"com.UDOTShowToolBar";
static NSString *const UDOTShowAnimate  = @"com.UDOTShowAnimate";
static NSString *const UDFeedbackTime   = @"com.UDFeedbackTime";
static NSString *const UDFeedbackCount  = @"com.UDFeedbackCount";
static NSString *const UDShowTextGuide  = @"com.UDShowTextGuide";
static NSString *const UDSyncHomeworkTimestamp  = @"com.UDSyncHomeworkTimestamp";
static NSString *const UDTeamID                 = @"com.UDTeamID";
static NSString *const UDNewHomeworkFlag        = @"com.UDNewHomeworkFlag";
static NSString *const UDTimelineGroup          = @"com.UDTimelineGroup";
static NSString *const UDNewTeacherRecommend    = @"com.UDNewTeacherRecommend";
static NSString *const UDNewHomework            = @"com.UDNewHomework";
static NSString *const UDFreshHomeworkIDs       = @"com.UDFreshHomeworkIDs";
static NSString *const UDFreshTeacherShare      = @"com.UDFreshTeacherShare";
static NSString *const UDOTEnableAutoScroll     = @"com.UDOTEnableAutoScroll";
static NSString *const UDDownloadIndexPathes    = @"com.UDDownloadIndexPathes";
static NSString *const UDCurrentBookID          = @"com.UDCurrentBookID";
static NSString *const UDCurrentUnitID          = @"com.UDCurrentUnitID";

static NSString *const UDSyncActivityData       = @"com.UDSyncActivityData";
static NSString *const UDHasSyncBasicData       = @"com.UDHasSyncBasicData";

static NSString *const UDSchoolName     = @"com.UDSchoolName";
static NSString *const UDAreaLocate     = @"com.UDAreaLocate";
static NSString *const UDHeadUrl        = @"com.UDHeadUrl";

static NSString *const UDHasCompletePersonalInfo = @"com.UDHasCompletePersonalInfo";
static NSString *const UDFirstVideo              = @"com.UDFirstVideo";
static NSString *const UDVisitFlag               = @"com.UDVisitFlag";
static NSString *const UDCurrentPlanID           = @"com.UDCurrentPlanID";
static NSString *const UDCurrentTextbookPlanID   = @"com.UDCurrentTextbookPlanID";

#pragma mark - 播放
static NSString *const UDMediaGap               = @"com.UDMediaGap";
static NSString *const UDMediaType              = @"com.UDMediaType";
static NSString *const UDMediaTimes             = @"com.UDMediaTimes";
static NSString *const UDMediaShouldAutoPlay    = @"com.UDMediaShouldAutoPlay";
static NSString *const UDMediaDownloadFrom      = @"com.UDMediaDownloadFrom";
static NSString *const UDMediaHasSettingGap     = @"com.UDMediaHasSettingGap";

#pragma mark - 增值包
static NSString *const UDPackageInfo            = @"com.UDPackageInfo";
static NSString *const UDCountForRecorder       = @"com.UDCountForRecorder";
static NSString *const UDRecordUserDays         = @"com.UDRecordUserDays";

static NSString *const UDDBPatchInfo            = @"com.UDDBPatchInfo";
static NSString *const UDActivityOpenInfos      = @"com.UDActivityOpenInfos";
static NSString *const UDActivityCourseInfos    = @"com.UDActivityCourseInfos";
static NSString *const UDActivityPackActivitionInfo = @"com.UDActivityPackActivitionInfo";

static NSString *const UDCDNKey                 = @"com.UDCDNKey";

#pragma mark - 获取新增学校时间戳

static NSString *const UDNewAddSchoolTimestamp  = @"com.UDNewAddSchoolTimestamp";
static NSString *const UDHasDownloadGoldSentence    = @"com.UDHasDownloadGoldSentence";
static NSString *const UDHasSyncCourseActivityUserTotalTime = @"com.UDHasSyncCourseActivityUserTotalTime";

#pragma mark - 评语时间戳&催促时间戳
static NSString *const UDCommentTimestamp       = @"com.UDCommentTimestamp";
static NSString *const UDUrgeHomeworkTimestamp  = @"com.UDUrgeHomeworkTimestamp";

#pragma mark - 紧急消息时间戳
static NSString *const UDNewUrgentTimestamp = @"com.UDNewUrgentTimestamp";

static NSString *const UDWordKingRestFlag = @"com.UDWordKingRestFlag";  //万词王休息标记

static NSString *const UDDebugShowProperties    = @"com.UDDebugShowProperties";
static NSString *const UDGoldSentenceWaiting    = @"com.UDGoldSentenceWaiting";

#pragma mark - 弹窗间隔
static NSString *const UDTODOListInterval       = @"com.UDTODOListInterval";
#pragma mark - 金句相关
static NSString *const UDValidSentenceExplain   = @"com.UDValidSentenceExplain";

#pragma mark - 万词王活动相关
static NSString *const UDWordKingActivityInfo   = @"com.RMUDWordKingActivityInfo";
static NSString *const UDWordKingActivityFlag   = @"com.RMUDWordKingActivityFlag";

/****************************此行上面添加键值***********************/
//static NSString *const

NSString *WCEditionDidChangeNotification = @"WCEditionDidChangeNotification";

@implementation UserDefaultsUtility

static inline NSUserDefaults *user_defaults() {
    return [NSUserDefaults standardUserDefaults];
}

+ (NSInteger)defaultDayWordCountLimit {
    NSInteger cnt = [kUserDefaults integerForKey:UDDefaultDayWordCountLimit];
    if (!cnt) {
        [self setDefaultDayWordCountLimit:cnt];
    }
    return cnt ?: 5;
}
+ (void)setDefaultDayWordCountLimit:(NSInteger)limit {
    WCSYNC([kUserDefaults setInteger:limit?:5 forKey:UDDefaultDayWordCountLimit]);
}

+ (BOOL)hasActivitionGoldSentence {
    NSDictionary *activitionInfos = [UserDefaultsUtility hasPackageActivition];
    BOOL hasPurchase = [[activitionInfos objectForKey: @"2"] boolValue];
    BOOL hasActivity = [UserDefaultsUtility hasActivation];
    return (hasActivity || hasPurchase);
}

+ (NSString *)session {
    NSString *session = [kUserDefaults objectForKey:UDSession];
    if (session.length) {
        return session;
    }
    NSString *path = [kDocumentPath stringByAppendingPathComponent:@"session.txt"];
    NSError *error;
    session = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    return session;
}
+ (void)setSession:(NSString *)session{
    WCSYNC([kUserDefaults setObject:session forKey:UDSession]);
    NSString *path = [kDocumentPath stringByAppendingPathComponent:@"session.txt"];
    NSError *error;
    [session writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)userCode {
    return [kUserDefaults objectForKey:UDUserCode];
}
+ (void)setUserCode:(NSString *)code {
    WCSYNC([kUserDefaults setObject:code forKey:UDUserCode]);
}

+ (NSString *)userSex{
    NSString *userSex = [kUserDefaults objectForKey:UDUserSex];
    if (!userSex.length) {
        return @"男";
    }
    return [userSex isEqualToString:@"女"]?userSex:@"男";
}
+ (void)setUserSex:(NSString *)sex{
    WCSYNC([kUserDefaults setObject:sex forKey:UDUserSex]);
}

+ (void)cleanUDAvastar {
    NSData *data = [kUserDefaults objectForKey:UDUserAvastar];
    if (data.length) {
        [kUserDefaults removeObjectForKey:UDUserAvastar];
    }
}

+ (BOOL)approved {
    return [kUserDefaults boolForKey:UDApproved];
}
+ (void)setApproved:(BOOL)isIn{
    WCSYNC([kUserDefaults setBool:isIn forKey:UDApproved]);
}

+ (NSInteger)maxWordCount {
    return [kUserDefaults integerForKey:UDMaxWordCount];
}
+ (void)setMaxWordCount:(NSInteger)max {
    WCSYNC([kUserDefaults setInteger:max forKey:UDMaxWordCount]);
}

+ (NSInteger)currentCountInLocal {
    return [kUserDefaults integerForKey:UDCountLocal];
}
+ (void)setCurrentCountInLocal:(NSInteger)no {
    WCSYNC([kUserDefaults setInteger:no forKey:UDCountLocal]);
}

+ (NSInteger)currentCount {
    return [kUserDefaults integerForKey:UDCurrentCount];
}
+ (void)setCurrentCount:(NSInteger)cnt {
    WCSYNC([kUserDefaults setInteger:cnt forKey:UDCurrentCount]);
}
+ (NSDate *)lastLookupWordTime {
    return [kUserDefaults valueForKey:UDLastLookupWordTime];
}

+ (void)setLastLookupWordTime {
    NSDate *interval = [NSDate date];
    WCSYNC([kUserDefaults setValue:interval forKey:UDLastLookupWordTime]);
}

+ (NSInteger)dayWordCount {
    return [kUserDefaults integerForKey:UDDayWordCount];
}
+ (void)setDayWordCount:(NSInteger)count {
    WCSYNC([kUserDefaults setInteger:count forKey:UDDayWordCount]);
}

+ (NSUInteger)versionUpdateTime {
    NSString *info = [kUserDefaults objectForKey:UDVerUpdateTime];
    NSArray *objs = [info componentsSeparatedByString:@"_"];
    return [objs.lastObject integerValue];
}
+ (void)setVersionUpdateTime {
    NSString * info = [kUserDefaults objectForKey:UDVerUpdateTime];
    NSString *currentV;
#if DEBUG
    currentV = [Env buildVersion];
#else
    currentV = [Env releaseVesion];
#endif
    
    NSString *str;
    if (info.length == 0) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        long inter_ = ceill(interval);
        str = [NSString stringWithFormat:@"%@_%zi", currentV, inter_];
    } else {
        NSArray *objs = [info componentsSeparatedByString:@"_"];
        if (![objs.firstObject isEqualToString:currentV]) {
            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
            long inter_ = ceill(interval);
            str = [NSString stringWithFormat:@"%@_%zi", currentV, inter_];
        }
    }
    WCSYNC([kUserDefaults setObject:str forKey:UDVerUpdateTime]);
}

#define kGotoGradeLimit     (3600 * 24 * 7)
+ (BOOL)shouldShowReminderForGotoGrade {
    NSString *obj = [kUserDefaults objectForKey:UDAppStoreGrade];
    if (![obj isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([obj isEqualToString:@"no_remind"]) {
        return NO;
    }
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval updateInterval = [self versionUpdateTime];
    if (interval - updateInterval > kGotoGradeLimit) {
        return YES;
    }
    return NO;
}

+ (void)setHasRemindedGrade:(BOOL)has{
    if (has) {
        WCSYNC([kUserDefaults setObject:@"no_remind" forKey:UDAppStoreGrade]);
    }
}

+ (NSString *)sessionDue {
    return [kUserDefaults objectForKey:UDSessionDue];
}
+ (void)setSessionDue:(NSString *)due {
    WCSYNC([kUserDefaults setObject:due forKey:UDSessionDue]);
}

+ (BOOL)hasGuideDetailPage {
    return [kUserDefaults boolForKey:UDDetailGuide];
}

+ (void)setHasGuideDetailPage:(BOOL)guide {
    WCSYNC([kUserDefaults setBool:guide forKey:UDDetailGuide]);
}

+ (BOOL)hasActivation {
    return [kUserDefaults boolForKey:UDUserActivation];
}
+ (void)setHasActivation:(BOOL)activation {
    WCSYNC([kUserDefaults setBool:activation forKey:UDUserActivation]);
}

+ (NSDictionary *)hasPackageActivition {
    return [kUserDefaults objectForKey:UDActivityPackActivitionInfo];
}
+ (void)setPackagesActivitionInfos:(NSDictionary *)infos {
    WCSYNC([kUserDefaults setObject:infos forKey:UDActivityPackActivitionInfo]);
}

+ (BOOL)shouldHiddenPrivacy {
    return [[kUserDefaults stringForKey:UDUserPrivacy] isEqualToString:@"show"];
}
+ (void)setShouldHiddenPrivacy:(BOOL)hidden {
    WCSYNC([kUserDefaults setObject:hidden?@"show":@"hidden" forKey:UDUserPrivacy]);
}

+ (NSArray*)medalNameArray{
     return [kUserDefaults objectForKey:UDMedalNameArray];
}
+ (void)setMedalNameArray:(NSArray*)medalNames{
     WCSYNC([kUserDefaults setObject:medalNames forKey:UDMedalNameArray]);
}

+ (void)setReminderTimes:(NSInteger)times {
    WCSYNC([kUserDefaults setInteger:times forKey:UDReminderTimes]);
}
+ (NSInteger)reminderTimes {
    NSInteger t = [kUserDefaults integerForKey:UDReminderTimes];
    if (t <= 0) {
        t = 30;
        [self setReminderTimes:t];
    }
    return t;
}

+ (void)setAdjustTime {
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    WCSYNC([kUserDefaults setFloat:interval forKey:UDAdjustTime]);
}
+ (float)adjustTime {
    float t = [kUserDefaults floatForKey:UDAdjustTime];
    return t;
}

+ (BOOL)showLearnPowerGuide {
    if ([kUserDefaults boolForKey:UDLearnPowerGuide]) {
        return NO;
    }
    return YES;
}
+ (void)setShowLearnPowerGuide:(BOOL)show {
    WCSYNC([kUserDefaults setBool:!show forKey:UDLearnPowerGuide]);
}

+ (void)setPersistDay:(NSInteger)day {
    NSDate *date = [NSDate date];
    NSString *target = [NSString stringWithFormat:@"%zi_%zi-%zi-%zi", day==0?1:day, date.year, date.month, date.day];
    WCSYNC([kUserDefaults setObject:target forKey:UDPersistedDays]);
}

+ (NSInteger)persistedDays {
    NSString *days = [kUserDefaults objectForKey:UDPersistedDays];
    NSArray *comps = [days componentsSeparatedByString:@"_"];
    NSInteger cnt = [[comps firstObject] integerValue];
    return cnt;
}

/**
 存储的串为:x_yy-mm-dd
 */
+ (void)increasePersistedDays {
    NSString *days = [kUserDefaults objectForKey:UDPersistedDays];
    NSDate *date = [NSDate date];
    NSString *dateStr = [NSString stringWithFormat:@"%zi-%zi-%zi", date.year, date.month, date.day];
    if (days.length) {
        NSArray<NSString *> *comps = [days componentsSeparatedByString:@"_"];
        NSString *tail = comps.lastObject;
        NSString *head = comps.firstObject;
        if (![tail isEqualToString:dateStr]) {
            NSInteger cnt = head.integerValue + 1;
            NSString *target = [NSString stringWithFormat:@"%zi_%@", cnt, dateStr];
            WCSYNC([kUserDefaults setObject:target forKey:UDPersistedDays]);
        }
    } else {
        NSString *target = [NSString stringWithFormat:@"1_%@", dateStr];
        WCSYNC([kUserDefaults setObject:target forKey:UDPersistedDays]);
    }
}

+ (NSString *)masteredWordIDs {
    return [kUserDefaults objectForKey:UDMasteredCount];
}
+ (void)setMasteredWordIDs:(NSString *)ids {
    WCSYNC([kUserDefaults setObject:ids forKey:UDMasteredCount]);
}

+ (NSInteger)masteredCount {
    NSString *str = [kUserDefaults objectForKey:UDMasteredCount];
    NSArray *obj = [str componentsSeparatedByString:@","];
    if (str.length) {
        return obj.count;
    } else {
        return 0;
    }
}

+ (void)increaseCountsForMasteredWordID:(NSInteger)wordID {
    NSString *str = [kUserDefaults objectForKey:UDMasteredCount];
    NSArray *obj = [str componentsSeparatedByString:@","];
    NSMutableSet *set = [NSMutableSet setWithArray:obj];
    BOOL contain = [set containsObject:@(wordID).stringValue];
    if (!contain) {
        [set addObject:@(wordID).stringValue];
        NSString *target = [set.allObjects componentsJoinedByString:@","];
        WCSYNC([kUserDefaults setObject:target forKey:UDMasteredCount]);
    }
}
+ (void)decreaseCountsForMasteredWordID:(NSInteger)wordID {
    NSString *str = [kUserDefaults objectForKey:UDMasteredCount];
    NSArray *obj = [str componentsSeparatedByString:@","];
    NSMutableSet *set = [NSMutableSet setWithArray:obj];
    [set removeObject:@(wordID).stringValue];
    NSString *target = [set.allObjects componentsJoinedByString:@","];
    WCSYNC([kUserDefaults setObject:target forKey:UDMasteredCount]);
}

+ (void)setLearnPower:(NSInteger)power {
    WCSYNC([kUserDefaults setInteger:power forKey:UDLearnPower]);
}
+ (NSInteger)learnPower {
    return [kUserDefaults integerForKey:UDLearnPower];
}
+ (void)increaseLearnPowerBy:(NSInteger)cnt {
    NSInteger learned = [kUserDefaults integerForKey:UDLearnPower];
    WCSYNC([kUserDefaults setInteger:learned+cnt forKey:UDLearnPower]);
}

+ (void)setServerLearnPower:(NSInteger)power {
    WCSYNC([kUserDefaults setInteger:power forKey:UDServerLearnPower]);
}
+ (NSInteger)serverLearnPower {
    return [kUserDefaults integerForKey:UDServerLearnPower];
}
+ (NSInteger)edition {
    return [kUserDefaults integerForKey:UDEdition];
}
+ (void)setEdition:(NSInteger)edition{
    NSInteger pre = [self edition];
    WCSYNC([kUserDefaults setInteger:edition forKey:UDEdition]);
    if (edition != pre) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WCEditionDidChangeNotification object:nil];
    }
}
+ (NSInteger)hasSyncBasicData {
    return [kUserDefaults integerForKey:UDHasSyncBasicData];
}
+ (void)setHasSyncBasicData:(NSInteger)hasSync {
    WCSYNC([kUserDefaults setInteger:hasSync forKey:UDHasSyncBasicData]);
}

+ (NSInteger)hasCompletePersonalInfo {
    return [kUserDefaults integerForKey:UDHasCompletePersonalInfo];
}
+ (void)setHasCompletePersonalInfo:(BOOL)comp {
    WCSYNC([kUserDefaults setInteger:comp forKey:UDHasCompletePersonalInfo]);
}

+ (void)setSchoolName:(NSString *)school{
    WCSYNC([kUserDefaults setObject:school forKey:UDSchoolName]);
}

+ (NSString *)schoolName{
    return [kUserDefaults objectForKey:UDSchoolName];
}

+ (void)setAreaLocate:(NSDictionary *)locate{
    WCSYNC([kUserDefaults setObject:locate forKey:UDAreaLocate]);
}

+ (NSDictionary *)areaLocate{
    return [kUserDefaults objectForKey:UDAreaLocate];
}

+ (NSInteger)grade {
    return [kUserDefaults integerForKey:UDGrade];
}
+ (void)setGrade:(NSInteger)grade {
    WCSYNC([kUserDefaults setInteger:grade forKey:UDGrade]);
}

+ (NSString *)databasePatchVersion {
    NSString *patchVersion = [kUserDefaults objectForKey:UDPatchVersion];
    if (!patchVersion.length) {
        [self setDatabasePatchVersion:@"0"];
    }
    return [kUserDefaults objectForKey:UDPatchVersion];
}

+ (void)setDatabasePatchVersion:(NSString *)version {
    WCSYNC([kUserDefaults setObject:version forKey:UDPatchVersion]);
}

+ (float)messageTimestamp {
    return [kUserDefaults floatForKey:UDMsgTimestamp];
}
+ (void)setMessageTimestamp:(float)stamp {
    WCSYNC([kUserDefaults setFloat:stamp forKey:UDMsgTimestamp]);
}

+ (BOOL)hasNewMessage {
    return [kUserDefaults boolForKey:UDNesMessageFlag];
}

+ (void)setHasNewMessage:(BOOL)has {
    WCSYNC([kUserDefaults setBool:has forKey:UDNesMessageFlag]);
}

+ (BOOL)hasDownloadMediaNotZip {
    BOOL hasDownload = [kUserDefaults boolForKey:UDHasDownloaded];
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dir = [document stringByAppendingPathComponent:@"offline_media"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSArray *items = [fm contentsOfDirectoryAtPath:dir error:&error];
    return items.count && hasDownload;
}

+ (BOOL)hasDownloadMedia {
    BOOL hasDownload = [kUserDefaults boolForKey:UDHasDownloaded];
    BOOL hasUnzip = [self hasUnzip];
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dir = [document stringByAppendingPathComponent:@"offline_media"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSArray *items = [fm contentsOfDirectoryAtPath:dir error:&error];
    return items.count && hasDownload && hasUnzip;
}

+ (void)setHasDownloadMedia:(BOOL)downloaded {
    WCSYNC([kUserDefaults setBool:downloaded forKey:UDHasDownloaded]);
}

+ (BOOL)hasUnzip {
    BOOL unzip = [kUserDefaults boolForKey:UDHasUnzip];
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dir = [document stringByAppendingPathComponent:@"offline_media"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSArray *items = [fm contentsOfDirectoryAtPath:dir error:&error];
    return items.count && unzip;
}
+ (void)setHasUnzip:(BOOL)unzip {
    [kUserDefaults setBool:unzip forKey:UDHasUnzip];
}

+ (NSString *)localMediaDIRName {
    NSString *dir = [kUserDefaults objectForKey:UDLocalMediaDIR];
    if (dir.length) {
        return dir;
    }
    [self setLocalMediaDIRName:@"offline_media/sound"];
    return @"offline_media/sound";
}
+ (void)setLocalMediaDIRName:(NSString *)dir {
    WCSYNC([kUserDefaults setObject:dir forKey:UDLocalMediaDIR]);
}

+ (NSString *)API {
    NSString *res = [kUserDefaults objectForKey:UDReleaseAPI];
    if ([res isEqualToString:@"是"]) {
        return @"http://test.weicistudy.com:83/";
    } else if ([res isEqualToString:@"否"]){
        return @"http://api.weicistudy.com/";
    } else {
        return nil;
    }
}

+ (void)setAPI:(BOOL)is {
    WCSYNC([kUserDefaults setObject:is?@"是":@"否" forKey:UDReleaseAPI]);
}

+ (BOOL)showPropertiesAlert {
    return [[kUserDefaults stringForKey:UDDebugShowProperties] isEqualToString:@"show"];
}
+ (void)setShowPropertiesAlert:(NSString *)show {
    WCSYNC([kUserDefaults setObject:show.length?show:@"hidden" forKey:UDDebugShowProperties]);
}

+ (BOOL)hasLogin {
    return [UserDefaultsUtility userCode].length && [UserDefaultsUtility session].length;
}

+ (BOOL)preparedBasicData {
    return [kUserDefaults boolForKey:UDPreparedBD];
}
+ (void)setPreparedBasicData:(BOOL)prepared {
    WCSYNC([kUserDefaults setBool:prepared forKey:UDPreparedBD]);
}

+ (NSInteger)basicDatasVersion {
    return [kUserDefaults integerForKey:UDBDVersion];
}
+ (void)setBasicDatasVersion:(NSInteger)bdversion {
    WCSYNC([kUserDefaults setInteger:bdversion forKey:UDBDVersion]);
}

+ (BOOL)isValidSession
{
#if DEBUG
#else
    ///是否在in review
    if ([self approved] == NO) {
        ///审核期间不进行session判断
        return YES;
    }
#endif
    BOOL valid = NO;
    if ([self userCode].length == 0) {
        ///没有用户信息, 返回NO
        return NO;
    }
    
    NSString *endDateStr = [self sessionDue];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *endDate = [fmt dateFromString:endDateStr];
    if ([[endDate laterDate:[NSDate date]] isEqualToDate:endDate]) {
        valid = YES;
    }
    return valid && [self session];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)showTextToolBar {
    NSNumber *obj = [kUserDefaults objectForKey:UDOTShowToolBar];
    if (obj) {
        return obj.integerValue;
    } else {
        [self setShowTextToolBar:YES];
        return YES;
    }
}
+ (void)setShowTextToolBar:(BOOL)show {
    WCSYNC([kUserDefaults setObject:@(show) forKey:UDOTShowToolBar]);
}
+ (BOOL)showAnimateView {
    NSNumber *obj = [kUserDefaults objectForKey:UDOTShowAnimate];
    if (obj) {
        return obj.integerValue;
    } else {
        [self setShowAnimateView:YES];
        return YES;
    }
}
+ (void)setShowAnimateView:(BOOL)show {
    WCSYNC([kUserDefaults setObject:@(show) forKey:UDOTShowAnimate]);
}
+ (BOOL)enableAutoScroll {
    NSNumber *obj = [kUserDefaults objectForKey:UDOTEnableAutoScroll];
    if (obj) {
        return obj.integerValue;
    } else {
        [self setEnableAutoScroll:YES];
        return YES;
    }
}
+ (void)setEnableAutoScroll:(BOOL)enable {
    WCSYNC([kUserDefaults setObject:@(enable) forKey:UDOTEnableAutoScroll]);
}

+ (NSMutableArray *)downloadIndexPathes {
    NSData *arrayData = [kUserDefaults objectForKey:UDDownloadIndexPathes];
    NSMutableArray *arr = @[].mutableCopy;
    if (arrayData.length) {
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    }
    return arr;
}

+ (void)setDownloadIndexPathes:(NSMutableArray *)indexPaths {
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:indexPaths];
    WCSYNC([kUserDefaults setObject:arrayData forKey:UDDownloadIndexPathes]);
}


+ (float)nextFeedbackTime {
    return [kUserDefaults floatForKey:UDFeedbackTime];
}

+ (void)setFeedbackTime{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    WCSYNC([kUserDefaults setFloat:interval forKey:UDFeedbackTime]);
}

+ (NSInteger)feedbackCount {
    return [kUserDefaults integerForKey:UDFeedbackCount];
}

+ (void)setFeedbackCount:(NSInteger)count {
    WCSYNC([kUserDefaults setInteger:count forKey:UDFeedbackCount]);
}

+ (BOOL)showTextGuide {
    return [kUserDefaults boolForKey:UDShowTextGuide];
}

+ (void)setShowTextGuide:(BOOL)show {
    WCSYNC([kUserDefaults setBool:show forKey:UDShowTextGuide]);
}

+ (void)setSyncHomeworkTimestamp:(NSInteger)tm {
    WCSYNC([kUserDefaults setInteger:tm forKey:UDSyncHomeworkTimestamp]);
}
+ (NSInteger)timestampForSyncHomework {
    return [kUserDefaults integerForKey:UDSyncHomeworkTimestamp];
}
+ (void)setTeamID:(NSInteger)teamID {
    WCSYNC([kUserDefaults setInteger:teamID forKey:UDTeamID]);
}
+ (NSInteger)teamID {
    return [kUserDefaults integerForKey:UDTeamID];
}

+ (void)setNewHomeworkFlag:(BOOL)flag {
    WCSYNC([kUserDefaults setInteger:flag forKey:UDNewHomeworkFlag]);
}
+ (BOOL)newHomeworkFlag {
    return [kUserDefaults boolForKey:UDNewHomeworkFlag];
}

+ (void)setTimelineGroup:(NSString *)info {
    WCSYNC([kUserDefaults setObject:info forKey:UDTimelineGroup]);
}

+ (NSString *)timelineGroup {
    return [kUserDefaults objectForKey:UDTimelineGroup];
}
+ (void)timestampForSyncTeacherRecommend:(NSInteger)tm{
    WCSYNC([kUserDefaults setInteger:tm forKey:UDNewTeacherRecommend]);
}
+ (NSInteger)newTeacherRecommend{
    return [kUserDefaults integerForKey:UDNewTeacherRecommend];
}

+ (void)timestampForSyncNewHomework:(NSInteger)ntm{
    WCSYNC([kUserDefaults setInteger:ntm forKey:UDNewHomework]);
}
+ (NSInteger)newHomework{
    return [kUserDefaults integerForKey:UDNewHomework];
}

+ (void)setFreshHomeworkIDs:(NSArray<NSNumber *> *)ids {
    WCSYNC([kUserDefaults setObject:ids forKey:UDFreshHomeworkIDs]);
}

/**
 获取新作业的ID
 
 @return 新作业ID集合
 */
+ (NSArray<NSNumber *> *)freshHomeworkIDs {
    NSString *ids = [kUserDefaults objectForKey:UDFreshHomeworkIDs];
    NSArray *idarray = [ids componentsSeparatedByString:@","];
    NSMutableArray *one = @[].mutableCopy;
    [idarray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [one addObject:@(obj.integerValue)];
    }];
    return one;
}

/**
 缓存老师分享, 最多存两条
 
 @param JSONString "[{},{}]"
 */
+ (void)setFreshTeacherShare:(NSString *)JSONString {
    WCSYNC([kUserDefaults setObject:JSONString forKey:UDFreshTeacherShare]);
}

/**
 获取缓存的老师分享
 
 @return 分享结果集
 */
+ (NSArray<NSDictionary *> *)freshTeacherCache {
    NSString *JSONString = [kUserDefaults objectForKey:UDFreshTeacherShare];
    if (JSONString.length) {
        NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        if (data.length) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            return obj;
        }
    }
    return nil;
}

+ (void)setCurrentUnitID:(NSInteger)currentUnitID {
    WCSYNC([kUserDefaults setInteger:currentUnitID forKey:UDCurrentUnitID]);
}
+ (NSInteger)currentUnitID {
    return [kUserDefaults integerForKey:UDCurrentUnitID];
}

+ (void)setCurrentBookID:(NSInteger)currentBookID {
    WCSYNC([kUserDefaults setInteger:currentBookID forKey:UDCurrentBookID]);
}
+ (NSInteger)currentBookID {
    return [kUserDefaults integerForKey:UDCurrentBookID];
}

+ (NSInteger)timestampForSyncActivityDatas {
    return [kUserDefaults integerForKey:UDSyncActivityData];
}
+ (void)setTimestampForSyncActivityDatas:(NSInteger)tm {
    WCSYNC([kUserDefaults setInteger:tm forKey:UDSyncActivityData]);
}

+ (void)setFirstVideo:(BOOL)first{
    WCSYNC([kUserDefaults setBool:first forKey:UDFirstVideo]);
}
+ (BOOL)firstVideo{
    return [kUserDefaults boolForKey:UDFirstVideo];
}
+ (void)setVisitFlag:(BOOL)flag {
    WCSYNC([kUserDefaults setBool:flag forKey:UDVisitFlag]);
}
+ (BOOL)isVisitor {
    return [kUserDefaults boolForKey:UDVisitFlag];
}
+ (void)setCurrentPlanID:(NSString *)key {
    WCSYNC([kUserDefaults setObject:key forKey:UDCurrentPlanID]);
}
+ (NSString *)currentPlanID {
    return [kUserDefaults objectForKey:UDCurrentPlanID];
}
+ (void)setCurrentTextbookPlanID:(NSString *)key {
    NSInteger edition = [UserDefaultsUtility edition];
    NSString *json = [kUserDefaults objectForKey:UDCurrentTextbookPlanID];
    if (!json.length) {
        json = @"{}";
        [kUserDefaults setObject:json forKey:UDCurrentTextbookPlanID];
    }
    NSDictionary *dict = json.jsonValueDecoded;
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:dict];
    [obj setObject:key?:@"" forKey:@(edition).stringValue];
    NSString *str = obj.jsonStringEncoded;
    WCSYNC([kUserDefaults setObject:str forKey:UDCurrentTextbookPlanID]);
}
+ (NSString *)currentTextbookPlanID {
    NSString *json = [kUserDefaults objectForKey:UDCurrentTextbookPlanID];
    if (!json.length) {
        json = @"{}";
        [kUserDefaults setObject:json forKey:UDCurrentTextbookPlanID];
    }
    NSDictionary *dict = json.jsonValueDecoded;
    NSInteger edition = [UserDefaultsUtility edition];
    NSString *tpid = [dict objectForKey:@(edition).stringValue];
    return tpid;
}
+ (void)setMediaGap:(NSInteger)gap {
    WCSYNC([kUserDefaults setInteger:gap forKey:UDMediaGap]);
}
+ (NSInteger)mediaGap {
    return [kUserDefaults integerForKey:UDMediaGap];
}
+ (void)setHasSettingMediaGap:(BOOL)gap{
    WCSYNC([kUserDefaults setBool:gap forKey:UDMediaHasSettingGap]);
}
+ (BOOL)mediaHasSettingGap{
    return [kUserDefaults boolForKey:UDMediaHasSettingGap];
}
+ (void)setNumberOfPlayTimes:(NSInteger)times {
    WCSYNC([kUserDefaults setInteger:times forKey:UDMediaTimes]);
}
+ (NSInteger)numberOfPlayTimes {
    NSInteger t = [kUserDefaults integerForKey:UDMediaTimes];
    if (t <= 0) {
        t = 1;
        [self setNumberOfPlayTimes:t];
    }
    return t;
}
+ (void)setMediaType:(NSInteger)type {
    WCSYNC([kUserDefaults setInteger:type forKey:UDMediaType]);
}
+ (NSInteger)mediaType {
    return [kUserDefaults integerForKey:UDMediaType];
}
+ (void)setShouldAutoPlay:(BOOL)play {
    WCSYNC([kUserDefaults setObject:@(play).stringValue forKey:UDMediaShouldAutoPlay]);
}
+ (NSInteger)shouldAutoPlay {
    NSString *info = [kUserDefaults objectForKey:UDMediaShouldAutoPlay];
    if (!info) {
        [self setShouldAutoPlay:YES];
        info = [kUserDefaults objectForKey:UDMediaShouldAutoPlay];
    }
    return info.integerValue;
}

+ (void)setMediaDownloadFromLogin:(BOOL)fromLogin{
    WCSYNC([kUserDefaults setBool:fromLogin forKey:UDMediaDownloadFrom]);
}
+ (BOOL)mediaDownloadFromLogin{
    return [kUserDefaults boolForKey:UDMediaDownloadFrom];
}

+ (void)setPackages:(NSString *)json {
    WCSYNC([kUserDefaults setObject:json forKey:UDPackageInfo]);
}
+ (NSString *)packages {
    return [kUserDefaults objectForKey:UDPackageInfo];
}

+ (NSInteger)countForRecord {
    return [kUserDefaults integerForKey:UDCountForRecorder];
}
+ (void)setCountForRecord:(NSInteger)cnt {
    WCSYNC([kUserDefaults setInteger:cnt forKey:UDCountForRecorder]);
}
+ (BOOL)canRecord {
    NSString *json = [self packages];
    NSArray *packages = [json jsonValueDecoded];
    NSDictionary *target;
    for (NSDictionary *one in packages) {
        NSInteger pid = [one integerValueForKey:@"package_type_id" default:0];
        if (pid == 1) {
            target = one;
            break;
        }
    }
    NSInteger useFlag = [target integerValueForKey:@"use_flag" default:0];
    NSInteger vcnt = [target integerValueForKey:@"voice_count" default:0];
    NSInteger tcnt = [target integerValueForKey:@"voice_total" default:5];
    NSInteger lvcnt = [self countForRecord];
    if ((MAX(vcnt, lvcnt) < tcnt) || useFlag) {
        return YES;
    } else {
        return NO;
    }
}
+ (NSInteger)totalCountForRecord {
    NSString *json = [self packages];
    NSArray *packages = [json jsonValueDecoded];
    NSDictionary *target;
    for (NSDictionary *one in packages) {
        NSInteger pid = [one integerValueForKey:@"package_type_id" default:0];
        if (pid == 1) {
            target = one;
            break;
        }
    }
    NSInteger tcnt = [target integerValueForKey:@"voice_total" default:5];
    return tcnt;
}
+ (BOOL)hasPurchasedRecord {
    NSString *json = [self packages];
    NSArray *packages = [json jsonValueDecoded];
    NSDictionary *target;
    for (NSDictionary *one in packages) {
        NSInteger pid = [one integerValueForKey:@"package_type_id" default:0];
        if (pid == 1) {
            target = one;
            break;
        }
    }
    NSInteger useFlag = [target integerValueForKey:@"use_flag" default:0];
    return useFlag;
}

+ (void)setRecordUserDays:(NSInteger)userDays{
    WCSYNC([kUserDefaults setInteger:userDays forKey:UDRecordUserDays]);
}
+ (NSInteger)recordUserDays{
    return [kUserDefaults integerForKey:UDRecordUserDays];
}

+ (NSArray<NSString *> *)allInstalledDBPathes {
    NSString *content = [kUserDefaults objectForKey:UDDBPatchInfo];
    NSArray *objs;
    if (content.length) {
        objs = [content componentsSeparatedByString:@","];
    }
    return objs;
}
+ (void)setAllInstalledDBPatches:(NSArray<NSString *> *)pathes {
    NSString *content = [pathes componentsJoinedByString:@","];
    WCSYNC([kUserDefaults setObject:content forKey:UDDBPatchInfo]);
}

+ (void)setActivityOpenInfos:(NSArray *)infos {
    WCSYNC([kUserDefaults setObject:infos.jsonStringEncoded forKey:UDActivityOpenInfos]);
}
+ (NSArray<NSDictionary *> *)activityOpenInfos {
    NSString *content = [kUserDefaults objectForKey:UDActivityOpenInfos];
    return content.jsonValueDecoded;
}

+ (void)setActivityCourseInfos:(NSArray *)courses {
    WCSYNC([kUserDefaults setObject:courses.jsonStringEncoded forKey:UDActivityCourseInfos]);
}
+ (NSArray<NSDictionary *> *)activityCourseInfos {
    NSString *content = [kUserDefaults objectForKey:UDActivityCourseInfos];
    return content.jsonValueDecoded;
}

+ (void)setCDN:(NSString *)cdn {
    WCSYNC([kUserDefaults setObject:cdn forKey:UDCDNKey]);
}

+ (NSString *)cdn {
    return [kUserDefaults objectForKey:UDCDNKey];
}

+ (void)setNewAddSchoolTimestamp:(NSInteger)timestamp {
    WCSYNC([kUserDefaults setInteger:timestamp forKey:UDNewAddSchoolTimestamp]);
}

+ (NSInteger)newSchoolTimestamp {
    return [kUserDefaults integerForKey:UDNewAddSchoolTimestamp];
}

+ (NSInteger)hasDownloadGoldSentenceForActivityID:(NSInteger)aid {
    NSString *content = [kUserDefaults stringForKey:UDHasDownloadGoldSentence];
    if (content.length) {
        NSDictionary *objs = content.jsonValueDecoded;
        NSNumber *ret = [objs objectForKey:@(aid).stringValue];
        return ret.integerValue;
    }
    return 0;
}

+ (NSInteger)goldSentenceDataIDForActivitID:(NSInteger)aid {
    NSString *content = [kUserDefaults stringForKey:UDHasDownloadGoldSentence];
    if (content.length) {
        NSDictionary *objs = content.jsonValueDecoded;
        NSNumber *ret = [objs objectForKey:@"dataID"];
        return ret.integerValue;
    }
    return 0;
}

+ (void)setHasDownloadGoldSentence:(NSInteger)ret activityID:(NSInteger)aid dataID:(NSInteger)did {
    NSString *content = [kUserDefaults stringForKey:UDHasDownloadGoldSentence];
    if (content.length) {
        NSDictionary *objs = content.jsonValueDecoded;
        if (objs) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:objs];
            [dict setObject:@(ret) forKey:@(aid)];
            [dict setObject:@(did) forKey:@"dataID"];
            NSString *json = dict.jsonStringEncoded;
            if (json.length) {
                WCSYNC([kUserDefaults setObject:json forKey:UDHasDownloadGoldSentence]);
            }
        }
    } else {
        NSDictionary *dict = @{@(aid).stringValue:@(ret).stringValue, @"dataID":@(did).stringValue};
        NSString *json = dict.jsonStringEncoded;
        if (json.length) {
            WCSYNC([kUserDefaults setObject:json forKey:UDHasDownloadGoldSentence]);
        }
    }
}

+ (BOOL)hasSyncCourseActivityUserTotalTimeWithCourseID:(NSInteger)cid {
    NSString *json = [kUserDefaults stringForKey:UDHasSyncCourseActivityUserTotalTime];
    if (json.length) {
        NSDictionary *dict = json.jsonValueDecoded;
        NSNumber *obj = [dict objectForKey:@(cid).stringValue];
        return obj.integerValue;
    } else {
        return NO;
    }
}
+ (void)setHasSyncCourseActivityUserTotalTimeWithCourseID:(NSInteger)cid {
    NSString *json = [kUserDefaults stringForKey:UDHasSyncCourseActivityUserTotalTime];
    if (json.length) {
        NSMutableDictionary *dict = [json.jsonValueDecoded mutableCopy];
        [dict setObject:@(1).stringValue forKey:@(cid).stringValue];
        WCSYNC([kUserDefaults setObject:dict.jsonStringEncoded forKey:UDHasSyncCourseActivityUserTotalTime]);
    } else {
        NSDictionary *dict = @{@(cid).stringValue:@"1"};
        WCSYNC([kUserDefaults setObject:dict.jsonStringEncoded forKey:UDHasSyncCourseActivityUserTotalTime]);
    }
}

+ (void)setCommentTimestamp:(NSInteger)commentTimestamp {
    WCSYNC([kUserDefaults setInteger:commentTimestamp forKey:UDCommentTimestamp]);
}
+ (NSInteger)commentTimestamp {
    return [kUserDefaults integerForKey:UDCommentTimestamp];
}

+ (void)setUrgeHomeworkTimestamp:(NSInteger)urgeTimeStamp {
    WCSYNC([kUserDefaults setInteger:urgeTimeStamp forKey:UDUrgeHomeworkTimestamp]);
}
+ (NSInteger)urgeHomeworkTimestamp {
    return [kUserDefaults integerForKey:UDUrgeHomeworkTimestamp];
}

+ (void)setUrgentTimestamp:(NSInteger)timestamp {
    WCSYNC([kUserDefaults setInteger:timestamp forKey:UDNewUrgentTimestamp]);
}
+ (NSInteger)urgentTimestamp {
    return [kUserDefaults integerForKey:UDNewUrgentTimestamp];
}

+ (NSInteger)wordKingRestFlag {
    return [kUserDefaults integerForKey:UDWordKingRestFlag];
}
+ (void)setWordKingRestFlag:(NSInteger)flag {
    WCSYNC([kUserDefaults setInteger:flag forKey:UDWordKingRestFlag]);
}

+ (void)setGoldSentenceHasWait:(NSInteger)dataID {
    NSString *content = [kUserDefaults objectForKey:UDGoldSentenceWaiting];
    if (content.length) {
        NSDictionary *objs = content.jsonValueDecoded;
        if (objs) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:objs];
            [dict setObject:@(YES).stringValue forKey:@(dataID).stringValue];
            NSString *json = dict.jsonStringEncoded;
            if (json.length) {
                WCSYNC([kUserDefaults setObject:json forKey:UDGoldSentenceWaiting]);
            }
        }
    } else {
        NSDictionary *dict = @{@(dataID).stringValue:@(YES).stringValue};
        NSString *json = dict.jsonStringEncoded;
        if (json.length) {
            WCSYNC([kUserDefaults setObject:json forKey:UDGoldSentenceWaiting]);
        }
    }
}

+ (BOOL)goldSentenceHasWaitWithDataID:(NSInteger)dataID {
    NSString *content = [kUserDefaults objectForKey:UDGoldSentenceWaiting];
    BOOL hasWait = NO;
    NSDictionary *dict = content.jsonValueDecoded;
    if (dict) {
        hasWait = [dict boolValueForKey:@(dataID).stringValue default:0];
    }
    return hasWait;
}

+ (void)setTeacherFlag:(BOOL)flag {
    WCSYNC([kUserDefaults setBool:flag forKey:UDTeacherFlag]);
}
+ (BOOL)isTeahcer {
    return [kUserDefaults boolForKey:UDTeacherFlag];
}

+ (void)setTodoInterval:(NSInteger)interval {
    WCSYNC([kUserDefaults setInteger:interval forKey:UDTODOListInterval]);
}

+ (NSInteger)getTodoInterval {
    return [kUserDefaults integerForKey:UDTODOListInterval];
}

+ (void)setValidSentenceHasExplain:(BOOL)hasEXplain {
    WCSYNC([kUserDefaults setBool:hasEXplain forKey:UDValidSentenceExplain]);
}
+ (BOOL)validSentenceHasExplain {
    return [kUserDefaults boolForKey:UDValidSentenceExplain];
}

/**
 存储格式为:
 {
    "startTime": {
        "star_time": 1553616000,
        "end_time":1553616000,
        "image_url":"http://a.source/b.png"
        }
 }
 @param info 待存储信息
 @param key 关键字
 */
+ (void)addWordKingActivityInfo:(NSDictionary *)info forKey:(NSString *)key {
    @try {
        NSString *json = [kUserDefaults objectForKey:UDWordKingActivityInfo];
        NSMutableDictionary *infosm = @{}.mutableCopy;
        if (key.length && info.count) {
            [infosm setObject:info forKey:key];
        }
        json = infosm.jsonStringEncoded;
        WCSYNC([kUserDefaults setObject:json forKey:UDWordKingActivityInfo]);
    } @catch (NSException *exception) {}
}

+ (NSString *)allWordKingActivity {
    return [kUserDefaults objectForKey:UDWordKingActivityInfo];
}
+ (NSString *)allWordKingActivityFlag {
    return [kUserDefaults objectForKey:UDWordKingActivityFlag];
}
+ (NSDictionary *)validWordKingActivityInfo {
    __block NSDictionary *target;
    @try {
        NSString *json = [kUserDefaults objectForKey:UDWordKingActivityInfo];
        if (json.length) {
            NSMutableDictionary *infosm = [json.jsonValueDecoded mutableCopy];
            if (infosm.count == 1) {
                target = infosm.allValues.firstObject;
            } else {
                NSTimeInterval tm = [NSDate.date timeIntervalSince1970];
                NSArray<NSString *> *sortedKeys = [infosm.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    NSInteger o1 = [obj1 integerValue];
                    NSInteger o2 = [obj2 integerValue];
                    return o1 < o2;
                }];
                __block NSString *targetKey;
                [sortedKeys enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSTimeInterval one = obj.floatValue;
                    if (one <= tm) {
                        targetKey = obj;
                        *stop = YES;
                    }
                }];
                if (targetKey) {
                    target = [infosm objectForKey:targetKey];
                }
            }
        }
    } @catch (NSException *exception) {
        
    }
    return target;
}
+ (void)dropWordKingActivityInfo {
    WCSYNC([kUserDefaults setObject:nil forKey:UDWordKingActivityInfo]);
}

+ (BOOL)isInWordKingActivity {
    NSDictionary *info = [UserDefaultsUtility validWordKingActivityInfo];
    NSTimeInterval currentTm = NSDate.date.timeIntervalSince1970;
    NSInteger startTime = [info integerValueForKey:@"start_time" default:0];
    NSInteger endTime = [info integerValueForKey:@"end_time" default:0];
    if (currentTm >= startTime && currentTm <= endTime) {
        return YES;
    }
    return NO;
}

+ (BOOL)isBeyondWordKingActivity {
    NSDictionary *info = [UserDefaultsUtility validWordKingActivityInfo];
    NSTimeInterval currentTm = NSDate.date.timeIntervalSince1970;
    NSInteger endTime = [info integerValueForKey:@"end_time" default:0];
    if (currentTm > endTime) {
        return YES;
    }
    return NO;
}

+ (NSString *)imageForValidWordKingActivity {
    BOOL inActivity = [UserDefaultsUtility isInWordKingActivity];
    NSDictionary *info = [UserDefaultsUtility validWordKingActivityInfo];
    NSString *imgURL;
    if (inActivity) {
        imgURL = [info stringValueForKey:@"image_url" default:@""];
#if DEBUG
        if (!imgURL.length) {
            imgURL = @"http://192.168.1.160:8888/Resource/img/wordking2.jpg";
        }
#endif
    } else if (![UserDefaultsUtility isBeyondWordKingActivity]) {
        imgURL = [info stringValueForKey:@"show_image_url" default:@""];
#if DEBUG
        if (!imgURL.length) {
            imgURL = @"http://192.168.1.160:8888/Resource/img/wordking.jpg";
        }
#endif
    }
    return imgURL;
}

+ (void)setCurrentWordKingCleanFlag:(BOOL)flag {
    NSDictionary *info = [UserDefaultsUtility validWordKingActivityInfo];
    NSInteger tm = [info integerValueForKey:@"start_time" default:0];
    [UserDefaultsUtility setWordKingCleanFlag:flag forKey:@(tm).stringValue];
}

+ (void)setWordKingCleanFlag:(BOOL)flag forKey:(NSString *)key {
    if (!key.length) {
        return;
    }
    NSString *json = [kUserDefaults objectForKey:UDWordKingActivityFlag];
    NSMutableDictionary *flagInfo = @{}.mutableCopy;
    if (json.length) {
        NSDictionary *one = json.jsonValueDecoded;
        [flagInfo addEntriesFromDictionary:one];
    }
    [flagInfo setObject:@(flag) forKey:key];
    json = flagInfo.jsonStringEncoded;
    WCSYNC([kUserDefaults setObject:json forKey:UDWordKingActivityFlag]);
}

+ (BOOL)shouldCleanCurrentWordKingFlag {
    BOOL shouldClean = NO;
    NSString *json = [kUserDefaults objectForKey:UDWordKingActivityFlag];
    if (!json.length) {
        shouldClean = YES;
    } else {
        NSDictionary *info = [UserDefaultsUtility validWordKingActivityInfo];
        NSInteger tm = [info integerValueForKey:@"start_time" default:0];
        NSDictionary *flags = json.jsonValueDecoded;
        shouldClean = ![flags integerValueForKey:@(tm).stringValue default:0];
    }
    return shouldClean;
}

+ (void)prepareWordKingFlag {
    NSDictionary *info = [UserDefaultsUtility validWordKingActivityInfo];
    NSInteger st = [info integerValueForKey:@"start_time" default:0];
    NSString *json = [kUserDefaults objectForKey:UDWordKingActivityFlag];
    if (json.length) {
        NSDictionary *flaginfo = json.jsonValueDecoded;
        NSInteger flag = [flaginfo integerValueForKey:@(st).stringValue default:0];
        NSString *fresh = @{@(st).stringValue: @(flag)}.jsonStringEncoded;
        WCSYNC([kUserDefaults setObject:fresh forKey:UDWordKingActivityFlag]);
    }
}

+ (void)dropWordKingFlag {
    WCSYNC([kUserDefaults setObject:nil forKey:UDWordKingActivityFlag]);
}

@end

