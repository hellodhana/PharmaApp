//
//  DODurability.h
//  PharmaApp
//
//  Created by Deloitte-1 on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DODurability : NSObject
{
   
    NSNumber *_nrx_mkt_shr_pln;
    NSNumber *_nrx_mkt_shr_act;
    NSNumber *_trx_mkt_shr_pln;
    NSNumber *_trx_mkt_shr_act;
    NSNumber *_nrx_mkt_grth;
    NSNumber *_nrx_mkt_grth_pln;
    NSNumber *_trx_mkt_grth;
    NSNumber *_trx_mkt_grth_pln;
    NSNumber *_trx_nrx_ratio;
    NSNumber *_num_new_pat_strt;
    NSNumber *_num_new_pat_strt_pln;
    NSNumber *_num_swh_pat_strt;
    NSNumber *_num_swh_pat_strt_pln;
    NSNumber *_rlt_copay_pln;
    NSNumber *_rlt_copay_act;
    NSNumber *_durbl_idx_pln;
    NSNumber *_durbl_idx_act;
    
}



@property(nonatomic, retain) NSNumber *nrx_mkt_shr_pln;
@property(nonatomic, retain) NSNumber *nrx_mkt_shr_act;
@property(nonatomic, retain) NSNumber *trx_mkt_shr_pln;
@property(nonatomic, retain) NSNumber *trx_mkt_shr_act;
@property(nonatomic, retain) NSNumber *nrx_mkt_grth;
@property(nonatomic, retain) NSNumber *nrx_mkt_grth_pln;
@property(nonatomic, retain) NSNumber *trx_mkt_grth;
@property(nonatomic, retain) NSNumber *trx_mkt_grth_pln;
@property(nonatomic, retain) NSNumber *trx_nrx_ratio;
@property(nonatomic, retain) NSNumber *num_new_pat_strt;
@property(nonatomic, retain) NSNumber *num_new_pat_strt_pln;
@property(nonatomic, retain) NSNumber *num_swh_pat_strt;
@property(nonatomic, retain) NSNumber *num_swh_pat_strt_pln;
@property(nonatomic, retain) NSNumber *rlt_copay_pln;
@property(nonatomic, retain) NSNumber *rlt_copay_act;
@property(nonatomic, retain) NSNumber *durbl_idx_pln;
@property(nonatomic, retain) NSNumber *durbl_idx_act;


@end
