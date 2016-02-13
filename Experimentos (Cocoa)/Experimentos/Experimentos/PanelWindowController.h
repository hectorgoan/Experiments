//
//  PanelWindowController.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 2/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PanelWindowController : NSWindowController
{
    IBOutlet NSTextField *salidaMasa;    
    IBOutlet NSSlider *sliderMasa;
    
    IBOutlet NSTextField *salidaAltura;
    IBOutlet NSSlider *sliderAltura;
    
    IBOutlet NSTextField *salidaAngulo;
    IBOutlet NSSlider *sliderAngulo;
    
    IBOutlet NSTextField *salidaVelocidad;
    IBOutlet NSSlider *sliderVelocidad;
    
    long radioButtonSelected;
}

-(IBAction)radioButtonPushed:(id)sender;
-(IBAction)sliderHUpdated:(id)sender;

-(IBAction)sliderAlturaUpdated:(id)sender;


-(IBAction)sliderAnguloUpdated:(id)sender;

-(IBAction)sliderVelocidadUpdated:(id)sender;

@end
