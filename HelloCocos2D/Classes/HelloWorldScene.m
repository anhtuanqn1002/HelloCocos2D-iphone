//
//  HelloWorldScene.m
//
//  Created by : Nguyen Van Anh Tuan
//  Project    : HelloCocos2D
//  Date       : 3/28/16
//
//  Copyright (c) 2016 Nguyen Van Anh Tuan.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "HelloWorldScene.h"
#import "OALSimpleAudio.h"
#import "OALAudioTrack.h"
#import "OALAudioTracks.h"
#import "OALAudioSession.h"
#import "CCFileUtils.h"

// -----------------------------------------------------------------

@interface HelloWorldScene ()

@property (nonatomic, strong) OALSimpleAudio *audio;
@property (nonatomic, strong) OALAudioTrack *track;
@property (nonatomic, strong) OALAudioTracks *listAudio;
@property (nonatomic, strong) OALAudioTrack *t;
@property (nonatomic, strong) NSMutableArray *l;

@end


// -----------------------------------------------------------------------

@implementation HelloWorldScene

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");
    
//    // Background
//    CCSprite9Slice *background = [CCSprite9Slice spriteWithImageNamed:@"white_square.png"];
//    background.anchorPoint = CGPointZero;
//    background.contentSize = [CCDirector sharedDirector].viewSize;
//    background.color = [CCColor grayColor];
//    [self addChild:background];
//    
//    // The standard Hello World text
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"ArialMT" fontSize:64];
//    label.positionType = CCPositionTypeNormalized;
//    label.position = (CGPoint){0.5, 0.5};
//    [self addChild:label];
    
    //---------------------------------------------------
    // OALSimpleAudio
    // --- Background music
    self.audio = [OALSimpleAudio sharedInstance];
//    [self.audio playBg:@"LKDJ.mp3" volume:1.0 pan:0 loop:YES];
    [self.audio playBg:@"Dragonball.mp3"];
    
    // --- Effects music
    // 1
    CCButton *button1 = [CCButton buttonWithTitle:@"Powerup9"];
    button1.position = ccp(100, 100);
    [self addChild:button1];
    [button1 setTarget:self selector:@selector(touchInside1:)];
    
    
    // 2
    CCButton *button2 = [CCButton buttonWithTitle:@"Powerup9"];
    button2.position = ccp(300, 100);
    [self addChild:button2];
    [button2 setTarget:self selector:@selector(touchInside2:)];
    
    // 3 -> mute
    CCButton *mute = [CCButton buttonWithTitle:@"Mute"];
    mute.position = CGPointMake(self.contentSize.width, self.contentSize.height);
    mute.anchorPoint = CGPointMake(1, 1);
    [self addChild:mute];
    [mute setTarget:self selector:@selector(touchInsideMute:)];
    
    
    // 4 -> stop
    CCButton *stop = [CCButton buttonWithTitle:@"Stop"];
    stop.position = CGPointMake(self.contentSize.width/2, self.contentSize.height);
    stop.anchorPoint = CGPointMake(0.5, 1);
    [self addChild:stop];
    [stop setTarget:self selector:@selector(touchInsideStop:)];
    
    //---------------------------------------------------
    // OALAudioTrack & OALAudioTracks
    self.listAudio = [OALAudioTracks new];
    
    // 5
    OALAudioTrack *track1 = [OALAudioTrack track];
    [track1 preloadFile:@"Powerup9.wav"];
    [track1 play];
    
    // 6
    OALAudioTrack *track2 = [OALAudioTrack track];
    [track2 preloadFile:@"Dragonball.mp3"];
    
    // 7
    OALAudioTrack *track3 = [OALAudioTrack track];
    [track3 preloadFile:@"LKDJ.mp3"];
    
    // 8
    self.l = [NSMutableArray new];
    [self.l addObjectsFromArray:@[track1, track2, track3]];
    [[self.listAudio tracks] arrayByAddingObjectsFromArray:self.l];
    [(OALAudioTrack *)[[self.listAudio tracks] objectAtIndex:0] play];
    for (NSInteger i = 1; i < [self.listAudio tracks].count; i++) {
        [[[self.listAudio tracks] objectAtIndex:i] playAfterTrack:[[self.listAudio tracks] objectAtIndex:i-1]];
    }
    
    //---------------------------------------------------
    // OALAudioSession
    
    
    // done
    return self;
}

- (void)update:(CCTime)delta {
//    CCLOG(@"bbbb - %d", [self.track play]);
}
- (void)playTrack:(id)sender {
    CCLOG(@"aaaa");
}
- (void)touchInside1:(id)sender {
    NSLog(@"Touch up inside a button1");
    [self.audio playEffect:@"Powerup7.wav"];
}

- (void)touchInside2:(id)sender {
    NSLog(@"Touch up inside a button2");
    [self.audio playEffect:@"Laser_Shoot5.wav" volume:1.0 pitch:1.0 pan:0 loop:NO];
}

- (void)touchInsideMute:(id)sender {
    NSLog(@"Touch up inside mute");
    if ([self.audio muted]) {
        [self.audio setMuted:NO];
    } else {
        [self.audio setMuted:YES];
    }
}

- (void)touchInsideStop:(id)sender {
    NSLog(@"Touch up inside stop");
    [self.audio stopEverything];
    [self.listAudio stopAllTracks];
}


// -----------------------------------------------------------------------

@end























// why not add a few extra lines, so we dont have to sit and edit at the bottom of the screen ...
