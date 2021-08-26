#import "CopyLargeFilePlugin.h"
#if __has_include(<copy_large_file/copy_large_file-Swift.h>)
#import <copy_large_file/copy_large_file-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "copy_large_file-Swift.h"
#endif

@implementation CopyLargeFilePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCopyLargeFilePlugin registerWithRegistrar:registrar];
}
@end
