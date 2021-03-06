//
//  TBSMStateMachineNestedTests.m
//  TBStateMachineTests
//
//  Created by Julian Krumow on 18.09.14.
//  Copyright (c) 2014-2016 Julian Krumow. All rights reserved.
//

#import <TBStateMachine/TBSMStateMachine.h>
#import <TBStateMachine/TBSMDebugger.h>

SpecBegin(TBSMStateMachineNested)

NSString * const transition_1 = @"transition_1";
NSString * const transition_2 = @"transition_2";
NSString * const transition_3 = @"transition_3";
NSString * const transition_4 = @"transition_4";
NSString * const transition_5 = @"transition_5";
NSString * const transition_6 = @"transition_6";
NSString * const transition_7 = @"transition_7";
NSString * const transition_8 = @"transition_8";
NSString * const transition_9 = @"transition_9";
NSString * const transition_10 = @"transition_10";
NSString * const transition_11 = @"transition_11";
NSString * const transition_12 = @"transition_12";
NSString * const transition_13 = @"transition_13";
NSString * const transition_14 = @"transition_14";

NSString * const transition_15 = @"transition_15";
NSString * const transition_16 = @"transition_16";
NSString * const transition_17 = @"transition_17";
NSString * const transition_18 = @"transition_18";

NSString * const transition_broken_local = @"transition_broken_local";

NSString * const event_data_key = @"DummyDataKey";
NSString * const event_data_value = @"DummyDataValue";

__block TBSMStateMachine *stateMachine;

__block TBSMSubState *a;
__block TBSMState *a1;
__block TBSMState *a2;
__block TBSMState *a3;

__block TBSMSubState *b;
__block TBSMState *b1;

__block TBSMSubState *b2;
__block TBSMState *b21;
__block TBSMState *b22;

__block TBSMParallelState *b3;
__block TBSMState *b311;
__block TBSMState *b312;
__block TBSMState *b321;
__block TBSMState *b322;

__block TBSMSubState *c;
__block TBSMState *c1;
__block TBSMParallelState *c2;
__block TBSMState *c211;
__block TBSMState *c212;
__block TBSMState *c221;
__block TBSMState *c222;

__block TBSMState *z;

__block TBSMFork *fork;
__block TBSMJoin *join;
__block TBSMJunction *junction;

__block TBSMStateMachine *subStateMachineA;
__block TBSMStateMachine *subStateMachineB;
__block TBSMStateMachine *subStateMachineB2;
__block TBSMStateMachine *subStateMachineB31;
__block TBSMStateMachine *subStateMachineB32;
__block TBSMStateMachine *subStateMachineC;
__block TBSMStateMachine *subStateMachineC21;
__block TBSMStateMachine *subStateMachineC22;

__block NSDictionary *eventDataA;
__block NSDictionary *eventDataB;

__block NSMutableArray *executionSequence;


