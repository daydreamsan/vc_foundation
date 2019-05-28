//
//  UserDefaultsUtility.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtility : NSObject

+ (NSString *)session;
+ (void)setSession:(NSString *)session;

+ (NSString *)userCode;
+ (void)setUserCode:(NSString *)code;

/**
 设置时sex存在男，女，空三种，取出时只存在男，女二种，默认是男
 */
+ (NSString *)userSex;
+ (void)setUserSex:(NSString *)sex;

+ (void)cleanUDAvastar;

+ (BOOL)approved;
+ (void)setApproved:(BOOL)isIn;

+ (NSInteger)maxWordCount;
+ (void)setMaxWordCount:(NSInteger)max;

+ (NSInteger)currentCountInLocal;
+ (void)setCurrentCountInLocal:(NSInteger)no;

+ (NSInteger)currentCount;
+ (void)setCurrentCount:(NSInteger)cnt;

+ (NSDate *)lastLookupWordTime;
+ (void)setLastLookupWordTime;

+ (NSInteger)dayWordCount;
+ (void)setDayWordCount:(NSInteger)count;

+ (NSInteger)defaultDayWordCountLimit;
+ (void)setDefaultDayWordCountLimit:(NSInteger)limit;

+ (NSUInteger)versionUpdateTime;
+ (void)setVersionUpdateTime;

+ (BOOL)shouldShowReminderForGotoGrade;
+ (void)setHasRemindedGrade:(BOOL)has;

+ (NSString *)sessionDue;
+ (void)setSessionDue:(NSString *)due;

+ (BOOL)hasGuideDetailPage;
+ (void)setHasGuideDetailPage:(BOOL)guide;

+ (BOOL)hasActivation;
+ (void)setHasActivation:(BOOL)activation;

+ (BOOL)shouldHiddenPrivacy;
+ (void)setShouldHiddenPrivacy:(BOOL)show;

+ (NSArray *)medalNameArray;
+ (void)setMedalNameArray:(NSArray *)medalNames;

+ (void)setReminderTimes:(NSInteger)times;
+ (NSInteger)reminderTimes;
+ (void)setAdjustTime;
+ (float)adjustTime;

+ (BOOL)showLearnPowerGuide;
+ (void)setShowLearnPowerGuide:(BOOL)show;

#pragma mark - 学习相关
+ (void)setPersistDay:(NSInteger)day;

/**
 已坚持多少天

 @return 天数
 */
+ (NSInteger)persistedDays;

/**
 增加已坚持天数
 */
+ (void)increasePersistedDays;

+ (NSString *)masteredWordIDs;
+ (void)setMasteredWordIDs:(NSString *)ids;

/**
 已掌握单词数

 @return 已掌握单词数
 */
+ (NSInteger)masteredCount;

/**
 增加已掌握单词数

 @param wordID 单词ID
 */
+ (void)increaseCountsForMasteredWordID:(NSInteger)wordID;

+ (void)decreaseCountsForMasteredWordID:(NSInteger)wordID;

/**
 学习力, 始终保存本地最新值

 @return 学习力的值
 */
+ (NSInteger)learnPower;

/**
 设置本地学习力，在首次从服务端向下同步数据时使用
 
 @param power 学习力
 */
+ (void)setLearnPower:(NSInteger)power;

/**
 增量更新本地学习力的值
 
 @param cnt 学习力增量
 */
+ (void)increaseLearnPowerBy:(NSInteger)cnt;

/**
 保存server学习力，每次向服务器同步数据成功时设置该值
 
 @param power 学习力
 */
+ (void)setServerLearnPower:(NSInteger)power;

/**
 获取上一次同步成功时保存的server学习力
 
 @return server学习力
 */
+ (NSInteger)serverLearnPower;

+ (NSInteger)edition;
+ (void)setEdition:(NSInteger)edition;

+ (NSInteger)hasSyncBasicData;
+ (void)setHasSyncBasicData:(NSInteger)hasSync;

+ (NSInteger)hasCompletePersonalInfo;
+ (void)setHasCompletePersonalInfo:(BOOL)comp;

+ (NSInteger)grade;
+ (void)setGrade:(NSInteger)grade;

+ (void)setSchoolName:(NSString *)school;
+ (NSString *)schoolName;

+ (void)setAreaLocate:(NSDictionary *)locate;
+ (NSDictionary *)areaLocate;

