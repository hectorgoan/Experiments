//
//  ExperimentsAnimationsView.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 4/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "ExperimentsAnimationsView.h"

#import "Experiment.h"
#import <QuartzCore/QuartzCore.h>
#define GRAV_TIERRA 9.807
#define GRAV_LUNA 1.622
#define GRAV_MARTE 3.711


@implementation ExperimentsAnimationsView


@synthesize imageView;
@synthesize isAtStart;
@synthesize startFrame;
@synthesize endFrame;

//Declaración de variables para el manejo de notificaciones
extern NSString * ETTableChangeNotification;


Experiment *experimentoAMostrarAQUI = nil;
NSRect bounds;


//----------------------------------------------------------------------------------------------------------------------------------------

//Método de inicialización
-(id)initWithCoder:(NSCoder *)cod
{
    self = [super initWithCoder:cod];
    if (self)
    {
        
        
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        //Nos suscribimos a la notificación de cambio en el panel
        [nc addObserver:self
               selector:@selector(handleChangeTable: )
                   name:ETTableChangeNotification
                 object:nil];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    
    bounds = [self bounds];  //Recogemos los límites de la zona de dibujado
    if (experimentoAMostrarAQUI != nil)
    {
        if ([[experimentoAMostrarAQUI planetaExperimento] isEqualToString:@"Tierra"])
        {
            
            NSColor *background = [NSColor colorWithCalibratedRed:0.083f green:0.220f blue:0.073f alpha:1.00f];
            [background set];
            [NSBezierPath fillRect:bounds]; //Rellenamos toda la vista
        }else if ([[experimentoAMostrarAQUI planetaExperimento] isEqualToString:@"Marte"])
        {
            
            NSColor *background = [NSColor colorWithCalibratedRed:0.220f green:0.102f blue:0.082f alpha:1.00f];
            [background set];
            [NSBezierPath fillRect:bounds]; //Rellenamos toda la vista
        }else if ([[experimentoAMostrarAQUI planetaExperimento] isEqualToString:@"Luna"])
        {
            
            NSColor *background = [NSColor colorWithCalibratedRed:0.211f green:0.213f blue:0.220f alpha:1.00f];
            [background set];
            [NSBezierPath fillRect:bounds]; //Rellenamos toda la vista
        }
    }
    else
    {
        [[NSColor blackColor]set];
        [NSBezierPath fillRect:bounds]; //Rellenamos toda la vista en negro
    }
   
    
    
}

-(void)clearAllSubviewsOfView :(NSView *)parent
{
    
    for (NSView *subview in [parent subviews])
    {
        [subview removeFromSuperview];
    }
        
    
}


-(void)mouseDown:(NSEvent *)theEvent
{
    if (isAtStart)
    {
        [[imageView animator] setFrame:endFrame];
        isAtStart = NO;
    }else
    {
        [[imageView animator] setFrame:startFrame];
        isAtStart = YES;
        
    }
    
}

//CAÍDA EN VACÍO----

-(void)caidaEnVacioDesde:(NSNumber *)altura yEnPlaneta:(NSString *)planeta
{
    
    
    //Vamos con el experimento
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    NSLog(@"Altura : %@",altura);
    
    alturA = [altura floatValue];
    unidad = (height-50)/10;  //Obtenemos la unidad a la que hay que poner el objeto
    
    
    startFrame = NSMakeRect((width/2.0)-25, unidad * alturA, 50, 50);
    endFrame = NSMakeRect((width/2.0)-25, 0, 50, 50);
    
    imageView = [[NSImageView alloc]initWithFrame:startFrame];
    [imageView setImage:[NSImage imageNamed:@"ball.png"]];
    [imageView setImageScaling:NSImageScaleAxesIndependently];
    
    [self addSubview:imageView];
    [self setUpAnimationDeCaidaEnPlaneta: planeta];
    isAtStart = YES;
    
    [self setNeedsDisplay:YES];

}
- (void)setUpAnimationDeCaidaEnPlaneta: (NSString *)planeta
{
    
    float tiempoCaida;
    float miGravedad = 0.0;
    
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animation];
    
    if ([planeta isEqualToString:@"Tierra"])
    {
        tiempoCaida = sqrtf((alturA*2)/GRAV_TIERRA);
        miGravedad = GRAV_TIERRA;
    }else if ([planeta isEqualToString:@"Marte"])
    {
        tiempoCaida = sqrtf((alturA*2)/GRAV_MARTE);
        miGravedad = GRAV_MARTE;
    }else if ([planeta isEqualToString:@"Luna"])
    {
        tiempoCaida = sqrtf((alturA*2)/GRAV_LUNA);
        miGravedad = GRAV_LUNA;
    }
    
    float unidadTiempoMuestra = tiempoCaida/10.0;
    
    
    keyframeAni.duration = tiempoCaida*2;   //Tiempo duplicado para hacerlo mas bonito
    
    keyframeAni.calculationMode = kCAAnimationLinear;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, (width/2.0)-25, unidad * alturA);
    
    for (int i=0;i<10; i++)
    {
        float t = unidadTiempoMuestra * i;
        float valorY = alturA - (1/2)*miGravedad*(t*t);
        CGPathAddLineToPoint(path, NULL, (width/2.0)-25, valorY);
        
    }
    
    //CGPathAddLineToPoint(path, NULL, (width/2.0)-25, 0);
    
    keyframeAni.path = path;
    
    CGPathRelease(path);
    
    [imageView setAnimations:@{@"frameOrigin": keyframeAni}];
}