describe(@"TBSMStateMachine", ^{
    
    beforeEach(^{
        
        eventDataA = @{event_data_key : event_data_value};
        eventDataB = @{event_data_key : event_data_value};
        
        stateMachine = [TBSMStateMachine stateMachineWithName:@"StateMachine"];
        a = [TBSMSubState subStateWithName:@"a"];
        
        a1 = [TBSMState stateWithName:@"a1"];
        a2 = [TBSMState stateWithName:@"a2"];
        a3 = [TBSMState stateWithName:@"a3"];
        
        b = [TBSMSubState subStateWithName:@"b"];
        b1 = [TBSMState stateWithName:@"b1"];
        
        b2 = [TBSMSubState subStateWithName:@"b2"];
        b21 = [TBSMState stateWithName:@"b21"];
        b22 = [TBSMState stateWithName:@"b22"];
        
        
        b3 = [TBSMParallelState parallelStateWithName:@"b3"];
        b311 = [TBSMState stateWithName:@"b311"];
        b312 = [TBSMState stateWithName:@"b312"];
        b321 = [TBSMState stateWithName:@"b321"];
        b322 = [TBSMState stateWithName:@"b322"];
        
        c = [TBSMSubState subStateWithName:@"c"];
        c1 = [TBSMState stateWithName:@"c2"];
        c2 = [TBSMParallelState parallelStateWithName:@"c2"];
        c211 = [TBSMState stateWithName:@"c211"];
        c212 = [TBSMState stateWithName:@"c212"];
        c221 = [TBSMState stateWithName:@"c221"];
        c222 = [TBSMState stateWithName:@"c222"];
        
        z = [TBSMState stateWithName:@"z"];
        
        fork = [TBSMFork forkWithName:@"fork"];
        join = [TBSMJoin joinWithName:@"join"];
        junction = [TBSMJunction junctionWithName:@"junction"];
        
        subStateMachineA = [TBSMStateMachine stateMachineWithName:@"smA"];
        subStateMachineB = [TBSMStateMachine stateMachineWithName:@"smB"];
        subStateMachineB2 = [TBSMStateMachine stateMachineWithName:@"smB2"];
        
        subStateMachineB31 = [TBSMStateMachine stateMachineWithName:@"smB31"];
        subStateMachineB32 = [TBSMStateMachine stateMachineWithName:@"smB32"];
        
        subStateMachineC = [TBSMStateMachine stateMachineWithName:@"smC"];
        subStateMachineC21 = [TBSMStateMachine stateMachineWithName:@"smC21"];
        subStateMachineC22 = [TBSMStateMachine stateMachineWithName:@"smC22"];
        
        a.enterBlock = ^(id data) {
            [executionSequence addObject:@"a_enter"];
        };
        
        a.exitBlock = ^(id data) {
            [executionSequence addObject:@"a_exit"];
        };
        
        a1.enterBlock = ^(id data) {
            [executionSequence addObject:@"a1_enter"];
        };
        
        a1.exitBlock = ^(id data) {
            [executionSequence addObject:@"a1_exit"];
        };
        
        a2.enterBlock = ^(id data) {
            [executionSequence addObject:@"a2_enter"];
        };
        
        a2.exitBlock = ^(id data) {
            [executionSequence addObject:@"a2_exit"];
        };
        
        a3.enterBlock = ^(id data) {
            [executionSequence addObject:@"a3_enter"];
        };
        
        a3.exitBlock = ^(id data) {
            [executionSequence addObject:@"a3_exit"];
        };
        
        b.enterBlock = ^(id data) {
            [executionSequence addObject:@"b_enter"];
        };
        
        b.exitBlock = ^(id data) {
            [executionSequence addObject:@"b_exit"];
        };
        
        b1.enterBlock = ^(id data) {
            [executionSequence addObject:@"b1_enter"];
        };
        
        b1.exitBlock = ^(id data) {
            [executionSequence addObject:@"b1_exit"];
        };
        
        b2.enterBlock = ^(id data) {
            [executionSequence addObject:@"b2_enter"];
        };
        
        b2.exitBlock = ^(id data) {
            [executionSequence addObject:@"b2_exit"];
        };
        
        b21.enterBlock = ^(id data) {
            [executionSequence addObject:@"b21_enter"];
        };
        
        b21.exitBlock = ^(id data) {
            [executionSequence addObject:@"b21_exit"];
        };
        
        b22.enterBlock = ^(id data) {
            [executionSequence addObject:@"b22_enter"];
        };
        
        b22.exitBlock = ^(id data) {
            [executionSequence addObject:@"b22_exit"];
        };
        
        b3.enterBlock = ^(id data) {
            [executionSequence addObject:@"b3_enter"];
        };
        
        b3.exitBlock = ^(id data) {
            [executionSequence addObject:@"b3_exit"];
        };
        
        b311.enterBlock = ^(id data) {
            [executionSequence addObject:@"b311_enter"];
        };
        
        b311.exitBlock = ^(id data) {
            [executionSequence addObject:@"b311_exit"];
        };
        
        b312.enterBlock = ^(id data) {
            [executionSequence addObject:@"b312_enter"];
        };
        
        b312.exitBlock = ^(id data) {
            [executionSequence addObject:@"b312_exit"];
        };
        
        b321.enterBlock = ^(id data) {
            [executionSequence addObject:@"b321_enter"];
        };
        
        b321.exitBlock = ^(id data) {
            [executionSequence addObject:@"b321_exit"];
        };
        
        b322.enterBlock = ^(id data) {
            [executionSequence addObject:@"b322_enter"];
        };
        
        b322.exitBlock = ^(id data) {
            [executionSequence addObject:@"b322_exit"];
        };
        
        c.enterBlock = ^(id data) {
            [executionSequence addObject:@"c_enter"];
        };
        
        c.exitBlock = ^(id data) {
            [executionSequence addObject:@"c_exit"];
        };
        
        c1.enterBlock = ^(id data) {
            [executionSequence addObject:@"c1_enter"];
        };
        
        c1.exitBlock = ^(id data) {
            [executionSequence addObject:@"c1_exit"];
        };
        
        c2.enterBlock = ^(id data) {
            [executionSequence addObject:@"c2_enter"];
        };
        
        c2.exitBlock = ^(id data) {
            [executionSequence addObject:@"c2_exit"];
        };
        
        c211.enterBlock = ^(id data) {
            [executionSequence addObject:@"c211_enter"];
        };
        
        c211.exitBlock = ^(id data) {
            [executionSequence addObject:@"c211_exit"];
        };
        
        c212.enterBlock = ^(id data) {
            [executionSequence addObject:@"c212_enter"];
        };
        
        c212.exitBlock = ^(id data) {
            [executionSequence addObject:@"c212_exit"];
        };
        
        c221.enterBlock = ^(id data) {
            [executionSequence addObject:@"c221_enter"];
        };
        
        c221.exitBlock = ^(id data) {
            [executionSequence addObject:@"c221_exit"];
        };
        
        c222.enterBlock = ^(id data) {
            [executionSequence addObject:@"c222_enter"];
        };
        
        c222.exitBlock = ^(id data) {
            [executionSequence addObject:@"c222_exit"];
        };
        
        // superstates / substates guards
        [a addHandlerForEvent:transition_1 target:b];
        [a1 addHandlerForEvent:transition_1 target:a2 kind:TBSMTransitionExternal action:nil guard:^BOOL(id data) {
            return (data && data[event_data_key] == event_data_value);
        }];
        [a1 addHandlerForEvent:transition_1 target:a3 kind:TBSMTransitionExternal action:nil guard:^BOOL(id data) {
            return (data && data[event_data_key] != event_data_value);
        }];
        
        // run to completion test / queuing
        [a2 addHandlerForEvent:transition_2 target:a3 kind:TBSMTransitionExternal action:^(id data) {
            [executionSequence addObject:@"a2_to_a3_action"];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_3 data:nil]];
        }];
        [a3 addHandlerForEvent:transition_3 target:a1];
        
        // lca
        [a3 addHandlerForEvent:transition_4 target:b2];
        [a3 addHandlerForEvent:transition_5 target:b22];
        
        // external transitions
        [a addHandlerForEvent:transition_6 target:a2];
        [a2 addHandlerForEvent:transition_7 target:a];
        
        // local transitions
        [b addHandlerForEvent:transition_8 target:b22 kind:TBSMTransitionLocal];
        [b22 addHandlerForEvent:transition_9 target:b kind:TBSMTransitionLocal];
        
        // local transitions becoming external
        [b addHandlerForEvent:transition_broken_local target:a3 kind:TBSMTransitionLocal];
        
        // internal transitions
        [a1 addHandlerForEvent:transition_10 target:a1 kind:TBSMTransitionInternal action:^(id data) {
            [executionSequence addObject:@"a1_internal_action"];
        }];
        
        [b311 addHandlerForEvent:transition_11 target:b311 kind:TBSMTransitionInternal action:^(id data) {
            [executionSequence addObject:@"b311_internal_action"];
        }];
        [b321 addHandlerForEvent:transition_11 target:b321 kind:TBSMTransitionInternal action:^(id data) {
            [executionSequence addObject:@"b321_internal_action"];
        }];
        
        // out of parallel substate
        [b311 addHandlerForEvent:transition_12 target:a1 kind:TBSMTransitionExternal];
        
        // parallel state with default setup
        [b addHandlerForEvent:transition_13 target:b3];
        
        // parallel state with deep switching
        [a3 addHandlerForEvent:transition_14 target:b322];
        
        // fork into parallel state
        [a addHandlerForEvent:transition_15 target:fork kind:TBSMTransitionExternal action:^(id data) {
            [executionSequence addObject:@"a_to_fork_action"];
        }];
        [fork setTargetStates:@[c212, c222] inRegion:c2];
        
        // join out of parallel state
        [c212 addHandlerForEvent:transition_16 target:join];
        [c222 addHandlerForEvent:transition_17 target:join];
        [join setSourceStates:@[c212, c222] inRegion:c2 target:b];
        
        // junction between b1 and c2
        [junction addOutgoingPathWithTarget:b1 action:nil guard:^BOOL(id data) {
            return (data[@"goB1"] != nil);
        }];
        [junction addOutgoingPathWithTarget:c2 action:^(id data) {
            [executionSequence addObject:@"junction_to_c2_outgoing_path_action"];
        } guard:^BOOL(id data) {
            return (data[@"goC2"] != nil);
        }];
        [a addHandlerForEvent:transition_18 target:junction kind:TBSMTransitionExternal action:^(id data) {
            [executionSequence addObject:@"a_to_junction_ingoing_path_action"];
        }];
        
        subStateMachineB2.states = @[b21, b22];
        subStateMachineB31.states = @[b311, b312];
        subStateMachineB32.states = @[b321, b322];

        subStateMachineC21.states = @[c211, c212];
        subStateMachineC22.states = @[c221, c222];
        
        a.stateMachine = subStateMachineA;
        b.stateMachine = subStateMachineB;
        b2.stateMachine = subStateMachineB2;
        b3.stateMachines = @[subStateMachineB31, subStateMachineB32];
        
        c.stateMachine = subStateMachineC;
        c2.stateMachines = @[subStateMachineC21, subStateMachineC22];
        
        subStateMachineA.states = @[a1, a2, a3];
        subStateMachineB.states = @[b1, b2, b3];
        subStateMachineC.states = @[c1, c2];
        
        stateMachine.states = @[a, b, c];
        
        [[TBSMDebugger sharedInstance] debugStateMachine:stateMachine];
        
        [stateMachine setUp:nil];
        
        executionSequence = [NSMutableArray new];
    });
    
    afterEach(^{
        
        [stateMachine tearDown:nil];
        stateMachine = nil;
        
        a = nil;
        a1 = nil;
        a2 = nil;
        a3 = nil;
        
        b = nil;
        b1 = nil;
        
        b2 = nil;
        b21 = nil;
        b22 = nil;
        
        b3 = nil;
        b311 = nil;
        b312 = nil;
        b321 = nil;
        b322 = nil;
        
        c = nil;
        c1 = nil;
        c2 = nil;
        c211 = nil;
        c212 = nil;
        c221 = nil;
        c222 = nil;
        
        z = nil;
        
        fork = nil;
        join = nil;
        junction = nil;
        
        subStateMachineA = nil;
        subStateMachineB = nil;
        subStateMachineB2 = nil;
        subStateMachineB31 = nil;
        subStateMachineB32 = nil;
        subStateMachineC = nil;
        subStateMachineC21 = nil;
        subStateMachineC22 = nil;
        
        eventDataA = nil;
        eventDataB = nil;
        
        executionSequence = nil;
    });
    
    
    it(@"evalutes the guards and chooses the transition defined on super state.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a_exit",
                                               @"b_enter",
                                               @"b1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"evalutes the guards and chooses the first transition defined on sub state.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:event_data_value}] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a2_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"evalutes the guards and chooses the second transition defined on sub state.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:@(1)}] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a3_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"handles events which are scheduled in the middle of a transition considering the run to completion model.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            a1.enterBlock = ^(id data) {
                [executionSequence addObject:@"a1_enter"];
                done();
            };
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:event_data_value}] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_2 data:nil]];
        });
        
        NSArray *expectedExecutionSequence = @[@"a2_exit",
                                               @"a2_to_a3_action",
                                               @"a3_enter",
                                               @"a3_exit",
                                               @"a1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    
    it(@"switches deep from and into a sub state which enters initial state.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:@(1)}] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_4 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a3_exit",
                                               @"a_exit",
                                               @"b_enter",
                                               @"b2_enter",
                                               @"b21_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"switches even deeper from and into a specified sub state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:@(1)}] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_5 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a3_exit",
                                               @"a_exit",
                                               @"b_enter",
                                               @"b2_enter",
                                               @"b22_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs an external transition from containing source state to contained target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_6 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a_exit",
                                               @"a_enter",
                                               @"a2_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs an external transition from contained source state to containing target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:event_data_value}] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_7 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a2_exit",
                                               @"a_exit",
                                               @"a_enter",
                                               @"a1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs a local transition from containing source state to contained target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:nil] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_8 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"b1_exit",
                                               @"b2_enter",
                                               @"b22_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs a local transition from contained source state to containing target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:@(1)}]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_5 data:nil] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_9 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"b22_exit",
                                               @"b2_exit",
                                               @"b1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"defaults to an external transition when source and target of a local transition are no ancestors.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_broken_local data:nil] withCompletion:^{
                done();
            }];
        });
        
        expect(stateMachine.currentState).to.equal(a);
        expect(subStateMachineA.currentState).to.equal(a3);
    });
    
    it(@"performs an internal transition.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_10 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_10 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_10 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_internal_action",
                                               @"a1_internal_action",
                                               @"a1_internal_action"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs parallel internal transitions.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_13 data:nil] withCompletion:^{
                
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_11 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_11 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"b311_internal_action",
                                               @"b321_internal_action",
                                               @"b311_internal_action",
                                               @"b321_internal_action"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs a transition out of a parallel sub state into a top level state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_13 data:nil] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_12 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"b311_exit",
                                               @"b321_exit",
                                               @"b3_exit",
                                               @"b_exit",
                                               @"a_enter",
                                               @"a1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
    });
    
    it(@"performs a transition into a parallel state and enters default sub states.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_13 data:nil] withCompletion:^{
                done();
            }];
        });
        
        expect(stateMachine.currentState).to.equal(b);
        expect(subStateMachineB.currentState).to.equal(b3);
        expect(subStateMachineB31.currentState).to.equal(b311);
        expect(subStateMachineB32.currentState).to.equal(b321);
    });
    
    it(@"performs a transition into a parallel state and enters specified sub state while entering all other parallel machines with default state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_1 data:@{event_data_key:@(1)}]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_14 data:nil] withCompletion:^{
                done();
            }];
        });
        
        expect(stateMachine.currentState).to.equal(b);
        expect(subStateMachineB.currentState).to.equal(b3);
        expect(subStateMachineB31.currentState).to.equal(b311);
        expect(subStateMachineB32.currentState).to.equal(b322);
    });
    
    it(@"performs a fork compound transition into the specified region.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_15 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a_exit",
                                               @"a_to_fork_action",
                                               @"c_enter",
                                               @"c2_enter",
                                               @"c212_enter",
                                               @"c222_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
        
        expect(stateMachine.currentState).to.equal(c);
        expect(c.stateMachine.currentState).to.equal(c2);
        expect(subStateMachineC21.currentState).to.equal(c212);
        expect(subStateMachineC22.currentState).to.equal(c222);
    });
    
    it(@"performs a join compound transition into the join target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_15 data:nil] withCompletion:^{
                [executionSequence removeAllObjects];
            }];
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_16 data:nil]];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_16 data:nil] withCompletion:^{
                expect(stateMachine.currentState).to.equal(c);
            }];
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_17 data:nil] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"c212_exit",
                                               @"c222_exit",
                                               @"c2_exit",
                                               @"c_exit",
                                               @"b_enter",
                                               @"b1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
        
        expect(stateMachine.currentState).to.equal(b);
    });
    
    it(@"performs a junction compound transition into the first target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_18 data:@{@"goB1":@""}] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a_exit",
                                               @"a_to_junction_ingoing_path_action",
                                               @"b_enter",
                                               @"b1_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
        
        expect(stateMachine.currentState).to.equal(b);
        expect(subStateMachineB.currentState).to.equal(b1);
    });
    
    it(@"performs a junction compound transition into the second target state.", ^{
        
        waitUntil(^(DoneCallback done) {
            
            [stateMachine scheduleEvent:[TBSMEvent eventWithName:transition_18 data:@{@"goC2":@""}] withCompletion:^{
                done();
            }];
        });
        
        NSArray *expectedExecutionSequence = @[@"a1_exit",
                                               @"a_exit",
                                               @"a_to_junction_ingoing_path_action",
                                               @"junction_to_c2_outgoing_path_action",
                                               @"c_enter",
                                               @"c2_enter",
                                               @"c211_enter",
                                               @"c221_enter"];
        
        expect(executionSequence).to.equal(expectedExecutionSequence);
        
        expect(stateMachine.currentState).to.equal(c);
        expect(subStateMachineC.currentState).to.equal(c2);
    });
});

SpecEnd
