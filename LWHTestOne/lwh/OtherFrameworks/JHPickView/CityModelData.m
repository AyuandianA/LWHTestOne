//
//  CityModelData.m
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import "CityModelData.h"

@implementation CityModelData



@end

@implementation Province

+ (NSDictionary *)modelCustomPropertyMapper{
    
    
    return @{@"province_id" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    
    return @{@"child":City.class};
}
@end


@implementation City

+ (NSDictionary *)modelCustomPropertyMapper{
    
    
    return @{@"city_id" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    
    return @{@"child":District.class};
}
@end


@implementation District

+ (NSDictionary *)modelCustomPropertyMapper{
    
    
    return @{@"district_id" : @"id"};
}

@end
