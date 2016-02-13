//
//  ExperimentsView.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 3/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "ExperimentsView.h"
#import "FreeFall.h"
#import "Experiment.h"
#import "ParabolicShoot.h"
#import "ParabolicShootElevated.h"

@implementation ExperimentsView

//Declaración de variables para el manejo de notificaciones
extern NSString * ETTableChangeNotification;

Experiment *experimentoAMostrar = nil;

//Método de inicialización
-(id)initWithCoder:(NSCoder *)cod
{
    self = [super initWithCoder:cod];
    if (self)
    {
        //Initialization code here
        experimentos = [[NSMutableArray alloc]init];
        
        //Guardamos la dirección para el centro de notificaciones
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        //Nos suscribimos a la notificación de cambio en el panel
        [nc addObserver:self
               selector:@selector(handleChangeTable: )
                   name:ETTableChangeNotification
                 object:nil];
        
        
    }
    return self;
}

//Método para código de dibujado
- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    
    
    NSRect bounds = [self bounds];  //Recogemos los límites de la zona de dibujado
    
    NSString *rutaAImagen = [[NSBundle mainBundle] pathForResource:@"bluePattern" ofType:@"jpg"];
    NSImage *miFondo = [[NSImage alloc]initWithContentsOfFile:rutaAImagen];
    NSColor *background = [NSColor colorWithPatternImage:miFondo];
    [background set];
    [NSBezierPath fillRect:bounds]; //Rellenamos toda la vista
    
    NSGraphicsContext *contextoGrafico = [NSGraphicsContext currentContext];
    for (FreeFall *ff in experimentos)
    {
        [ff drawInRect:bounds withGraphicsContext:contextoGrafico];
    }
    
    
    
}

//Métodos de respuesta a las actions
-(IBAction)crearNuevaCaidaLibre:(id)sender enPlaneta:(NSString *)unPlaneta conAltura:(NSNumber *)unaAltura
{
    if ([unPlaneta isEqualToString:@"Tierra"])
    {
        FreeFall *ff = [[FreeFall alloc]init];      //Generamos un nuevo experimento de caída libre
        [ff setPlanetaExperimento:@"Tierra"];
        [ff setAlturaExperimento:unaAltura];
        [experimentos addObject:ff];                //Lo añadimos al array de experimentos
        [self setNeedsDisplay:YES];                 //Refrescamos la vista
        
    }else if ([unPlaneta isEqualToString:@"Luna"])
    {
        
        FreeFall *ff = [[FreeFall alloc]init];
        [ff setPlanetaExperimento:@"Luna"];
        [ff setAlturaExperimento:unaAltura];
        [experimentos addObject:ff];
        [self setNeedsDisplay:YES];
    }else if ([unPlaneta isEqualToString:@"Marte"])
    {
        FreeFall *ff = [[FreeFall alloc]init];
        [ff setPlanetaExperimento:@"Marte"];
        [ff setAlturaExperimento:unaAltura];
        [experimentos addObject:ff];
        [self setNeedsDisplay:YES];
    }
    
    
    
}

-(IBAction)crearNuevoTiroParabolico:(id)sender enPlaneta:(NSString *)unPlaneta conAltura:(NSNumber *)unaAltura yUnAngulo:(NSNumber *)unAngulo yVelocidad:(NSNumber *)unaVelocidad
{
    if ([unPlaneta isEqualToString:@"Tierra"])
    {
        ParabolicShoot *ps = [[ParabolicShoot alloc]init];
        [ps setPlanetaExperimento:@"Tierra"];
        [ps setAlturaExperimento:unaAltura];
        [ps setAnguloExperimento:unAngulo];
        [ps setVelocidadExperimento:unaVelocidad];
        
        [experimentos addObject:ps];                //Lo añadimos al array de experimentos
        [self setNeedsDisplay:YES];                 //Refrescamos la vista
        
    }else if ([unPlaneta isEqualToString:@"Luna"])
    {
        ParabolicShoot *ps = [[ParabolicShoot alloc]init];
        [ps setPlanetaExperimento:@"Luna"];
        [ps setAlturaExperimento:unaAltura];
        [ps setAnguloExperimento:unAngulo];
        [ps setVelocidadExperimento:unaVelocidad];
        
        [experimentos addObject:ps];
        [self setNeedsDisplay:YES];
    }else if ([unPlaneta isEqualToString:@"Marte"])
    {
        ParabolicShoot *ps = [[ParabolicShoot alloc]init];
        [ps setPlanetaExperimento:@"Marte"];
        [ps setAlturaExperimento:unaAltura];
        [ps setAnguloExperimento:unAngulo];
        [ps setVelocidadExperimento:unaVelocidad];
        
        [experimentos addObject:ps];
        [self setNeedsDisplay:YES];
    }
}

