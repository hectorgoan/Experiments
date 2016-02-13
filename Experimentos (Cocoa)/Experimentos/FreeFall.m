//
//  FreeFall.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 3/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "FreeFall.h"

#define HOPS (500)                              //"puntos" de dibujado
#define RANDFLOAT() (random()%128/128.0)        //Genera un número float aleatorio

#define GRAV_TIERRA 9.807
#define GRAV_LUNA 1.622
#define GRAV_MARTE 3.711

#define XDIMENSION 11
#define YDIMENSION 11
#define MAXDIMENSION 5

static NSRect funcRect = {-10, -10, 20, 20};    //Dimensiones

@implementation FreeFall

@synthesize planetaExperimento;
@synthesize alturaExperimento;

-(id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    color = [NSColor colorWithCalibratedRed:0.262f green:0.861f blue:0.206f alpha:1.00f];
    
    termCount = (random()% 3)+2;
    terms = 2;
    
    eje = [[NSBezierPath alloc]init];
    caida = [[NSBezierPath alloc]init];
    
    
    
    return self;
}

-(float)valueAt:(float)x
{
    float result = 0;
    
    for (int i=0; i<termCount; i++)
    {
        result = (result * x)+terms;
    }
    return result;
}

-(void)drawInRect:(NSRect)b withGraphicsContext:(NSGraphicsContext *)ctx
{
    NSPoint aPoint;
    NSPoint anotherPoint;
    float distance = funcRect.size.width/HOPS;
    
    [eje removeAllPoints];
    
    [ctx saveGraphicsState];
    
    NSAffineTransform *tf = [NSAffineTransform transform];
    [tf translateXBy:b.size.width/2 yBy:b.size.height/2];
    [tf scaleXBy:b.size.width/funcRect.size.width
             yBy:b.size.height/funcRect.size.height];
    [tf concat];
    
    //DIBUJADO DE EJES
    
    [eje setLineWidth:0.01];
    [color setStroke];
    
    //Dibujamos eje x
    aPoint.x = funcRect.origin.x;
    aPoint.y = 0;
    [eje moveToPoint:aPoint];
    
    while (aPoint.x <= funcRect.origin.x + funcRect.size.width)
    {
        aPoint.y = 0;
        [eje lineToPoint:aPoint];
        aPoint.x += distance;
    }
    
    //Dibujamos eje y
    
    aPoint.x = funcRect.origin.x + funcRect.size.width/2;
    aPoint.y = funcRect.origin.y + funcRect.size.height;
    [eje moveToPoint:aPoint];
    while (aPoint.y >= funcRect.origin.y)
    {
        aPoint.x = 0;
        [eje lineToPoint:aPoint];
        aPoint.y = aPoint.y-distance;
        
    }
    [eje stroke]; //Volcado de los valores PARA EJE
    
    //DIBUJADO DEL EXPERIMENTO
    [caida setLineWidth:0.05];
    NSColor *colorParaCaida = [NSColor colorWithCalibratedRed:0.861f green:0.120f blue:0.199f alpha:1.00f];
    [colorParaCaida setStroke];
    [caida removeAllPoints];
    
    anotherPoint.x = funcRect.origin.x + (funcRect.size.width/2);
    anotherPoint.y = funcRect.origin.y + (funcRect.size.height/2);
    [caida moveToPoint:aPoint];
    
    anotherPoint.x = funcRect.origin.x + (funcRect.size.width/2);
    anotherPoint.y = funcRect.origin.y + (funcRect.size.height/2);
    [caida moveToPoint:anotherPoint];   //Por alguna razón es necesario hacer un doble posicionamiento inicial, sino
                                        //aparece abajo del todo
    
    anotherPoint.x = funcRect.origin.x + (funcRect.size.width/2);
    anotherPoint.y = [alturaExperimento floatValue];  //Nos situamos al 70% de la altura
    [caida moveToPoint:anotherPoint];
    
    float altura = [[self alturaExperimento] floatValue];

    if ([[self planetaExperimento]isEqualToString:@"Tierra"])
    {
        
        while (anotherPoint.y > 0)
        {
            anotherPoint.x = anotherPoint.x + distance;
            NSLog(@"%@",alturaExperimento);
            anotherPoint.y = altura - ((GRAV_TIERRA/2)*(anotherPoint.x * anotherPoint.x));
            [caida lineToPoint:anotherPoint];
        }
        
        
    }
    else if ([[self planetaExperimento]isEqualToString:@"Luna"])
    {
        while (anotherPoint.y > 0)
        {
            anotherPoint.x = anotherPoint.x + distance;
            anotherPoint.y = altura - ((GRAV_LUNA/2)*(anotherPoint.x * anotherPoint.x));
            [caida lineToPoint:anotherPoint];
        }
        
    }else if ([[self planetaExperimento]isEqualToString:@"Marte"])
    {
        while (anotherPoint.y > 0)
        {
            anotherPoint.x = anotherPoint.x + distance;
            anotherPoint.y = altura - ((GRAV_MARTE/2)*(anotherPoint.x * anotherPoint.x));
            [caida lineToPoint:anotherPoint];
        }
        
    }
        
    
    
    
    
    [caida stroke]; //Volcado de los valores PARA EXPERIMENTO
    
    
    [ctx restoreGraphicsState];
    
    
}


@end
