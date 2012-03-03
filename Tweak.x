#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <dlfcn.h>

@interface DeviceVersions : NSObject
{
    NSMutableDictionary *_deviceMap;
    NSMutableDictionary *_versionMap;
    NSString *_sdksDirectoryPath;
    BOOL _allowOther;
}

+ (id)sharedInstance;
- (id)init;
- (void)dealloc;
- (BOOL)checkFileAtPath:(id)arg1;
- (void)createDeviceMap;
- (void)loadDevicesAtPath:(id)arg1;
- (void)createVersionMap;
- (id)deviceAndVersionInfo;
- (id)productTypes;
- (NSArray *)allDevices;
- (id)currentDevice;
- (void)setCurrentDevice:(id)arg1;
- (id)currentDeviceInfo;
- (id)capabilitiesPlistForCurrentDevice;
- (NSSize)sizeForCurrentDevice;
- (float)scaleForCurrentDevice;
- (id)chromeImageForCurrentDevice;
- (id)homeImageForCurrentDevice;
- (NSPoint)homeOriginForCurrentDevice;
- (id)allVersions;
- (id)allSDKRoots;
- (id)shortVersionString;
- (id)currentDeviceAndVersionString;
- (id)currentSDKRoot;
- (void)setCurrentSDKRoot:(id)arg1;
- (id)sdksDirectoryPath;
- (id)deviceInfoForProductType:(int)arg1;
- (BOOL)updateSDKForCurrentDevice;
- (BOOL)updateDeviceForCurrentSDK;
- (BOOL)sdkSupportsPasteBoard:(id)arg1;
- (BOOL)sdkSupportsShake:(id)arg1;
- (BOOL)sdkSupportsLiveInCallStatusBar:(id)arg1;
- (BOOL)sdkSupportsInCallStatusBar:(id)arg1;
- (BOOL)sdkUsesLegacyEventStruct:(id)arg1;
- (BOOL)sdkUsesLegacyKeyEventStruct:(id)arg1;
- (BOOL)sdkUsesLegacyHandInfoStruct:(id)arg1;
- (BOOL)sdkSupportsHardwareKeyboard:(id)arg1;
- (BOOL)sdkSupportsAccessibility:(id)arg1;
- (BOOL)sdkSupportsTVOut:(id)arg1;
- (BOOL)sdkSupportsHostedLayerEvents:(id)arg1;
- (BOOL)sdkSupportsLocationSimulation:(id)arg1;
- (BOOL)sdkSupportsDispatchMemoryWarnings:(id)arg1;
- (BOOL)sdkIsComplete:(id)arg1;
- (BOOL)sdkIsUnified:(id)arg1;
- (id)sdkBasedOnVersionString:(id)arg1 inverseSearch:(BOOL)arg2;
- (id)sdkPathForVersion:(id)arg1;
- (id)versionForSDKPath:(id)arg1;
- (float)versionFloatForSDKPath:(id)arg1;
- (id)systemPlistFromSDKPath:(id)arg1;
- (id)sdkPlistFromSDKPath:(id)arg1;
- (void)updateUseLegacyStructSizes:(id)arg1;

@end

@interface DeviceInfo : NSObject
{
    NSString *displayName;
    NSString *bundlePath;
    NSString *minimumVersionString;
    NSString *capabilitiesPlist;
    NSSize size;
    NSSize forceSize;
    float scale;
    BOOL canTether;
    BOOL invertX;
    BOOL invertY;
    BOOL transformedTouch;
    NSString *chromeImageName;
    NSImage *chromeImage;
    NSString *homeImageName;
    NSImage *homeImage;
    float homeOriginY;
    NSPoint homeOrigin;
    int productType;
    NSString *productClass;
    NSString *productFamily;
    NSString *deviceBundle;
    NSString *executablePath;
    NSArray *additionalArguments;
    NSDictionary *additionalEnvironment;
}

+ (id)device;
+ (id)deviceWithPath:(id)arg1;
- (id)init;
- (void)dealloc;
- (BOOL)isForcingSize;
- (NSPoint)forceOrigin;
- (id)chromeImage;
- (id)homeImage;
- (id)imageWithName:(id)arg1;
- (id)additionalEnvironment;
- (void)setAdditionalEnvironment:(id)arg1;
- (id)additionalArguments;
- (void)setAdditionalArguments:(id)arg1;
- (id)executablePath;
- (void)setExecutablePath:(id)arg1;
- (id)deviceBundle;
- (void)setDeviceBundle:(id)arg1;
- (id)productFamily;
- (void)setProductFamily:(id)arg1;
- (id)productClass;
- (void)setProductClass:(id)arg1;
- (int)productType;
- (void)setProductType:(int)arg1;
- (NSPoint)homeOrigin;
- (void)setHomeOrigin:(NSPoint)arg1;
- (id)homeImageName;
- (void)setHomeImageName:(id)arg1;
- (id)chromeImageName;
- (void)setChromeImageName:(id)arg1;
- (BOOL)transformedTouch;
- (void)setTransformedTouch:(BOOL)arg1;
- (BOOL)invertY;
- (void)setInvertY:(BOOL)arg1;
- (BOOL)invertX;
- (void)setInvertX:(BOOL)arg1;
- (BOOL)canTether;
- (void)setCanTether:(BOOL)arg1;
- (float)scale;
- (void)setScale:(float)arg1;
- (NSSize)forceSize;
- (void)setForceSize:(NSSize)arg1;
- (NSSize)size;
- (void)setSize:(NSSize)arg1;
- (id)capabilitiesPlist;
- (void)setCapabilitiesPlist:(id)arg1;
- (id)minimumVersionString;
- (void)setMinimumVersionString:(id)arg1;
- (id)bundlePath;
- (void)setBundlePath:(id)arg1;
- (id)displayName;
- (void)setDisplayName:(id)arg1;

@end

%hook DeviceVersions

- (NSSize)sizeForCurrentDevice
{
	NSSize result = %orig;
	if ([@"iPad" isEqual:[self currentDevice]]) {
		result.width += result.width;
		result.height += result.height;
	}
	return result;
}

- (float)scaleForCurrentDevice
{
	float result = %orig;
	if ([@"iPad" isEqual:[self currentDevice]]) {
		result += result;
	}
	return result;
}

- (id)chromeImageForCurrentDevice
{
	if ([@"iPad" isEqual:[self currentDevice]]) {
		static NSImage *image;
		if (!image) {
			NSImage *original = %orig;
			NSSize originalSize = [original size];
			NSSize newSize;
			newSize.width = originalSize.width + originalSize.width;
			newSize.height = originalSize.height + originalSize.height;
			image = [[objc_getClass("NSImage") alloc] initWithSize:newSize];
			[image lockFocus];
			[original drawInRect:(NSRect){{0, 0}, newSize} fromRect:(NSRect){{0, 0}, originalSize} operation: NSCompositeSourceOver fraction: 1.0];
			[image unlockFocus];
		}
		return image;
	}
	return %orig;
}

%end

%ctor {
	if (dlopen("/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone Simulator.app/Contents/MacOS/iPhone Simulator", RTLD_LAZY | RTLD_NOLOAD) || dlopen("/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone Simulator.app/Contents/MacOS/iPhone Simulator", RTLD_LAZY | RTLD_NOLOAD)) {
		%init;
	}
}