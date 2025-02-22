//
//  MMLocationManager.h
//  MMLocationManager
//
//  Created by Chen Yaoqiang on 13-12-24.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI/BMapKit.h>

#define  MMLastLongitude @"MMLastLongitude"
#define  MMLastLatitude  @"MMLastLatitude"
#define  MMLastCity      @"MMLastCity"
#define  MMLastAddress   @"MMLastAddress"

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void(^NSStringBlock)(NSString *cityString);
typedef void(^NSStringBlock)(NSString *addressString);
typedef void(^NSStringBlock)(NSString *countryString  );
@interface MMLocationManager : NSObject<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong) BMKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D lastCoordinate;
@property(nonatomic,strong)NSString *lastCity;
@property (nonatomic,strong) NSString *lastAddress;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) BMKLocationService * locationService;
@property (nonatomic,strong)BMKGeoCodeSearch * geocodesearch;
@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;

+ (MMLocationManager *)shareLocation;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withError:(LocationErrorBlock)locationError;

/**
 *  获取坐标和地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;

/**
 *  获取地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(NSStringBlock)addressBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock;

/**
 *  获取城市和定位失败
 *
 *  @param cityBlock  cityBlock description
 *  @param errorBlock errorBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock;


/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCountry:(NSStringBlock)conturyBlock ;

/**
 *  获取城市坐标 城市名 和 error
 *
 *  @param cityBlock cityBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock withError:(LocationErrorBlock)locationError WithCity:(NSStringBlock )cityName;
@end
