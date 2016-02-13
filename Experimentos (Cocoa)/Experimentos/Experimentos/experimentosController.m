//
//  experimentosController.m
//  Experimentos
//
//  Created by Héctor Gonzalo Andrés on 1/11/15.
//  Copyright (c) 2015 Héctor Gonzalo Andrés. All rights reserved.
//

#import "experimentosController.h"
#import "Experiment.h"
#import "PanelWindowController.h" //Import del controller



@implementation experimentosController

//Declaración de variables para el manejo de notificaciones
extern NSString * ETPanelChangeNotification;    //Notif panel

//Declaraciones para manejo de notificaciones
NSString * ETTableChangeNotification = @"ETPanelChange";    //Notif tabla


@synthesize nombreExperimentoDEFAULT;
@synthesize masaExperimentoDEFAULT;
@synthesize planetaExperimentoDEFAULT;
@synthesize tipoDEFAULT;
@synthesize alturaDEFAULT;
@synthesize anguloDEFAULT;
@synthesize velocidadDEFAULT;

//Método de inicialización
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        listaNombreExperimentos = [[NSMutableArray alloc]init];
        listaExperimentos = [[NSMutableArray alloc]init];
        
        [self setNombreExperimentoDEFAULT:@"Nombre por defecto"];
        
        NSNumber *nuevaMasa = [NSNumber numberWithFloat:50.0];
        [self setMasaExperimentoDEFAULT:nuevaMasa];
        
        [self setPlanetaExperimentoDEFAULT:@"Tierra"];
        
        [self setTipoDEFAULT:@"Caída en vacío"];
        
        NSNumber *nuevoAngulo =[NSNumber numberWithFloat:45.0];
        [self setAnguloDEFAULT:nuevoAngulo];
        
        NSNumber *nuevaAltura =[NSNumber numberWithFloat:7.0];
        [self setAlturaDEFAULT:nuevaAltura];
        
        NSNumber *nuevaVelocidad = [NSNumber numberWithFloat:15.0];
        [self setVelocidadDEFAULT:nuevaVelocidad];
        
        
           
        expSelected = 0;

        radioButtonSelected = 0;
        
        //Guardamos la dirección para el centro de notificaciones
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        //Nos suscribimos a la notificación de cambio en el panel
        [nc addObserver:self
               selector:@selector(handleChangeTable: )
                   name:ETPanelChangeNotification
                 object:nil];
        
        
        
        //Cargamos datos
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *savedArray = [currentDefaults objectForKey:@"datos"];
        
        if (savedArray != nil)
        {
            NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
            if (oldArray != nil)
            {
                listaExperimentos = [[NSMutableArray alloc]initWithArray:oldArray];
                
                NSLog(@"%@", listaExperimentos);
                
                for (NSUInteger i = 0; i < [listaExperimentos count]; i++)
                {
                    Experiment *temp = [listaExperimentos objectAtIndex:i];
                    NSString *nombreTemp = [temp nombreExperimento];
                    [listaNombreExperimentos addObject:nombreTemp];
                }
                [miTabla reloadData];
                
            }
            else
            {
                NSLog(@"No hay datos que cargar");
            }
        }
       
        

    }
    return self;
}

-(void)awakeFromNib
{
    [addButton setEnabled:NO];  //El botón de añadir estará desactivado hasta que se escriba una cadena
    //Mayor a un char.
    [deleteButton setEnabled:NO];  //El botón de eliminar estará desactivado hasta que se seleccione algun
    //elemento.
    if ([listaNombreExperimentos count] > 0)
    {
        [deleteAllButton setEnabled:YES];
    }else
    {
        [deleteAllButton setEnabled:NO];    //El botón de eliminar todo estará desactivado
    }
    
    
 
}


