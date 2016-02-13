//
//  ParabolicShoot.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 4/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ParabolicShoot : NSObject
{
    
    NSColor *color;
    NSBezierPath *eje;
    NSBezierPath *caida;
    
    
    NSString *planetaExperimento;
    NSNumber *alturaExperimento;
    NSNumber *anguloExperimento;
    NSNumber *velocidadExperimento;
    
    
    int termCount;
    float terms;
    
    float t;
}

@property NSString *planetaExperimento;
@property NSNumber *alturaExperimento;
@property NSNumber *anguloExperimento;
@property NSNumber *velocidadExperimento;

-(float)valueAt: (float)x;
-(void) drawInRect: (NSRect)b
withGraphicsContext:(NSGraphicsContext *)ctx;

@end
