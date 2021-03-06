//
//  AIAbsCMVManager.m
//  SMG_NothingIsAll
//
//  Created by iMac on 2018/7/27.
//  Copyright © 2018年 XiaoGang. All rights reserved.
//

#import "AIAbsCMVManager.h"
#import "AIAbsCMVNode.h"
#import "AICMVNode.h"
#import "AIKVPointer.h"
#import "AINetAbsCMVUtil.h"
#import "AINet.h"
#import "AIPort.h"

/**
 *  MARK:--------------------生成AINetAbsCMVNode--------------------
 */
@implementation AIAbsCMVManager


-(AIAbsCMVNode*) create:(AIKVPointer*)absFo_p aMv_p:(AIKVPointer*)aMv_p bMv_p:(AIKVPointer*)bMv_p {
    //1. 数据
    BOOL valid = ISOK(aMv_p, AIKVPointer.class) && ISOK(bMv_p, AIKVPointer.class) && [STRTOOK(aMv_p.algsType) isEqualToString:bMv_p.algsType] && ISOK(absFo_p, AIKVPointer.class);
    if (!valid) {
        return nil;
    }
    
    return [self create:absFo_p conMvPs:@[aMv_p,bMv_p]];
}


-(AIAbsCMVNode*) create:(AIKVPointer*)absFo_p conMvPs:(NSArray*)conMv_ps{
    //1. 数据
    if (!ARRISOK(conMv_ps)) {
        return nil;
    }
    
    //2. 取algsType & dataSource (每一个conMv都一致,则继承,否则使用cMvNoneIdent)
    NSString *algsType = nil;
    NSString *dataSource = nil;
    for (AIKVPointer *mv_p in conMv_ps) {
        if (algsType == nil) {
            algsType = mv_p.algsType;
        }else if(![algsType isEqualToString:mv_p.algsType]){
            algsType = cMvNoneIdent;
        }
        if (dataSource == nil) {
            dataSource = mv_p.dataSource;
        }else if(![dataSource isEqualToString:mv_p.dataSource]){
            dataSource = cMvNoneIdent;
        }
    }
    
    //3. 将conMv_ps转换为conMvs
    NSMutableArray *conMvs = [[NSMutableArray alloc] init];
    for (AIKVPointer *mv_p in conMv_ps) {
        AICMVNodeBase *conMvNode = [SMGUtils searchObjectForPointer:mv_p fileName:FILENAME_Node time:cRedisNodeTime];
        if (!ISOK(conMvNode, AICMVNodeBase.class)){
            [conMvs addObject:conMvNode];
        }
    }
    
    //4. 创建absCMVNode;
    AIAbsCMVNode *result = [[AIAbsCMVNode alloc] init];
    result.pointer = [SMGUtils createPointer:PATH_NET_ABS_CMV_NODE algsType:algsType dataSource:dataSource isOut:false];
    result.foNode_p = absFo_p;
    
    //5. absUrgentTo
    NSInteger absUrgentTo = [AINetAbsCMVUtil getAbsUrgentTo:conMvs];
    AIPointer *urgentTo_p = [theNet getNetDataPointerWithData:@(absUrgentTo) algsType:algsType dataSource:dataSource];
    if (ISOK(urgentTo_p, AIKVPointer.class)) {
        result.urgentTo_p = (AIKVPointer*)urgentTo_p;
        [theNet setNetReference:result.urgentTo_p target_p:result.pointer difValue:1];//引用插线
    }
    
    //6. absDelta
    NSInteger absDelta = [AINetAbsCMVUtil getAbsDelta:conMvs];
    AIPointer *delta_p = [theNet getNetDataPointerWithData:@(absDelta) algsType:algsType dataSource:dataSource];
    if (ISOK(delta_p, AIKVPointer.class)) {
        result.delta_p = (AIKVPointer*)delta_p;
        [theNet setNetReference:result.delta_p target_p:result.pointer difValue:1];//引用插线
    }
    
    //7. 关联absPort插口 & 存储具象节点;
    AIPort *absPort = [[AIPort alloc] init];
    absPort.target_p = result.pointer;
    for (AICMVNodeBase *conMv in conMvs) {
        [conMv.absPorts addObject:absPort];
        [SMGUtils insertObject:conMv rootPath:conMv.pointer.filePath fileName:FILENAME_Node];
    }
    
    //8. 报告添加direction引用
    [self createdAbsCMVNode:result.pointer delta:absDelta urgentTo:absUrgentTo];
    
    //9. 关联conPorts插口 & 存储抽象节点;
    for (AIPointer *conMv_p in conMv_ps) {
        AIPort *conPort = [[AIPort alloc] init];
        conPort.target_p = conMv_p;
        [result addConPorts:conPort difValue:1];
    }
    [SMGUtils insertObject:result rootPath:result.pointer.filePath fileName:FILENAME_Node time:cRedisNodeTime];
    return result;
}

//MARK:===============================================================
//MARK:                     < private_Method >
//MARK:===============================================================
-(void) createdAbsCMVNode:(AIKVPointer*)absCmvNode_p delta:(NSInteger)delta urgentTo:(NSInteger)urgentTo{
    MVDirection direction = delta < 0 ? MVDirection_Negative : MVDirection_Positive;
    NSInteger difStrong = urgentTo * 2;//暂时先x2;(因为一般是两个相抽象)
    if (ISOK(absCmvNode_p, AIKVPointer.class)) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(aiNetCMVNode_createdAbsCMVNode:mvAlgsType:direction:difStrong:)]) {
            [self.delegate aiNetCMVNode_createdAbsCMVNode:absCmvNode_p mvAlgsType:absCmvNode_p.algsType direction:direction difStrong:difStrong];
        }
    }
}

@end
