//
//  StateB.m
//  TBStateMachine
//
//  Created by Julian Krumow on 22.01.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "StateB.h"
#import "TBSMStateMachine.h"

@implementation StateB

- (void)enter:(TBSMState *)sourceState targetState:(TBSMState *)targetState data:(NSDictionary *)data
{
    [self.executionSequence addObject:[NSString stringWithFormat:@"%@_enter", self.name]];
    
    [super enter:sourceState targetState:targetState data:data];
    
    TBSMStateMachine *parentStateMachine = self.parentNode;
    [parentStateMachine scheduleEvent:[TBSMEvent eventWithName:@"DummyEventB" data:nil]];
}

- (void)exit:(TBSMState *)sourceState targetState:(TBSMState *)targetState data:(NSDictionary *)data
{
    [super exit:sourceState targetState:targetState data:data];
    
    [self.executionSequence addObject:[NSString stringWithFormat:@"%@_exit", self.name]];
}

@end