//DISPARO PARABÓLICO

-(void)disparoParabolicoConVelocidad: (NSNumber *)velocidad conAngulo:(NSNumber *)angulo yEnPlaneta:(NSString *)planeta
{
    //Vamos con el experimento
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    
    
    unidad = (height-50)/10;  //Obtenemos la unidad a la que hay que poner el objeto
    velocidadINI = [velocidad floatValue];
    anguLO = [angulo floatValue];
    
    //Cálculo del punto final donde estará la pelota
    
    if ([planeta isEqualToString:@"Tierra"])
    {
        alcanceTiro = (([velocidad floatValue] * [velocidad floatValue])*(2*sin([angulo doubleValue] * M_PI/180)*cos([angulo doubleValue]* M_PI/180)))/GRAV_TIERRA;
        
        escalaX = height/35;
        escalaY = width/35;
        
    }else if ([planeta isEqualToString:@"Luna"])
    {
        alcanceTiro = (([velocidad floatValue] * [velocidad floatValue])*(2*sin([angulo doubleValue] * M_PI/180)*cos([angulo doubleValue]* M_PI/180)))/GRAV_LUNA;
        escalaX = height/150;
        escalaY = width/150;
    }else if ([planeta isEqualToString:@"Marte"])
    {
        alcanceTiro = (([velocidad floatValue] * [velocidad floatValue])*(2*sin([angulo doubleValue] * M_PI/180)*cos([angulo doubleValue]* M_PI/180)))/GRAV_MARTE;
        escalaX = height/70;
        escalaY = width/70;
    }
    
    
    
    startFrame = NSMakeRect(0, 0, 25, 25);
    endFrame = NSMakeRect(alcanceTiro*escalaX, 0, 25, 25);
    
    imageView = [[NSImageView alloc]initWithFrame:startFrame];
    [imageView setImage:[NSImage imageNamed:@"ball.png"]];
    [imageView setImageScaling:NSImageScaleAxesIndependently];
    
    [self addSubview:imageView];
    [self setUpAnimationParabolicaEnPlaneta: planeta];
    isAtStart = YES;
    
    [self setNeedsDisplay:YES];
    
}
- (void)setUpAnimationParabolicaEnPlaneta: (NSString *)planeta
{
    float tiempoCaida;
    
    float miGravedad = 0.0;
    
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animation];
    
    if ([planeta isEqualToString:@"Tierra"])
    {
        tiempoCaida = (2*velocidadINI*sin(anguLO * M_PI / 180))/GRAV_TIERRA;
        NSLog(@"Tiempo caida %f", tiempoCaida);
        miGravedad = GRAV_TIERRA;
    }else if ([planeta isEqualToString:@"Marte"])
    {
        tiempoCaida = (2*velocidadINI*sin(anguLO * M_PI / 180))/GRAV_MARTE;
        NSLog(@"Tiempo caida %f", tiempoCaida);
        miGravedad = GRAV_MARTE;
    }else if ([planeta isEqualToString:@"Luna"])
    {
        tiempoCaida = (2*velocidadINI*sin(anguLO * M_PI / 180))/GRAV_LUNA;
        NSLog(@"Tiempo caida %f", tiempoCaida);
        miGravedad = GRAV_LUNA;
    }
    
    float unidadTiempoMuestra = tiempoCaida/200;
    
    keyframeAni.duration = tiempoCaida/5;   //Reducimos el tiempo a la mitad para hacerlo más atractivo
    
    keyframeAni.calculationMode = kCAAnimationLinear;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, alcanceTiro, unidad * alturA);
    
    for (int i=0;i<200; i++)
    {
        float t = unidadTiempoMuestra * i;
        
        float valorY = 0;
        
        
        
        
        float valorX = (velocidadINI * cos(anguLO * M_PI /180) * t)*escalaX;
        
        if ([planeta isEqualToString:@"Tierra"])
        {
            valorY = ((velocidadINI * sin(anguLO * M_PI /180) * t) - ((GRAV_TIERRA * (t*t))/2))*escalaY;
        }else if ([planeta isEqualToString:@"Luna"])
        {
            valorY = ((velocidadINI * sin(anguLO * M_PI /180) * t) - ((GRAV_LUNA * (t*t))/2))*escalaY;
        } else if ([planeta isEqualToString:@"Marte"])
        {
            valorY = ((velocidadINI * sin(anguLO * M_PI /180) * t) - ((GRAV_MARTE * (t*t))/2))*escalaY;
        }
        
        CGPathAddLineToPoint(path, NULL, valorX, valorY);
        
    }
    
    //CGPathAddLineToPoint(path, NULL, (width/2.0)-25, 0);
    
    keyframeAni.path = path;
    
    CGPathRelease(path);
    
    [imageView setAnimations:@{@"frameOrigin": keyframeAni}];
    
}




