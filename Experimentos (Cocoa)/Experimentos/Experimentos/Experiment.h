//
//  Experiment.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 1/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Experiment : NSObject < NSCoding >
{
    NSString *nombreExperimento;
    NSNumber *masaExperimento;
    NSString *planetaExperimento;
    NSString *tipo;
    NSNumber *alturaExperimento;
    NSNumber *anguloExperimento;
    NSNumber *velocidadExperimento;
    
}

@property NSString *nombreExperimento;
@property NSNumber *masaExperimento;
@property NSString *planetaExperimento;
@property NSString *tipo;
@property NSNumber *alturaExperimento;
@property NSNumber *anguloExperimento;
@property NSNumber *velocidadExperimento;



@end