//Métodos de respuesta a interacción con los botones
-(IBAction)addButtonPushed:(id)sender
{
    NSLog(@"addButtonPushed");
    NSLog(@"Se añadirá el elemento");
    //
    NSString *nameToAdd = [entradaNombre stringValue];
    if ([listaNombreExperimentos containsObject:nameToAdd])
    {
        NSRunAlertPanel(@"Atención",
                        @"Ya existe un experimento con ese nombre, pruebe a introducir otro",
                        @"Ok",
                        @"",
                        nil);
        return;
    }
    
    Experiment *nuevoExperimento = [[Experiment alloc]init];
    
    
    nuevoExperimento.tipo = tipoDEFAULT;
    nuevoExperimento.nombreExperimento = nameToAdd;
    nuevoExperimento.planetaExperimento = planetaExperimentoDEFAULT;
    nuevoExperimento.masaExperimento = masaExperimentoDEFAULT;
    nuevoExperimento.alturaExperimento = alturaDEFAULT;
    nuevoExperimento.anguloExperimento = anguloDEFAULT;
    nuevoExperimento.velocidadExperimento = velocidadDEFAULT;
    
    if ([nuevoExperimento.tipo isEqualToString:@"Disparo parabólico"] && [nuevoExperimento.planetaExperimento isEqualToString:@"Tierra"])
    {
        [dimensionesAMostrar setStringValue:@""];
    } else if ([nuevoExperimento.tipo isEqualToString:@"Disparo parabólico"] && [nuevoExperimento.planetaExperimento isEqualToString:@"Luna"])
    {
        [dimensionesAMostrar setStringValue:@""];
    }else if ([nuevoExperimento.tipo isEqualToString:@"Disparo parabólico"] && [nuevoExperimento.planetaExperimento isEqualToString:@"Marte"])
    {
        [dimensionesAMostrar setStringValue:@""];
    }else
    {
        [dimensionesAMostrar setStringValue:@""];
    }
    
    
    [listaExperimentos addObject:nuevoExperimento];
    [listaNombreExperimentos addObject:nuevoExperimento.nombreExperimento];
    
    [miTabla reloadData];
    
    [deleteAllButton setEnabled:YES];
    
        
    
    //Actualización de datos
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:listaExperimentos] forKey:@"datos"];
    
    
}
-(IBAction)deleteButtonPushed:(id)sender
{
    NSLog(@"deleteButtonPushed");
    [listaNombreExperimentos removeObjectAtIndex:expSelected];
    [listaExperimentos removeObjectAtIndex:expSelected];
    
    
    [miTabla reloadData];
    
    if (expSelected == [listaNombreExperimentos count])
    {
        [deleteButton setEnabled:NO];
        
    }
    if ([listaNombreExperimentos count]==0)
    {
        [deleteAllButton setEnabled:NO];
    }
    
    //BORRAR LA INFO EN LA REPRESENTACIÓN EN PANTALLA
    [experimentoAMostrar setStringValue:@""];
    [tipoAMostrar setStringValue:@""];
    [masaExpAMostrar setStringValue:@""];
    [planetaExpAMostrar setStringValue:@""];
    [alturaAMostrar setStringValue:@""];
    [velocidadAMostrar setStringValue:@""];
    [anguloAMostrar setStringValue:@""];
    [dimensionesAMostrar setStringValue:@""];
    
    //Limpieza de gráficas y animaciones
    NSString *limpiar = @"Limpiar";
    NSDictionary *infoNotificationTabla = [NSDictionary dictionaryWithObject:limpiar
                                                                      forKey:@"Limpiar"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETTableChangeNotification
                      object:self
                    userInfo:infoNotificationTabla];
    
    
    //Actualización de datos
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:listaExperimentos] forKey:@"datos"];
    
    
}
-(IBAction)deleteAllButtonPushed:(id)sender
{
    NSLog(@"deleteAllButtonPushed");
    [listaNombreExperimentos removeAllObjects];
    [listaExperimentos removeAllObjects];
    [miTabla reloadData];
    
    
    [deleteButton setEnabled:NO];
    [deleteAllButton setEnabled:NO];
    
    //BORRAR LA INFO EN LA REPRESENTACIÓN EN PANTALLA
    [experimentoAMostrar setStringValue:@""];
    [tipoAMostrar setStringValue:@""];
    [masaExpAMostrar setStringValue:@""];
    [planetaExpAMostrar setStringValue:@""];
    [alturaAMostrar setStringValue:@""];
    [velocidadAMostrar setStringValue:@""];
    [anguloAMostrar setStringValue:@""];
    [dimensionesAMostrar setStringValue:@""];
    
    //Limpieza de gráficas y animaciones
    NSString *limpiar = @"Limpiar";
    NSDictionary *infoNotificationTabla = [NSDictionary dictionaryWithObject:limpiar
                                                                      forKey:@"Limpiar"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETTableChangeNotification
                      object:self
                    userInfo:infoNotificationTabla];
    
    
    //Actualización de datos
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:listaExperimentos] forKey:@"datos"];
    
}
-(IBAction)radioButtonPushed:(id)sender
{
    NSLog(@"radioButtonPushed");
    NSButtonCell *selCell = [sender selectedCell];
    NSLog(@"Selected cell is %ld", (long)[selCell tag]);
    
    radioButtonSelected = [selCell tag];
    
    if (radioButtonSelected == 1 || radioButtonSelected == 0)
    {
        
        [self setTipoDEFAULT:@"Caída en vacío"];
    }else if (radioButtonSelected == 2)
    {
        
        [self setTipoDEFAULT:@"Disparo parabólico"];
    }else if (radioButtonSelected == 3)
    {
        
        [self setTipoDEFAULT:@"Disparo parabólico elevado"];
    }
    
    
    
}


