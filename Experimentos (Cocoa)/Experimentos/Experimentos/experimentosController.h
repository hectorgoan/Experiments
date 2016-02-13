//
//  experimentosController.h
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 1/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Experiment;
@class PanelWindowController; //Es un "include" del panel, para poder declarar variables
@class Polynomial;
@class ExperimentsViewr;


@interface experimentosController : NSObject <NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate, NSControlTextEditingDelegate>
{
    IBOutlet NSTextField *experimentoAMostrar;
    IBOutlet NSTextField *tipoAMostrar;
    IBOutlet NSTextField *masaExpAMostrar;
    IBOutlet NSTextField *planetaExpAMostrar;
    IBOutlet NSTextField *alturaAMostrar;
    
    IBOutlet NSTextField *dimensionesAMostrar;
    IBOutlet NSTextField *dimensionesAMostrarAnim;
    
    IBOutlet NSTextField *velocidadAMostrar;
    IBOutlet NSTextField *anguloAMostrar;
    
    IBOutlet NSTextField *entradaNombre;
    
    IBOutlet NSButton *addButton;
    IBOutlet NSButton *deleteButton;
    IBOutlet NSButton *deleteAllButton;
    
    IBOutlet NSTableView *miTabla;
    
    //Parte de "model"
    NSMutableArray *listaNombreExperimentos;
    NSUInteger expSelected;
    long radioButtonSelected;
    NSMutableArray *listaExperimentos;
    
    PanelWindowController *panelController;   //Objeto de la clase controladora del panel
    
    NSString *nombreExperimentoDEFAULT;
    NSNumber *masaExperimentoDEFAULT;
    NSString *planetaExperimentoDEFAULT;
    NSString *tipoDEFAULT;
    NSNumber *alturaDEFAULT;
    NSNumber *anguloDEFAULT;
    NSNumber *velocidadDEFAULT;
    
    
    
}

@property NSString *nombreExperimentoDEFAULT;
@property NSNumber *masaExperimentoDEFAULT;
@property NSString *planetaExperimentoDEFAULT;
@property NSString *tipoDEFAULT;
@property NSNumber *alturaDEFAULT;
@property NSNumber *anguloDEFAULT;
@property NSNumber *velocidadDEFAULT;

-(IBAction)addButtonPushed:(id)sender;
-(IBAction)deleteButtonPushed:(id)sender;
-(IBAction)deleteAllButtonPushed:(id)sender;
-(IBAction)radioButtonPushed:(id)sender;

-(IBAction)mostrarPanel:(id)sender;

@end
