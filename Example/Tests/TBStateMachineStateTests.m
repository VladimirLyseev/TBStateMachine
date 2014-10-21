//
//  TBStateMachineStateTests.m
//  TBStateMachineTests
//
//  Created by Julian Krumow on 14.09.14.
//  Copyright (c) 2014 Julian Krumow. All rights reserved.
//

#import <TBStateMachine/TBSMStateMachine.h>

SpecBegin(StateMachineState)

NSString * const EVENT_NAME_A = @"DummyEventA";
NSString * const EVENT_NAME_B = @"DummyEventB";
NSString * const EVENT_DATA_KEY = @"DummyDataKey";
NSString * const EVENT_DATA_VALUE = @"DummyDataValue";

__block TBSMStateMachine *stateMachine;
__block TBSMState *stateA;
__block TBSMState *stateB;

__block TBSMEvent *eventA;
__block TBSMEvent *eventB;
__block TBSMStateMachine *subStateMachineA;
__block TBSMStateMachine *subStateMachineB;
__block TBSMParallelState *parallelStates;
__block NSDictionary *eventDataA;
__block NSDictionary *eventDataB;


describe(@"TBSMState", ^{
    
    beforeEach(^{
        stateA = [TBSMState stateWithName:@"a"];
        eventDataA = @{EVENT_DATA_KEY : EVENT_DATA_VALUE};
        eventDataB = @{EVENT_DATA_KEY : EVENT_DATA_VALUE};
        eventA = [TBSMEvent eventWithName:EVENT_NAME_A];
        eventB = [TBSMEvent eventWithName:EVENT_NAME_B];
        
        stateMachine = [TBSMStateMachine stateMachineWithName:@"stateMachine"];
        subStateMachineA = [TBSMStateMachine stateMachineWithName:@"stateMachineA"];
        subStateMachineB = [TBSMStateMachine stateMachineWithName:@"stateMachineB"];
        parallelStates = [TBSMParallelState parallelStateWithName:@"parallelStates"];
    });
    
    afterEach(^{
        stateA = nil;
        eventDataA = nil;
        eventDataB = nil;
        eventA = nil;
        eventB = nil;
        
        stateMachine = nil;
        subStateMachineA = nil;
        subStateMachineB = nil;
        parallelStates = nil;
    });
    
    describe(@"Exception handling on setup.", ^{
        
        it (@"throws a TBSMException when name is nil.", ^{
            
            expect(^{
                stateA = [TBSMState stateWithName:nil];
            }).to.raise(TBSMException);
            
        });
        
        it (@"throws a TBSMException when name is an empty string.", ^{
            
            expect(^{
                stateA = [TBSMState stateWithName:@""];
            }).to.raise(TBSMException);
            
        });
        
    });
    
    it(@"returns its name.", ^{
        TBSMState *stateXYZ = [TBSMState stateWithName:@"StateXYZ"];
        expect(stateXYZ.name).to.equal(@"StateXYZ");
    });
    
    it(@"registers TBSMEvent instances with a given target TBSMState.", ^{
        
        [stateA registerEvent:eventA target:stateA];
        
        NSDictionary *registeredEvents = stateA.eventHandlers;
        expect(registeredEvents.allKeys).to.haveCountOf(1);
        expect(registeredEvents).to.contain(eventA.name);
        
        TBSMEventHandler *eventHandler = registeredEvents[eventA.name];
        expect(eventHandler.target).to.equal(stateA);
    });
    
    it(@"unregisters TBSMEvent instances.", ^{
        
        [stateA registerEvent:eventA target:stateA];
        [stateA unregisterEvent:eventA];
        
        NSDictionary *registeredEvents = stateA.eventHandlers;
        expect(registeredEvents.allKeys).to.haveCountOf(0);
        expect(registeredEvents).notTo.contain(eventA.name);
    });
    
    it(@"handles events by returning nil or a TBSMTransition containing source and destination state.", ^{
        
        [stateA registerEvent:eventA target:nil];
        [stateA registerEvent:eventB target:stateB];
        
        TBSMTransition *resultA = [stateA handleEvent:eventA data:nil];
        expect(resultA).to.beNil;
        
        TBSMTransition *resultB = [stateA handleEvent:eventB data:nil];
        expect(resultB.sourceState).to.equal(stateA);
        expect(resultB.destinationState).to.equal(stateB);
    });
    
    it(@"returns its path inside the state machine hierarchy.", ^{
        
        subStateMachineB.states = @[stateA];
        TBSMSubState *subStateB = [TBSMSubState subStateWithName:@"subStateB" stateMachine:subStateMachineB];
        subStateMachineA.states = @[subStateB];
        
        parallelStates.states = @[subStateMachineA];
        stateMachine.states = @[parallelStates];
        stateMachine.initialState = parallelStates;
        
        NSArray *path = [stateA getPath];
        
        expect(path.count).to.equal(5);
        expect(path[0]).to.equal(stateMachine);
        expect(path[1]).to.equal(parallelStates);
        expect(path[2]).to.equal(subStateMachineA);
        expect(path[3]).to.equal(subStateB);
        expect(path[4]).to.equal(subStateMachineB);
    });
    
});

SpecEnd