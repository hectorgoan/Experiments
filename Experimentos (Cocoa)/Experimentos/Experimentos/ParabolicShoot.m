//
//  ParabolicShoot.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 4/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "ParabolicShoot.h"
#include "math.h"

#define HOPS (500)                              //"puntos" de dibujado
#define RANDFLOAT() (random()%128/128.0)        //Genera un número float aleatorio

#define GRAV_TIERRA 9.807
#define GRAV_LUNA 1.622
#define GRAV_MARTE 3.711

static NSRect funcRect = {-10, -17, 10*2, 17*2};    //Dimensiones para disparos en la tierra
static NSRect funcRectLUNA = {-50, -70, 50*2, 70*2};    //Dimensiones para disparos en la luna
static NSRect funcRectMARTE = {-17, -33, 17*2, 33*2};    //Dimensiones para disparos en marte

@implementation ParabolicShoot

@synthesize planetaExperimento;
@synthesize alturaExperimento;
@synthesize anguloExperimento;
@synthesize velocidadExperimento;

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
    
    t = 0;
    
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
    
    if ([planetaExperimento isEqualToString:@"Tierra"]) //representación de gráfica en la tierra
    {
        NSAffineTransform *tf = [NSAffineTransform transform];
        [tf translateXBy:b.size.width/2 yBy:b.size.height/2];
        [tf scaleXBy:b.size.width/funcRect.size.width
                 yBy:b.size.height/funcRect.size.height];
        [tf concat];
        
        //DIBUJADO DE EJES
        
        [eje setLineWidth:0.05];
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
        
        //Dibujamos la gráfica del experimento
        [caida setLineWidth:0.07];
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
        
        //NSLog(@"%f --- %f --- ",anotherPoint.x, anotherPoint.y);
        
        anotherPoint.x = anotherPoint.x + 0.01;
        
        anotherPoint.y = ([velocidadExperimento floatValue]*sin([anguloExperimento floatValue] * M_PI / 180)*anotherPoint.x)-(GRAV_TIERRA *((anotherPoint.x * anotherPoint.x)/2));
        while (anotherPoint.y > 0)
        {
            
            anotherPoint.x = anotherPoint.x + 0.01;
                
            anotherPoint.y = ([velocidadExperimento floatValue]*sin([anguloExperimento floatValue] * M_PI / 180)*anotherPoint.x)-(GRAV_TIERRA *((anotherPoint.x * anotherPoint.x)/2));
                
            NSLog(@"%f --- %f --",anotherPoint.x, anotherPoint.y);
            
            [caida lineToPoint:anotherPoint];
            
            
        }
        

        
    } else if ([planetaExperimento isEqualToString:@"Luna"])    //Representamos la gráfica en la luna
    {
        NSAffineTransform *tf = [NSAffineTransform transform];
        [tf translateXBy:b.size.width/2 yBy:b.size.height/2];
        [tf scaleXBy:b.size.width/funcRectLUNA.size.width
                 yBy:b.size.height/funcRectLUNA.size.height];
        [tf concat];
        
        //DIBUJADO DE EJES
        
        [eje setLineWidth:0.1];
        [color setStroke];
        
        //Dibujamos eje x
        aPoint.x = funcRectLUNA.origin.x;
        aPoint.y = 0;
        [eje moveToPoint:aPoint];
        
        while (aPoint.x <= funcRectLUNA.origin.x + funcRectLUNA.size.width)
        {
            aPoint.y = 0;
            [eje lineToPoint:aPoint];
            aPoint.x += distance;
        }
        
        //Dibujamos eje y
        
        aPoint.x = funcRectLUNA.origin.x + funcRectLUNA.size.width/2;
        aPoint.y = funcRectLUNA.origin.y + funcRectLUNA.size.height;
        [eje moveToPoint:aPoint];
        while (aPoint.y >= funcRectLUNA.origin.y)
        {
            aPoint.x = 0;
            [eje lineToPoint:aPoint];
            aPoint.y = aPoint.y-distance;
            
        }
        [eje stroke]; //Volcado de los valores PARA EJE
        
        //Dibujamos la gráfica del experimento
        [caida setLineWidth:0.2];
        NSColor *colorParaCaida = [NSColor colorWithCalibratedRed:0.861f green:0.120f blue:0.199f alpha:1.00f];
        [colorParaCaida setStroke];
        [caida removeAllPoints];
        
        anotherPoint.x = funcRectLUNA.origin.x + (funcRectLUNA.size.width/2);
        anotherPoint.y = funcRectLUNA.origin.y + (funcRectLUNA.size.height/2);
        [caida moveToPoint:aPoint];
        
        anotherPoint.x = funcRectLUNA.origin.x + (funcRectLUNA.size.width/2);
        anotherPoint.y = funcRectLUNA.origin.y + (funcRectLUNA.size.height/2);
        [caida moveToPoint:anotherPoint];   //Por alguna razón es necesario hacer un doble posicionamiento inicial, sino
        //aparece abajo del todo
        
        //NSLog(@"%f --- %f --- ",anotherPoint.x, anotherPoint.y);
        
        anotherPoint.x = anotherPoint.x + 0.01;
        
        anotherPoint.y = ([velocidadExperimento floatValue]*sin([anguloExperimento floatValue] * M_PI / 180)*anotherPoint.x)-(GRAV_LUNA *((anotherPoint.x * anotherPoint.x)/2));
        while (anotherPoint.y > 0)
        {
                
            anotherPoint.x = anotherPoint.x + 0.01;
                
            anotherPoint.y = ([velocidadExperimento floatValue]*sin([anguloExperimento floatValue] * M_PI / 180)*anotherPoint.x)-(GRAV_LUNA *((anotherPoint.x * anotherPoint.x)/2));
                
            //NSLog(@"%f --- %f --",anotherPoint.x, anotherPoint.y);
            [caida lineToPoint:anotherPoint];
        }
        
        
    } else if ([planetaExperimento isEqualToString:@"Marte"])   //Representamos la grárica en marte
    {
        NSAffineTransform *tf = [NSAffineTransform transform];
        [tf translateXBy:b.size.width/2 yBy:b.size.height/2];
        [tf scaleXBy:b.size.width/funcRectMARTE.size.width
                 yBy:b.size.height/funcRectMARTE.size.height];
        [tf concat];
        
        //DIBUJADO DE EJES
        
        [eje setLineWidth:0.1];
        [color setStroke];
        
        //Dibujamos eje x
        aPoint.x = funcRectMARTE.origin.x;
        aPoint.y = 0;
        [eje moveToPoint:aPoint];
        
        while (aPoint.x <= funcRectMARTE.origin.x + funcRectMARTE.size.width)
        {
            aPoint.y = 0;
            [eje lineToPoint:aPoint];
            aPoint.x += distance;
        }
        
        //Dibujamos eje y
        
        aPoint.x = funcRectMARTE.origin.x + funcRectMARTE.size.width/2;
        aPoint.y = funcRectMARTE.origin.y + funcRectMARTE.size.height;
        [eje moveToPoint:aPoint];
        while (aPoint.y >= funcRectMARTE.origin.y)
        {
            aPoint.x = 0;
            [eje lineToPoint:aPoint];
            aPoint.y = aPoint.y-distance;
            
        }
        [eje stroke]; //Volcado de los valores PARA EJE
        
        //Dibujamos la gráfica del experimento
        [caida setLineWidth:0.1];
        NSColor *colorParaCaida = [NSColor colorWithCalibratedRed:0.861f green:0.120f blue:0.199f alpha:1.00f];
        [colorParaCaida setStroke];
        [caida removeAllPoints];
        
        anotherPoint.x = funcRectMARTE.origin.x + (funcRectMARTE.size.width/2);
        anotherPoint.y = funcRectMARTE.origin.y + (funcRectMARTE.size.height/2);
        [caida moveToPoint:aPoint];
        
        anotherPoint.x = funcRectMARTE.origin.x + (funcRectMARTE.size.width/2);
        anotherPoint.y = funcRectMARTE.origin.y + (funcRectMARTE.size.height/2);
        [caida moveToPoint:anotherPoint];   //Por alguna razón es necesario hacer un doble posicionamiento inicial, sino
        //aparece abajo del todo
        
        //NSLog(@"%f --- %f --- ",anotherPoint.x, anotherPoint.y);
        
        anotherPoint.x = anotherPoint.x + 0.01;
        
        anotherPoint.y = ([velocidadExperimento floatValue]*sin([anguloExperimento floatValue] * M_PI / 180)*anotherPoint.x)-(GRAV_MARTE *((anotherPoint.x * anotherPoint.x)/2));
        while (anotherPoint.y > 0)
            {
                
                anotherPoint.x = anotherPoint.x + 0.01;
              
                anotherPoint.y = ([velocidadExperimento floatValue]*sin([anguloExperimento floatValue] * M_PI / 180)*anotherPoint.x)-(GRAV_MARTE *((anotherPoint.x * anotherPoint.x)/2));
                
                //NSLog(@"%f --- %f --",anotherPoint.x, anotherPoint.y);
                [caida lineToPoint:anotherPoint];
            }
        
        
    }
    
    
    
    
    [caida stroke];
    [ctx restoreGraphicsState];
    
    
}


@end