//Métodos a implementar por delegar y ser data source de la tabla
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    //El objeto delegado dataSource devolverá el número de filas a mostrar por la tabla
    return [listaNombreExperimentos count];
}
-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //El objeto delegado dataSource responderá devolviendo el objeto a mostar en la fila row de la columna
    //tableColumn
    
    NSString *elemento = [listaNombreExperimentos objectAtIndex:row];
    
    return elemento;
}
-(void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //El objeto delegado dataSource toma el objeto introducido por el usuario en la fila row de la columna
    //tableColum
    
}
-(void)tableViewSelectionIsChanging:(NSNotification *)notification
{
    [deleteButton setEnabled:YES];
}
-(void)tableViewSelectionDidChange: (NSNotification *) aNotification
{
    [deleteButton setEnabled:YES];  //Activamos el botón de eliminar
    NSInteger row=[miTabla selectedRow];
    if (row == -1)
    {
        return;
    }
    
    Experiment *experimentoAMostrarSALIDA = [listaExperimentos objectAtIndex:row];
    
    
    [experimentoAMostrar setStringValue:experimentoAMostrarSALIDA.nombreExperimento];
    NSNumber *masaMOSTAR = [experimentoAMostrarSALIDA masaExperimento];
    NSString *masaMOSTRARstring = [NSString stringWithFormat:@"%@ gr", masaMOSTAR];
    [masaExpAMostrar setStringValue:masaMOSTRARstring];
    [planetaExpAMostrar setStringValue:experimentoAMostrarSALIDA.planetaExperimento];
    [tipoAMostrar setStringValue:experimentoAMostrarSALIDA.tipo];
    
    NSNumber *alturaMOSTAR = [experimentoAMostrarSALIDA alturaExperimento];
    NSString *alturaMOSTRARstring = [NSString stringWithFormat:@"%@ m", alturaMOSTAR];
    [alturaAMostrar setStringValue:alturaMOSTRARstring];
    
    NSNumber *velocidadMOSTAR = [experimentoAMostrarSALIDA velocidadExperimento];
    NSString *velocidadMOSTRARstring = [NSString stringWithFormat:@"%@ m/s", velocidadMOSTAR];
    [velocidadAMostrar setStringValue:velocidadMOSTRARstring];
    
    NSNumber *anguloMOSTAR = [experimentoAMostrarSALIDA anguloExperimento];
    NSString *anguloMOSTRARstring = [NSString stringWithFormat:@"%@ º", anguloMOSTAR];
    [anguloAMostrar setStringValue:anguloMOSTRARstring];
    
    //Notificación a la clase de representar GRAFICAS
    
    
    if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Disparo parabólico"] && [experimentoAMostrarSALIDA.planetaExperimento isEqualToString:@"Tierra"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 17m x 10s"];
        [dimensionesAMostrarAnim setStringValue:@"35m x 35m"];
    } else if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Disparo parabólico"] && [experimentoAMostrarSALIDA.planetaExperimento isEqualToString:@"Luna"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 70m x 50s"];
        [dimensionesAMostrarAnim setStringValue:@"150m x 150m"];
    }else if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Disparo parabólico"] && [experimentoAMostrarSALIDA.planetaExperimento isEqualToString:@"Marte"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 33m x 17s"];
        [dimensionesAMostrarAnim setStringValue:@"70m x 70m"];
    }
    else if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Disparo parabólico elevado"] && [experimentoAMostrarSALIDA.planetaExperimento isEqualToString:@"Tierra"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 25m x 10s"];
        [dimensionesAMostrarAnim setStringValue:@"35m x 35m"];
    }else if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Disparo parabólico elevado"] && [experimentoAMostrarSALIDA.planetaExperimento isEqualToString:@"Luna"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 80m x 50s"];
        [dimensionesAMostrarAnim setStringValue:@"150m x 150m"];
    }else if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Disparo parabólico elevado"] && [experimentoAMostrarSALIDA.planetaExperimento isEqualToString:@"Marte"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 43m x 17s"];
        [dimensionesAMostrarAnim setStringValue:@"70m x 70m"];
    }else if ([experimentoAMostrarSALIDA.tipo isEqualToString:@"Caída en vacío"])
    {
        [dimensionesAMostrar setStringValue:@"Dimensiones: 10m x 10s"];
        [dimensionesAMostrarAnim setStringValue:@"10m x 10m"];
    }else
    {
        [dimensionesAMostrar setStringValue:@""];
        [dimensionesAMostrarAnim setStringValue:@""];
    }
    
    NSDictionary *infoNotificationTabla = [NSDictionary dictionaryWithObject:experimentoAMostrarSALIDA
                                                                 forKey:@"experimentoCambia"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETTableChangeNotification
                      object:self
                    userInfo:infoNotificationTabla];
    
    
    expSelected = row;
    
}

