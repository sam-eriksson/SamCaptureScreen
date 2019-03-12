//
//  ScreenCapture.m
//  SamCaptureScreen
//
//  Created by Sam Eriksson on 2018-12-17.
//  Copyright © 2018 Sam Eriksson. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "ScreenCaptureO.h"

@implementation ScreenCapture : NSObject


UInt32 createTimeStamp() {
    NSDate *  date= [NSDate date];
    return (UInt32)([date timeIntervalSince1970]);
}

void takeScreenShotAllDisplays(char * path) {
    CGDisplayCount displayCount;
    CGDirectDisplayID displays[32];
    
    // grab the active displays
    CGGetActiveDisplayList(32, displays, &displayCount);
    
    // go through the list
    for (int i=0; i<displayCount; i++)
    {
        NSMutableString * mpath = [NSMutableString stringWithUTF8String:path];
        [mpath appendString:@"screencapture_"];
        NSString * ts = [NSString stringWithFormat:@"%d",createTimeStamp()];
        [mpath appendString:ts];
        
        CGImageRef screenShot = CGDisplayCreateImage(displays[i]);
        NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
        
        NSData *data = [bitmapRep  representationUsingType: NSBitmapImageFileTypeJPEG
                                                properties: nil];
        NSString * c = [NSString stringWithFormat:@"%d",i];
        [mpath appendString:c];
        [mpath appendString:@".jpg"];
        [data writeToFile:mpath atomically:YES];
    }
    
}

void takeScreenShot(char * path, int display) {
    CGDisplayCount displayCount;
    CGDirectDisplayID displays[32];
    
    // grab the active displays
    CGGetActiveDisplayList(32, displays, &displayCount);
    
    // go through the list
    if ( display<displayCount)
    {
        NSMutableString * mpath = [NSMutableString stringWithUTF8String:path];
        [mpath appendString:@"screencapture_"];
        NSString * ts = [NSString stringWithFormat:@"%d",createTimeStamp()];
        [mpath appendString:ts];
        
        CGImageRef screenShot = CGDisplayCreateImage(displays[display]);
        NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
        
        NSData *data = [bitmapRep  representationUsingType: NSBitmapImageFileTypeJPEG
                                                properties: nil];
        NSString * c = [NSString stringWithFormat:@"%d",display];
        [mpath appendString:c];
        [mpath appendString:@".jpg"];
        [data writeToFile:mpath atomically:YES];
    }
}

void takeScreenShotToFile(char * path, int display, char * filename) {
    CGDisplayCount displayCount;
    CGDirectDisplayID displays[32];
    
    // grab the active displays
    CGGetActiveDisplayList(32, displays, &displayCount);
    
    // go through the list
    if ( display<displayCount)
    {
        NSMutableString * mpath = [NSMutableString stringWithUTF8String:path];
        NSString * filenamet = [NSString stringWithUTF8String:filename];
        [mpath appendString:filenamet];
        
        CGImageRef screenShot = CGDisplayCreateImage(displays[display]);
        NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
        
        NSData *data = [bitmapRep  representationUsingType: NSBitmapImageFileTypeJPEG
                                                properties: nil];
        [data writeToFile:mpath atomically:YES];
    }
}

@end

