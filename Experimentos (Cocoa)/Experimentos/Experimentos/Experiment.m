//
//  Experiment.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 1/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "Experiment.h"

@implementation Experiment

@synthesize nombreExperimento;
@synthesize masaExperimento;
@synthesize planetaExperimento;
@synthesize tipo;
@synthesize alturaExperimento;
@synthesize anguloExperimento;
@synthesize velocidadExperimento;

//Métodos de inicialización

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        nombreExperimento = @"NOMBRE DEFAULT";
        masaExperimento = [NSNumber numberWithFloat:50.0];
        planetaExperimento = @"PLANETA DEFAULT";
        tipo = @"TIPO DEFAULT";
        alturaExperimento = [NSNumber numberWithFloat:7.0];
        velocidadExperimento = [NSNumber numberWithFloat:15.0];
        anguloExperimento = [NSNumber numberWithFloat:45.0];
    }
    return self;
}

- (instancetype)initWithName: (NSString *)aName
                        masa: (NSNumber *)aMasa
                     planeta: (NSString *)aPlaneta
                        tipo: (NSString *)aTipo
                      altura: (NSNumber *)unaAltura
                      angulo: (NSNumber *)unAngulo
                   velocidad: (NSNumber *)unaVelocidad
{
    self = [super init];
    if (self)
    {
        nombreExperimento = aName;
        masaExperimento = aMasa;
        planetaExperimento = aPlaneta;
        tipo = aTipo;
        alturaExperimento = unaAltura;
        anguloExperimento = unAngulo;
        velocidadExperimento = unaVelocidad;
    }
    return self;
}

//Métodos para cumplir con la codificación para guardar




-(void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:nombreExperimento forKey:@"nombreExperimento"];
    [encoder encodeObject:masaExperimento forKey:@"masaExperimento"];
    [encoder encodeObject:planetaExperimento forKey:@"planetaExperimento"];
    [encoder encodeObject:tipo forKey:@"tipo"];
    [encoder encodeObject:alturaExperimento forKey:@"alturaExperimento"];
    [encoder encodeObject:anguloExperimento forKey:@"anguloExperimento"];
    [encoder encodeObject:velocidadExperimento forKey:@"velocidadExperimento"];
    
}

-(id) initWithCoder:(NSCoder *)decoder
{
    NSString *NombreExperimento = [decoder decodeObjectForKey:@"nombreExperimento"];
    NSNumber *MasaExperimento = [decoder decodeObjectForKey:@"masaExperimento"];
    NSString *PlanetaExperimento = [decoder decodeObjectForKey:@"planetaExperimento"];
    NSString *Tipo = [decoder decodeObjectForKey:@"tipo"];
    NSNumber *AlturaExperimento = [decoder decodeObjectForKey:@"alturaExperimento"];
    NSNumber *AnguloExperimento = [decoder decodeObjectForKey:@"anguloExperimento"];
    NSNumber *VelocidadExperimento = [decoder decodeObjectForKey:@"velocidadExperimento"];
    
    return [self initWithName:NombreExperimento
                         masa:MasaExperimento
                      planeta:PlanetaExperimento
                         tipo:Tipo
                       altura:AlturaExperimento
                       angulo:AnguloExperimento
                    velocidad:VelocidadExperimento
            
            ];
    
}

@end
