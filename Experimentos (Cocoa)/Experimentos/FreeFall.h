//
//  FreeFall.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 3/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FreeFall : NSObject
{
    
    
    NSColor *color;
    NSBezierPath *eje;
    NSBezierPath *caida;
    
    
    NSString *planetaExperimento;
    NSNumber *alturaExperimento;
    
    
    
    int termCount;
    float terms;
}

@property NSString *planetaExperimento;
@property NSNumber *alturaExperimento;


-(float)valueAt: (float)x;
-(void) drawInRect: (NSRect)b
withGraphicsContext:(NSGraphicsContext *)ctx;

@end
