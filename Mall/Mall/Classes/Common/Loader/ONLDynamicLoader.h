//
//  ONLDynamicLoader.h
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

static char * _Nullable LEVEL_A = "LEVEL_A";
static char * _Nullable LEVEL_B = "LEVEL_B";
static char * _Nullable LEVEL_C = "LEVEL_C";

typedef void (*ONLDynamicLoaderInjectFunction)(void);

#define CRDYML_SEGMENTNAME "__DATA"
#define QWLoadableSegmentName "__DATA"
#define QWLoadableSectionName "__Section"
#define CRDYML_ATTRIBUTE(sectionName) __attribute((used, section(CRDYML_SEGMENTNAME "," #sectionName )))

#define CRDYML_FUNCTIONS_EXPORT_BEGIN(KEY) \
static void CRDYML_INJECT_##KEY##_FUNCTION(void){

#define CRDYML_FUNCTIONS_EXPORT_END(KEY) \
} \
static ONLDynamicLoaderInjectFunction dymlLoader##KEY##function CRDYML_ATTRIBUTE(KEY) = CRDYML_INJECT_##KEY##_FUNCTION;


NS_ASSUME_NONNULL_BEGIN

@interface ONLDynamicLoader : NSObject

+ (void)executeFunctionsForKey:(char *)key;

@end

NS_ASSUME_NONNULL_END