-(IBAction)crearNuevoTiroParabolicoElevado:(id)sender enPlaneta:(NSString *)unPlaneta conAltura:(NSNumber *)unaAltura yUnAngulo:(NSNumber *)unAngulo yVelocidad:(NSNumber *)unaVelocidad
{
    if ([unPlaneta isEqualToString:@"Tierra"])
    {
        ParabolicShootElevated *ps = [[ParabolicShootElevated alloc]init];
        [ps setPlanetaExperimento:@"Tierra"];
        [ps setAlturaExperimento:unaAltura];
        [ps setAnguloExperimento:unAngulo];
        [ps setVelocidadExperimento:unaVelocidad];
        
        [experimentos addObject:ps];                //Lo añadimos al array de experimentos
        [self setNeedsDisplay:YES];                 //Refrescamos la vista
        
    }else if ([unPlaneta isEqualToString:@"Luna"])
    {
        ParabolicShootElevated *ps = [[ParabolicShootElevated alloc]init];
        [ps setPlanetaExperimento:@"Luna"];
        [ps setAlturaExperimento:unaAltura];
        [ps setAnguloExperimento:unAngulo];
        [ps setVelocidadExperimento:unaVelocidad];
        
        [experimentos addObject:ps];
        [self setNeedsDisplay:YES];
    }else if ([unPlaneta isEqualToString:@"Marte"])
    {
        ParabolicShootElevated *ps = [[ParabolicShootElevated alloc]init];
        [ps setPlanetaExperimento:@"Marte"];
        [ps setAlturaExperimento:unaAltura];
        [ps setAnguloExperimento:unAngulo];
        [ps setVelocidadExperimento:unaVelocidad];
        
        [experimentos addObject:ps];
        [self setNeedsDisplay:YES];
    }
}


-(IBAction)clear:(id)sender
{
    
    [experimentos removeAllObjects];
    [self setNeedsDisplay:YES];
}

//Reaccion a las notificaciones
//Métodos de manejo de la respuesta a notificaciones
-(void)handleChangeTable: (NSNotification *)aNotification
{
    NSLog(@"Notificación %@ recibida", aNotification);
    NSDictionary *infoNotification = [aNotification userInfo];
    experimentoAMostrar = [infoNotification valueForKey:@"experimentoCambia"];
    
    NSString *tipo = [experimentoAMostrar tipo];
    NSString *planeta = [experimentoAMostrar planetaExperimento];
    NSNumber *altura = [experimentoAMostrar alturaExperimento];
    NSNumber *angulo = [experimentoAMostrar anguloExperimento];
    NSNumber *velocidad = [experimentoAMostrar velocidadExperimento];
    [self setNeedsDisplay:YES];
    
    if ([tipo isEqualToString:@"Caída en vacío"])
    {
        [self clear:self];
        if ([planeta isEqualToString:@"Tierra"])
        {
            [self crearNuevaCaidaLibre:self enPlaneta:@"Tierra" conAltura:altura];
        }else if ([planeta isEqualToString:@"Luna"])
        {
            [self crearNuevaCaidaLibre:self enPlaneta:@"Luna" conAltura:altura];
        }else if ([planeta isEqualToString:@"Marte"])
        {
            [self crearNuevaCaidaLibre:self enPlaneta:@"Marte" conAltura:altura];
        }
        
    }else if ([tipo isEqualToString:@"Disparo parabólico"])
    {
        [self clear:self];
        if ([planeta isEqualToString:@"Tierra"])
        {
            [self crearNuevoTiroParabolico:self enPlaneta:@"Tierra" conAltura:altura yUnAngulo:angulo yVelocidad:velocidad];
        }else if ([planeta isEqualToString:@"Luna"])
        {
            [self crearNuevoTiroParabolico:self enPlaneta:@"Luna" conAltura:altura yUnAngulo:angulo yVelocidad:velocidad];
        }else if ([planeta isEqualToString:@"Marte"])
        {
            [self crearNuevoTiroParabolico:self enPlaneta:@"Marte" conAltura:altura yUnAngulo:angulo yVelocidad:velocidad];
        }
        
        
    }else if ([tipo isEqualToString:@"Disparo parabólico elevado"])
    {
        [self clear:self];
        if ([planeta isEqualToString:@"Tierra"])
        {
            [self crearNuevoTiroParabolicoElevado:self enPlaneta:@"Tierra" conAltura:altura yUnAngulo:angulo yVelocidad:velocidad];
        }else if ([planeta isEqualToString:@"Luna"])
        {
            [self crearNuevoTiroParabolicoElevado:self enPlaneta:@"Luna" conAltura:altura yUnAngulo:angulo yVelocidad:velocidad];
        }else if ([planeta isEqualToString:@"Marte"])
        {
            [self crearNuevoTiroParabolicoElevado:self enPlaneta:@"Marte" conAltura:altura yUnAngulo:angulo yVelocidad:velocidad];
        }
        
    }else
    {
        [self clear:self];
    }
    
    
}


-(void)dealloc
{
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}


@end