//DISPARO PARABÓLICO ELEVADO
-(void)disparoParabolicoElevadoDesde: (NSNumber *)altura
                        conVelocidad: (NSNumber *)velocidad
                           conAngulo: (NSNumber *)angulo
                          yEnPlaneta: (NSString *)planeta
{
    //Vamos con el experimento
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    Altura = [altura floatValue];
    
    
    unidad = (height-50)/10;  //Obtenemos la unidad a la que hay que poner el objeto
    velocidadINI = [velocidad floatValue];
    anguLO = [angulo floatValue];
    
    //Cálculo del punto final donde estará la pelota
    
    if ([planeta isEqualToString:@"Tierra"])
    {
        alcanceTiro = ((([velocidad floatValue] * [velocidad floatValue])*(2*sin([angulo doubleValue] * M_PI/180)*cos([angulo doubleValue]* M_PI/180)))/GRAV_TIERRA)+Altura;
        
        escalaX = height/35;
        escalaY = width/35;
        
    }else if ([planeta isEqualToString:@"Luna"])
    {
        alcanceTiro = ((([velocidad floatValue] * [velocidad floatValue])*(2*sin([angulo doubleValue] * M_PI/180)*cos([angulo doubleValue]* M_PI/180)))/GRAV_LUNA)+Altura;
        escalaX = height/150;
        escalaY = width/150;
    }else if ([planeta isEqualToString:@"Marte"])
    {
        alcanceTiro = ((([velocidad floatValue] * [velocidad floatValue])*(2*sin([angulo doubleValue] * M_PI/180)*cos([angulo doubleValue]* M_PI/180)))/GRAV_MARTE)+Altura;
        escalaX = height/70;
        escalaY = width/70;
    }

    [self setUpAnimationParabolicaElevadoEnPlaneta: planeta];
    isAtStart = YES;
    
    [self setNeedsDisplay:YES];
    
}
- (void)setUpAnimationParabolicaElevadoEnPlaneta: (NSString *)planeta
{
    

    float tiempoCaida;
    
    float miGravedad = 0.0;
    
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animation];
    
    if ([planeta isEqualToString:@"Tierra"])
    {
        tiempoCaida = (((velocidadINI/GRAV_TIERRA)*sin(anguLO * M_PI / 180))+sqrt(pow(((velocidadINI/GRAV_TIERRA)*sin(anguLO * M_PI / 180)), 2)) + ((2*Altura)/GRAV_TIERRA));
        NSLog(@"Tiempo caida %f", tiempoCaida);
        miGravedad = GRAV_TIERRA;
    }else if ([planeta isEqualToString:@"Marte"])
    {
        tiempoCaida = (((velocidadINI/GRAV_MARTE)*sin(anguLO * M_PI / 180))+sqrt(pow(((velocidadINI/GRAV_MARTE)*sin(anguLO * M_PI / 180)), 2)) + ((2*Altura)/GRAV_MARTE));
        NSLog(@"Tiempo caida %f", tiempoCaida);
        miGravedad = GRAV_MARTE;
    }else if ([planeta isEqualToString:@"Luna"])
    {
        tiempoCaida = (((velocidadINI/GRAV_LUNA)*sin(anguLO * M_PI / 180))+sqrt(pow(((velocidadINI/GRAV_LUNA)*sin(anguLO * M_PI / 180)), 2)) + ((2*Altura)/GRAV_LUNA));
        NSLog(@"Tiempo caida %f", tiempoCaida);
        miGravedad = GRAV_LUNA;
    }
    
    float unidadTiempoMuestra = tiempoCaida/300;
    
    keyframeAni.duration = tiempoCaida/5;   //Reducimos el tiempo entre 5 para hacerlo mas atractivo
    
    keyframeAni.calculationMode = kCAAnimationLinear;
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, alcanceTiro*escalaX, unidad * alturA);
    
    //La implementación varía un poco respecto al tiro parabólico sin altura inicial.
    //El cálculo del punto final distaba un poco del real, y por tanto meto los valores de la x
    //en un NSMutable array y recojo el último para situarme ahí cuando y==0
    
    float valorY = 0;
    float valorX;
    NSMutableArray *miArrayPosiciones = [[NSMutableArray alloc]init];
    NSNumber *valorXFINAL;
    
    for (int i=0; i<300; i++)
    {
        float t = unidadTiempoMuestra * i;
        
        valorX =(velocidadINI * cos(anguLO * M_PI /180) * t)*escalaX;
        [miArrayPosiciones addObject:[NSNumber numberWithFloat:valorX]];
        
        if ([planeta isEqualToString:@"Tierra"])
        {
            valorY = (Altura+(((velocidadINI * sin(anguLO * M_PI /180) * t) - ((GRAV_TIERRA * (t*t))/2))))*escalaY;
            if (valorY <= 0)
            {
                valorXFINAL = [miArrayPosiciones objectAtIndex:i-1];
                i=301;
                CGPathAddLineToPoint(path, NULL, valorX, 0);
            }
            
        }else if ([planeta isEqualToString:@"Luna"])
        {
            valorY = (Altura+(((velocidadINI * sin(anguLO * M_PI /180) * t) - ((GRAV_LUNA * (t*t))/2))))*escalaY;
            if (valorY <= 0)
            {
                valorXFINAL = [miArrayPosiciones objectAtIndex:i-1];
                i=301;
                CGPathAddLineToPoint(path, NULL, valorX, 0);
            }
            
        } else if ([planeta isEqualToString:@"Marte"])
        {
            valorY = (Altura+(((velocidadINI * sin(anguLO * M_PI /180) * t) - ((GRAV_MARTE * (t*t))/2))))*escalaY;
            if (valorY <= 0)
            {
                valorXFINAL = [miArrayPosiciones objectAtIndex:i-1];
                i=301;
                CGPathAddLineToPoint(path, NULL, valorX, 0);
            }
            
        }
        
        CGPathAddLineToPoint(path, NULL, valorX, valorY);
        
    }
    
    CGPathAddLineToPoint(path, NULL, alcanceTiro*escalaX, 0);
    
    keyframeAni.path = path;
    
    CGPathRelease(path);
    
    startFrame = NSMakeRect(0, Altura*escalaY, 25, 25);
    NSLog(@"valorXFinal %f",[valorXFINAL floatValue]);
    endFrame = NSMakeRect([valorXFINAL floatValue], 0, 25, 25);
    
    imageView = [[NSImageView alloc]initWithFrame:startFrame];
    [imageView setImage:[NSImage imageNamed:@"ball.png"]];
    [imageView setImageScaling:NSImageScaleAxesIndependently];
    
    [self addSubview:imageView];
    
    [imageView setAnimations:@{@"frameOrigin": keyframeAni}];
    
}



