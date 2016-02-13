//
//  ParabolicShootElevated.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 10/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ParabolicShootElevated : NSView
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
