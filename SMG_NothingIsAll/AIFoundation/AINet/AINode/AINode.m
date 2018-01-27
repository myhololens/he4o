//
//  AINode.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/9/7.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "AINode.h"

//MARK:===============================================================
//MARK:                     < AINode >
//MARK:===============================================================
@implementation AINode

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.pointer = [aDecoder decodeObjectForKey:@"pointer"];
        self.dataType = [aDecoder decodeObjectForKey:@"dataType"];
        self.absPorts = [aDecoder decodeObjectForKey:@"absPorts"];
        self.conPorts = [aDecoder decodeObjectForKey:@"conPorts"];
        self.propertyPorts = [aDecoder decodeObjectForKey:@"propertyPorts"];
        self.changePorts = [aDecoder decodeObjectForKey:@"changePorts"];
        self.logicPorts = [aDecoder decodeObjectForKey:@"logicPorts"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.pointer forKey:@"pointer"];
    [aCoder encodeObject:self.dataType forKey:@"dataType"];
    [aCoder encodeObject:self.absPorts forKey:@"absPorts"];
    [aCoder encodeObject:self.conPorts forKey:@"conPorts"];
    [aCoder encodeObject:self.propertyPorts forKey:@"propertyPorts"];
    [aCoder encodeObject:self.changePorts forKey:@"changePorts"];
    [aCoder encodeObject:self.logicPorts forKey:@"logicPorts"];
}

-(NSMutableArray *)absPorts{
    if (_absPorts == nil) {
        _absPorts = [[NSMutableArray alloc] init];
    }
    return _absPorts;
}

-(NSMutableArray *)conPorts{
    if (_conPorts == nil) {
        _conPorts = [[NSMutableArray alloc] init];
    }
    return _conPorts;
}

-(NSMutableArray *)propertyPorts{
    if (_propertyPorts == nil) {
        _propertyPorts = [[NSMutableArray alloc] init];
    }
    return _propertyPorts;
}

-(NSMutableArray *)changePorts{
    if (_changePorts == nil) {
        _changePorts = [[NSMutableArray alloc] init];
    }
    return _changePorts;
}

-(NSMutableArray *)logicPorts{
    if (_logicPorts == nil) {
        _logicPorts = [[NSMutableArray alloc] init];
    }
    return _logicPorts;
}

@end


//MARK:===============================================================
//MARK:                     < AIIntanceNode >
//MARK:===============================================================
@implementation AIIntanceNode

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.instanceOf = [aDecoder decodeObjectForKey:@"instanceOf"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.instanceOf forKey:@"instanceOf"];
}

@end


//MARK:===============================================================
//MARK:                     < AIPropertyNode >
//MARK:===============================================================
@implementation AIPropertyNode

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.isClass = [aDecoder decodeObjectForKey:@"isClass"];
        self.valueIs = [aDecoder decodeObjectForKey:@"valueIs"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.isClass forKey:@"isClass"];
    [aCoder encodeObject:self.valueIs forKey:@"valueIs"];
}

@end


//MARK:===============================================================
//MARK:                     < AILogicNode >
//MARK:===============================================================
@implementation AILogicNode

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.resultPorts = [aDecoder decodeObjectForKey:@"resultPorts"];
        self.target = [aDecoder decodeObjectForKey:@"target"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.resultPorts forKey:@"resultPorts"];
    [aCoder encodeObject:self.target forKey:@"target"];
}

@end


//MARK:===============================================================
//MARK:                     < AIChangeNode >
//MARK:===============================================================
@implementation AIChangeNode

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.fromValue = [aDecoder decodeFloatForKey:@"fromValue"];
        self.toValue = [aDecoder decodeFloatForKey:@"toValue"];
        self.target = [aDecoder decodeObjectForKey:@"target"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeFloat:self.fromValue forKey:@"fromValue"];
    [aCoder encodeFloat:self.toValue forKey:@"toValue"];
    [aCoder encodeObject:self.target forKey:@"target"];
}

@end