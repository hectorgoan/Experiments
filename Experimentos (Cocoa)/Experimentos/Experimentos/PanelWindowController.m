//
//  PanelWindowController.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 2/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "PanelWindowController.h"
#import "Experiment.h"
#import "experimentosController.h"

@interface PanelWindowController ()

@end

@implementation PanelWindowController

//Declaraciones para manejo de notificaciones
NSString * ETPanelChangeNotification = @"ETPanelChange";

-(id)init
{
    if (![super initWithWindowNibName:@"PanelWindowController"])  //Hace un control de carga de la interfaz
    {
        return nil;
    }
    return self;
}

-(id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self)
    {
        //AQUÍ VA EL CÓDIGO QUE EN UN NO-PANEL VA EN INIT
        radioButtonSelected = 0;
        
    }
    return  self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    //AQUÍ VA EL CÓDIGO QUE EN UN NO-PANEL IRÍA EN EL awakefromnib
    NSLog(@"Fichero NIB cargado");
}

//Métodos de la funcionalidad del panel
-(IBAction)radioButtonPushed:(id)sender
{
    NSLog(@"radioButtonPushed");
    NSButtonCell *selCell = [sender selectedCell];
    NSString *planetaADevolver;
    
    
    radioButtonSelected = [selCell tag];
    
    if (radioButtonSelected == 1 || radioButtonSelected == 0)
    {
        NSLog(@"Tierra");
        planetaADevolver = @"Tierra";
        
        
        
    }else if (radioButtonSelected == 2)
    {
        NSLog(@"Marte");
        planetaADevolver = @"Marte";
        
        
    }else if (radioButtonSelected == 3)
    {
        NSLog(@"Luna");
        planetaADevolver = @"Luna";
        
    }
    
    
    
    NSDictionary *infoNotification = [NSDictionary dictionaryWithObject:planetaADevolver
                                                                 forKey:@"planetaCAMBIA"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelChangeNotification
                      object:self
                    userInfo:infoNotification];
    
    
}

-(IBAction)sliderHUpdated:(id)sender
{
    NSLog(@"slider Horizontal Updated");
    
    
    NSNumber *masaADevolver = [NSNumber numberWithFloat:[sender floatValue]];
    
    
    NSDictionary *infoNotification = [NSDictionary dictionaryWithObject:masaADevolver
                                                                 forKey:@"masaCAMBIA"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelChangeNotification
                      object:self
                    userInfo:infoNotification];
    
    
    
    
    
    [salidaMasa setFloatValue:[sender floatValue]];
    
}

-(IBAction)sliderAlturaUpdated:(id)sender
{
    NSLog(@"slider Vertical Updated");
    
    
    NSNumber *alturaADevolver = [NSNumber numberWithFloat:[sender floatValue]];
    
    
    NSDictionary *infoNotification = [NSDictionary dictionaryWithObject:alturaADevolver
                                                                 forKey:@"alturaCAMBIA"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelChangeNotification
                      object:self
                    userInfo:infoNotification];
    
    
    
    
    
    [salidaAltura setFloatValue:[sender floatValue]];
    
}

-(IBAction)sliderAnguloUpdated:(id)sender
{
    NSLog(@"slider Vertical Updated");
    
    
    NSNumber *anguloADevolver = [NSNumber numberWithFloat:[sender floatValue]];
    
    
    NSDictionary *infoNotification = [NSDictionary dictionaryWithObject:anguloADevolver
                                                                 forKey:@"anguloCAMBIA"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelChangeNotification
                      object:self
                    userInfo:infoNotification];
    
    
    
    
    
    [salidaAngulo setFloatValue:[sender floatValue]];
    
}

-(IBAction)sliderVelocidadUpdated:(id)sender
{
    NSLog(@"slider Velocidad Updated");
    
    
    NSNumber *velocidadADevolver = [NSNumber numberWithFloat:[sender floatValue]];
    
    
    NSDictionary *infoNotification = [NSDictionary dictionaryWithObject:velocidadADevolver
                                                                 forKey:@"velocidadCAMBIA"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelChangeNotification
                      object:self
                    userInfo:infoNotification];
    
    
    
    
    
    [salidaVelocidad setFloatValue:[sender floatValue]];
    
}
@end
