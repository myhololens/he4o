//
//  AIAbsManager.h
//  SMG_NothingIsAll
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 XiaoGang. All rights reserved.
//

#import <Foundation/Foundation.h>

//MARK:===============================================================
//MARK:                     < AINetAbs管理器 >
//MARK:===============================================================
@class AINetAbsFoNode,AIFoNodeBase;
@interface AIAbsManager : NSObject


/**
 *  MARK:--------------------在foNode基础上构建抽象--------------------
 *  @params conFos      : 具象节点们 (item类型为AIFoNodeBase) (外类比时,传入foA和foB) (内类比时传入conFo即可)
 *  @params orderSames  : algNode组
 *  @result : notnull
 */
-(AINetAbsFoNode*) create:(NSArray*)conFos orderSames:(NSArray*)orderSames;

@end
