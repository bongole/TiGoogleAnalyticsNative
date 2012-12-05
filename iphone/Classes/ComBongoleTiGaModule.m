/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComBongoleTiGaModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComBongoleTiGaModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"54152eb6-1eae-4641-9f74-1a9072510d3e";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.bongole.ti.ga";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)start:(id)args
{
    NSString *account;
    NSNumber *dispatchInterval;
    NSNumber *debug;
    NSNumber *anonymizeIp;
    NSNumber *sampleRate;
    
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_ARG_FOR_KEY(account, args, @"account", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(dispatchInterval, args, @"dispatchInterval", NSNumber);
    ENSURE_ARG_OR_NIL_FOR_KEY(anonymizeIp, args, @"anonymizeIp", NSNumber);
    ENSURE_ARG_OR_NIL_FOR_KEY(sampleRate, args, @"sampleRate", NSNumber);
    
    ENSURE_UI_THREAD_1_ARG(args);
    
    if( dispatchInterval == nil ){
        dispatchInterval = [NSNumber numberWithInt:20];
    }
    
    if( debug == nil ){
        debug = [NSNumber numberWithBool:NO];
    }
    
    if( anonymizeIp == nil ){
        anonymizeIp = [NSNumber numberWithBool:NO];
    }
    
    if( sampleRate == nil ){
        sampleRate = [NSNumber numberWithInt: 100];
    }
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].debug = [debug boolValue];
    [GAI sharedInstance].dispatchInterval = [dispatchInterval intValue];
    
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:account];
    if( tracker != nil ){
        [tracker setSampleRate:[sampleRate doubleValue]];
        [tracker setAnonymize:[anonymizeIp boolValue]];
    }
}

-(void)startSession
{
    ENSURE_UI_THREAD_0_ARGS;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    tracker.sessionStart = YES;
}

-(void)stopSession
{
    ENSURE_UI_THREAD_0_ARGS;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    tracker.sessionStart = NO;
}

-(void)trackView:(id)args
{
    NSString *viewName;
    
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_ARG_OR_NIL_FOR_KEY(viewName, args, @"viewName", NSString);
    
    ENSURE_UI_THREAD_1_ARG(args);
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker trackView:viewName];
}

-(void)trackEvent:(id)args
{
    NSString *category;
    NSString *action;
    NSString *label;
    NSNumber *value;
    
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_ARG_OR_NIL_FOR_KEY(category, args, @"category", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(action, args, @"action", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(label, args, @"label", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(value, args, @"value", NSNumber);
    
    ENSURE_UI_THREAD_1_ARG(args);
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker trackEventWithCategory:category withAction:action withLabel:label withValue:value];
}

-(void)trackTiming:(id)args
{
    NSString *category;
    NSNumber *value;
    NSString *name;
    NSString *label;
    
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_ARG_FOR_KEY(category, args, @"category", NSString);
    ENSURE_ARG_FOR_KEY(value, args, @"value", NSNumber);
    ENSURE_ARG_OR_NIL_FOR_KEY(name, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(label, args, @"label", NSString);
    
    ENSURE_UI_THREAD_1_ARG(args);
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker trackTimingWithCategory:category withValue:[value doubleValue] withName:name withLabel:label];
}
@end