+ (NSString *)databasePatchVersion;
+ (void)setDatabasePatchVersion:(NSString *)version;

+ (float)messageTimestamp;
+ (void)setMessageTimestamp:(float)stamp;

+ (BOOL)hasNewMessage;
+ (void)setHasNewMessage:(BOOL)has;

/**
资源经下载，但不保证是否已经解压
 */
+ (BOOL)hasDownloadMediaNotZip;

+ (BOOL)hasDownloadMedia;
+ (void)setHasDownloadMedia:(BOOL)downloaded;

+ (BOOL)hasUnzip;
+ (void)setHasUnzip:(BOOL)unzip;

+ (NSString *)localMediaDIRName;
+ (void)setLocalMediaDIRName:(NSString *)dir;

+ (NSString *)API;
+ (void)setAPI:(BOOL)is;

+ (BOOL)showPropertiesAlert;
+ (void)setShowPropertiesAlert:(NSString *)show;

+ (BOOL)hasLogin;

+ (BOOL)preparedBasicData;
+ (void)setPreparedBasicData:(BOOL)prepared;

+ (NSInteger)basicDatasVersion;
+ (void)setBasicDatasVersion:(NSInteger)bdversion;

+ (NSMutableArray *)downloadIndexPathes;
+ (void)setDownloadIndexPathes:(NSMutableArray *)indexPaths;

+ (BOOL)isValidSession;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)showTextToolBar;
+ (void)setShowTextToolBar:(BOOL)show;
+ (BOOL)showAnimateView;
+ (void)setShowAnimateView:(BOOL)show;
+ (BOOL)enableAutoScroll;
+ (void)setEnableAutoScroll:(BOOL)enable;

+ (float)nextFeedbackTime;
+ (void)setFeedbackTime;

+ (NSInteger)feedbackCount;
+ (void)setFeedbackCount:(NSInteger)count;

+ (BOOL)showTextGuide;
+ (void)setShowTextGuide:(BOOL)show;

#pragma mark - 作业相关
+ (void)setSyncHomeworkTimestamp:(NSInteger)tm;
+ (NSInteger)timestampForSyncHomework;
+ (void)setTeamID:(NSInteger)teamID;
+ (NSInteger)teamID;
+ (void)setNewHomeworkFlag:(BOOL)flag;
+ (BOOL)newHomeworkFlag;

+ (void)setTimelineGroup:(NSString *)info;
+ (NSString *)timelineGroup;
+ (void)timestampForSyncTeacherRecommend:(NSInteger)tm;
+ (NSInteger)newTeacherRecommend;

+ (void)timestampForSyncNewHomework:(NSInteger)ntm;
+ (NSInteger)newHomework;

/**
 设置新作业的ID

 @warning 增量添加
 @param ids 作业ID集合
 */
+ (void)setFreshHomeworkIDs:(NSArray<NSNumber *> *)ids;

/**
 获取新作业的ID
 
 @return 新作业ID集合
 */
+ (NSArray<NSNumber *> *)freshHomeworkIDs;

/**
 缓存老师分享, 最多存两条

 @param JSONString "[{},{}]"
 */
+ (void)setFreshTeacherShare:(NSString *)JSONString;

/**
 获取缓存的老师分享

 @return 分享结果集
 */
+ (NSArray<NSDictionary *> *)freshTeacherCache;

+ (void)setCurrentUnitID:(NSInteger)currentUnitID;
+ (NSInteger)currentUnitID;

+ (void)setCurrentBookID:(NSInteger)currentBookID;
+ (NSInteger)currentBookID;

+ (NSInteger)timestampForSyncActivityDatas;
+ (void)setTimestampForSyncActivityDatas:(NSInteger)tm;


/**
 是否为第一次进入视频页，用于控制显示提示信息

 @param first YES - 是，NO- 否
 */
+ (void)setFirstVideo:(BOOL)first;
+ (BOOL)firstVideo;
+ (void)setVisitFlag:(BOOL)flag;
+ (BOOL)isVisitor;

+ (void)setCurrentPlanID:(NSString *)key;
+ (NSString *)currentPlanID;
+ (void)setCurrentTextbookPlanID:(NSString *)key;
+ (NSString *)currentTextbookPlanID;