//Métodos de la delegación de TextView
//Métodos de delegación del textView
-(void)controlTextDidChange:(NSNotification *)obj
{
    
    if ([[entradaNombre stringValue]length] > 0)  //Siempre que el texto en el textview sea de longitud 0 el boton no estará
    {                                       //disponible
        [addButton setEnabled:YES];
        [deleteButton setEnabled:NO];
    }else
    {
        [addButton setEnabled:NO];
        [deleteButton setEnabled:NO];
        
    }
    
}

//Método de llamada al panel de control
-(IBAction)mostrarPanel:(id)sender
{
    if (!panelController)   //Esto se lanza si el panel no se ha usado aún
    {
        panelController = [[PanelWindowController alloc]init];
    }
    
    [panelController showWindow:self];  //Hacemos que el panel se muestre
    
}

//Métodos de manejo de la respuesta a notificaciones
-(void)handleChangeTable: (NSNotification *)aNotification
{
    NSLog(@"Notificación %@ recibida en handleChange", aNotification);
    
    NSDictionary *infoNotification = [aNotification userInfo];
    
    NSString *planetaAPoner = [infoNotification valueForKey:@"planetaCAMBIA"];
    NSNumber *masaAPoner = [infoNotification valueForKey:@"masaCAMBIA"];
    NSNumber *alturaAPoner = [infoNotification valueForKey:@"alturaCAMBIA"];
    NSNumber *anguloAPoner = [infoNotification valueForKey:@"anguloCAMBIA"];
    NSNumber *velocidadAPoner = [infoNotification valueForKey:@"velocidadCAMBIA"];
    
    
    if (planetaAPoner != nil)
    {
        [self setPlanetaExperimentoDEFAULT:planetaAPoner];
    }
    if (masaAPoner != nil)
    {
        [self setMasaExperimentoDEFAULT:masaAPoner];
    }
    if (alturaAPoner != nil)
    {
        [self setAlturaDEFAULT:alturaAPoner];
    }
    if (anguloAPoner != nil)
    {
        [self setAnguloDEFAULT:anguloAPoner];
    }
    if (velocidadAPoner != nil)
    {
        [self setVelocidadDEFAULT:velocidadAPoner];
    }
}


-(void)dealloc
{
    listaExperimentos = nil;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

//Método para controlar el comportamiento del botón de cierre

-(BOOL)windowShouldClose:(id)sender
{
    NSInteger answer;   //Haremos que al pulsar la x se nos pregunte si queremos cerrar la ventana y la app.
    
    NSBeep();
    
    answer = NSRunAlertPanel(@"Atención",
                             @"¿Esta seguro de que desea cerrar la ventana?, esta acción finalizará la ejecucción de la aplicación",
                             @"No",
                             @"Si",
                             nil);
    if (answer == NSAlertDefaultReturn)
    {
        return NO;
    }else
    {
        [NSApp terminate:self]; //Sin esto nos cerraría la ventana, pero no la app
        return YES;
    }
}


@end
