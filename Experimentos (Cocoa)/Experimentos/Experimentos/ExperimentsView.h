//
//  ExperimentsView.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 3/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Experiment;

@interface ExperimentsView : NSView
{
    NSMutableArray *experimentos;
    
}

-(IBAction)crearNuevaCaidaLibre:(id)sender
                      enPlaneta: (NSString *)unPlaneta
                      conAltura: (NSNumber *)unaAltura;
-(IBAction)crearNuevoTiroParabolico:(id)sender
                          enPlaneta: (NSString *)unPlaneta
                          conAltura: (NSNumber *)unaAltura
                          yUnAngulo: (NSNumber *)unAngulo
                         yVelocidad: (NSNumber *)unaVelocidad;
-(IBAction)crearNuevoTiroParabolicoElevado:(id)sender
                          enPlaneta:(NSString *)unPlaneta
                          conAltura:(NSNumber *)unaAltura
                          yUnAngulo:(NSNumber *)unAngulo
                         yVelocidad:(NSNumber *)unaVelocidad;
-(IBAction)clear:(id)sender;



@end