+ (void)setMediaGap:(NSInteger)gap;
+ (NSInteger)mediaGap;
+ (void)setHasSettingMediaGap:(BOOL)gap;
+ (BOOL)mediaHasSettingGap;
+ (void)setNumberOfPlayTimes:(NSInteger)times;
+ (NSInteger)numberOfPlayTimes;
+ (void)setMediaType:(NSInteger)type;
+ (NSInteger)mediaType;
+ (void)setShouldAutoPlay:(BOOL)play;
+ (NSInteger)shouldAutoPlay;

+ (void)setMediaDownloadFromLogin:(BOOL)fromLogin;
+ (BOOL)mediaDownloadFromLogin;

/**
 设置增值包信息, 由登陆接口返回

 @param json 增值包信息
 */
+ (void)setPackages:(NSString *)json;
+ (NSString *)packages;

+ (NSInteger)countForRecord;
+ (void)setCountForRecord:(NSInteger)cnt;
+ (BOOL)canRecord;
+ (NSInteger)totalCountForRecord;
+ (BOOL)hasPurchasedRecord;

+ (void)setRecordUserDays:(NSInteger)userDays;
+ (NSInteger)recordUserDays;

+ (NSArray<NSString *> *)allInstalledDBPathes;
+ (void)setAllInstalledDBPatches:(NSArray<NSString *> *)pathes;

+ (void)setActivityOpenInfos:(NSArray *)infos;
+ (NSArray<NSDictionary *> *)activityOpenInfos;

+ (void)setActivityCourseInfos:(NSArray *)courses;
+ (NSArray<NSDictionary *> *)activityCourseInfos;

+ (void)setCDN:(NSString *)cdn;
+ (NSString *)cdn;

+ (void)setNewAddSchoolTimestamp:(NSInteger)timestamp;
+ (NSInteger)newSchoolTimestamp;

+ (NSInteger)hasDownloadGoldSentenceForActivityID:(NSInteger)aid;
+ (NSInteger)goldSentenceDataIDForActivitID:(NSInteger)aid;
+ (void)setHasDownloadGoldSentence:(NSInteger)ret activityID:(NSInteger)aid dataID:(NSInteger)did;

+ (BOOL)hasSyncCourseActivityUserTotalTimeWithCourseID:(NSInteger)cid;
+ (void)setHasSyncCourseActivityUserTotalTimeWithCourseID:(NSInteger)cid;

+ (void)setCommentTimestamp:(NSInteger)commentTimestamp;
+ (NSInteger)commentTimestamp;

+ (void)setUrgeHomeworkTimestamp:(NSInteger)urgeTimeStamp;
+ (NSInteger)urgeHomeworkTimestamp;

+ (void)setUrgentTimestamp:(NSInteger)timestamp;
+ (NSInteger)urgentTimestamp;

+ (NSInteger)wordKingRestFlag;
+ (void)setWordKingRestFlag:(NSInteger)flag;

+ (void)setGoldSentenceHasWait:(NSInteger)dataID;
+ (BOOL)goldSentenceHasWaitWithDataID:(NSInteger)dataID;

+ (BOOL)hasActivitionGoldSentence;
+ (NSDictionary *)hasPackageActivition;
+ (void)setPackagesActivitionInfos:(NSDictionary *)infos;

+ (void)setTeacherFlag:(BOOL)flag;
+ (BOOL)isTeahcer;

+ (void)setTodoInterval:(NSInteger)interval;
+ (NSInteger)getTodoInterval;

+ (void)setValidSentenceHasExplain:(BOOL)hasEXplain;
+ (BOOL)validSentenceHasExplain;

+ (void)addWordKingActivityInfo:(NSDictionary *)info forKey:(NSString *)key;
+ (NSDictionary *)validWordKingActivityInfo;
+ (void)dropWordKingActivityInfo;
+ (BOOL)isInWordKingActivity;
+ (NSString *)imageForValidWordKingActivity;

+ (void)setWordKingCleanFlag:(BOOL)flag forKey:(NSString *)key;
+ (void)setCurrentWordKingCleanFlag:(BOOL)flag;
+ (BOOL)shouldCleanCurrentWordKingFlag;
+ (void)dropWordKingFlag;

+ (NSString *)allWordKingActivity;
+ (NSString *)allWordKingActivityFlag;
+ (void)prepareWordKingFlag;

@end