//----------------------------------------------------------------------------------------------------------------------------------------

//Reaccion a las notificaciones
//Métodos de manejo de la respuesta a notificaciones
-(void)handleChangeTable: (NSNotification *)aNotification
{
    
    NSDictionary *infoNotification = [aNotification userInfo];
    experimentoAMostrarAQUI = [infoNotification valueForKey:@"experimentoCambia"];
    limpiar = [infoNotification valueForKey:@"Limpiar"];
    
    
    NSString *tipo = [experimentoAMostrarAQUI tipo];
    NSString *planeta = [experimentoAMostrarAQUI planetaExperimento];
    NSNumber *altura = [experimentoAMostrarAQUI alturaExperimento];
    NSNumber *angulo = [experimentoAMostrarAQUI anguloExperimento];
    NSNumber *velocidad = [experimentoAMostrarAQUI velocidadExperimento];
    
    [self setNeedsDisplay:YES];
    
    if ([tipo isEqualToString:@"Caída en vacío"])   //Reproducir caída en vacío
    {
        if ([[self subviews]count] != 0)
        {
            [self clearAllSubviewsOfView:self];
        }
        
        [self caidaEnVacioDesde:altura yEnPlaneta:planeta];
        
        
    }else if ([tipo isEqualToString:@"Disparo parabólico"]) //Reproducir disparo parabólico
    {
        
        if ([[self subviews]count] != 0)
        {
            [self clearAllSubviewsOfView:self];
        }
        [self disparoParabolicoConVelocidad:velocidad conAngulo:angulo yEnPlaneta:planeta];
        
    }else if ([tipo isEqualToString:@"Disparo parabólico elevado"]) //Reproducir disparo parabólico elevado
    {
        if ([[self subviews]count] != 0)
        {
            [self clearAllSubviewsOfView:self];
        }
        [self disparoParabolicoElevadoDesde:altura conVelocidad:velocidad conAngulo:angulo yEnPlaneta:planeta];
        
        
    }
    if ([limpiar isEqualToString:@"Limpiar"])
    {
        if ([[self subviews]count] != 0)
        {
            [self clearAllSubviewsOfView:self];
        }
    }
    
    
}


-(void)dealloc
{
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}




@end
