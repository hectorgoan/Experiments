//
//  ExperimentsAnimationsView.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 4/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Experiment;




@interface ExperimentsAnimationsView : NSView
{
    NSImageView * imageView;
    BOOL isAtStart;
    NSRect startFrame;
    NSRect endFrame;
    
    
    
    CGFloat width;
    CGFloat height;
    
   
    
    float alturA;
    float unidad;
    
    float velocidadINI;
    float anguLO;
    float alcanceTiro;
    float escalaX;
    float escalaY;
    
    float Altura;
    float llegadaReal;
    int miI;
    
    NSString *limpiar;
    
}

@property NSImageView * imageView;
@property BOOL isAtStart;
@property NSRect startFrame;
@property NSRect endFrame;

-(void)caidaEnVacioDesde: (NSNumber *)altura
              yEnPlaneta: (NSString *)planeta;

-(void)disparoParabolicoConVelocidad: (NSNumber *)velocidad
                           conAngulo: (NSNumber *)angulo
                          yEnPlaneta: (NSString *)planeta;

-(void)disparoParabolicoElevadoDesde: (NSNumber *)altura
                        conVelocidad: (NSNumber *)velocidad
                           conAngulo: (NSNumber *)angulo
                          yEnPlaneta: (NSString *)planeta;

-(void)clearAllSubviewsOfView :(NSView *)parent;

@end
