using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;




namespace Experimentos
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>

    

    public partial class MainWindow : Window    //MODEL VIEW (the .xaml is the VIEW)
    {
        public static Preferences prefWindow = null;
        public static Canvas animacion;
        public static Canvas grafica;
        public static Label miLabel;




        public MainWindow()
        {

            //---------------------------------------//
            //          APP LOGIC GOES HERE          //
            //---------------------------------------//
            InitializeComponent();
            animacion = AnimationCanvas;
            grafica = GraphicCanvas;
            miLabel = Salida_Dimensiones;
        
            double altura = grafica.Height; //"animacion" and "grafica" have the same size
            double anchura = grafica.Width;

            //X axis
            Line ejex = new Line();
            ejex.Stroke = Brushes.Red;
            ejex.StrokeThickness = .5;
            ejex.X1 = 0;
            ejex.Y1 = altura / 2;
            ejex.X2 = anchura;
            ejex.Y2 = altura / 2;
            //Y axis
            Line ejey = new Line();
            ejey.Stroke = Brushes.Red;
            ejey.StrokeThickness = .5;
            ejey.X1 = anchura / 2;
            ejey.Y1 = 0;
            ejey.X2 = anchura / 2;
            ejey.Y2 = altura;

            //Vertical lines
            double unidad = anchura / 100;
            for (int i = 0; i < 100; i++)
            {
                Line vert = new Line();
                vert.Stroke = Brushes.Black;
                vert.StrokeThickness = .25;
                vert.X1 = i * unidad;
                vert.Y1 = 0;
                vert.X2 = i * unidad;
                vert.Y2 = altura;

                grafica.Children.Add(vert);
                
            }

            //Horizontal lines
            for (int i = 0; i < 100; i++)
            {
                Line horiz = new Line();
                horiz.Stroke = Brushes.Black;
                horiz.StrokeThickness = .25;
                horiz.X1 = 0;
                horiz.Y1 = i * unidad;
                horiz.X2 = anchura;
                horiz.Y2 = i * unidad;

                grafica.Children.Add(horiz);
                
            }


            //Adding axis
            grafica.Children.Add(ejex);
            grafica.Children.Add(ejey);



        }

        //--------Events------

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            if(prefWindow == null)  
            {
                prefWindow = new Preferences();
                prefWindow.Owner = this;
                prefWindow.Show();
            }else
            {
                prefWindow.Focus();
            }
            //Hacer que al cerrar ventana se vacíe la variable que hace que no se muestre again
        }

        private void MenuItem_Click_1(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        
    }
    
    //Representation's class
    public class Representaciones
    {
        public static float GRAV_TIERRA = 9.807f;
        public static float GRAV_LUNA = 1.622f;
        public static float GRAV_MARTE = 3.711f;

        public static int count;
        


        public void representarGrafica(Experimento e)
        {
            double altura =  MainWindow.grafica.Height; //"animacion" and "grafica" have the same size
            double anchura = MainWindow.grafica.Width;

            MainWindow.grafica.Children.Clear();

            //X axis
            Line ejex = new Line();
            ejex.Stroke = Brushes.Red;
            ejex.StrokeThickness = .5;
            ejex.X1 = 0;
            ejex.Y1 = altura / 2;
            ejex.X2 = anchura;
            ejex.Y2 = altura / 2;
            //Y axis
            Line ejey = new Line();
            ejey.Stroke = Brushes.Red;
            ejey.StrokeThickness = .5;
            ejey.X1 = anchura / 2;
            ejey.Y1 = 0;
            ejey.X2 = anchura / 2;
            ejey.Y2 = altura;

            //Vertical lines
            double unidad = anchura / 100;
            for(int i=0; i<100; i++)
            {
                Line vert = new Line();
                vert.Stroke = Brushes.Black;
                vert.StrokeThickness = .25;
                vert.X1 = i*unidad;
                vert.Y1 = 0;
                vert.X2 = i*unidad;
                vert.Y2 = altura;

                MainWindow.grafica.Children.Add(vert);
            }

            //Horizontal lines
            for (int i = 0; i < 100; i++)
            {
                Line horiz = new Line();
                horiz.Stroke = Brushes.Black;
                horiz.StrokeThickness = .25;
                horiz.X1 = 0;
                horiz.Y1 = i * unidad;
                horiz.X2 = anchura;
                horiz.Y2 = i * unidad;

                MainWindow.grafica.Children.Add(horiz);
            }
            
            //FREE FALL
            if(e.tipo == "Caída Libre") 
            {
                
                if (e.planeta == "Tierra")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) x 250m(eje y) (rangos > 0)";

                    double t = 0;
                    while((altura / 2) + (e.altura - (GRAV_TIERRA / 2 * (t * t))) > (altura / 2))
                    {
                        //x,y
                        Point point = new Point((anchura / 2)+t*10, (altura / 2) + (e.altura - (GRAV_TIERRA/2*(t*t)))); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
                else if(e.planeta == "Luna")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) x 250m(eje y) (rangos > 0)";

                    double t = 0;
                    while ((altura / 2) + (e.altura - (GRAV_LUNA / 2 * (t * t))) > (altura / 2))
                    {
                        //x,y
                        Point point = new Point((anchura / 2) + t * 10, (altura / 2) + (e.altura - (GRAV_LUNA / 2 * (t * t)))); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
                else if(e.planeta == "Marte")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) x 250m(eje y) (rangos > 0)";

                    double t = 0;
                    while ((altura / 2) + (e.altura - (GRAV_MARTE / 2 * (t * t))) > (altura / 2))
                    {
                        //x,y
                        Point point = new Point((anchura / 2) + t * 10, (altura / 2) + (e.altura - (GRAV_MARTE / 2 * (t * t)))); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);
                }

            }
            else if(e.tipo == "Tiro Parabólico")
            {
                if (e.planeta == "Tierra")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) x 50m(eje y) (rangos > 0)";

                    double t = 0;
                    double angRads = e.angulo * 0.0174533;
                    while ((altura / 2) + 10*((e.velocidad * Math.Sin(angRads) * t) - (GRAV_TIERRA * (t * t)) / 2) > (altura/2)-1)
                    {
                        
                        //x,y                   zero                   zero
                        Point point = new Point((anchura / 2) + t*10, (altura / 2) +  10*((e.velocidad * Math.Sin(angRads) * t) - (GRAV_TIERRA*(t*t))/2)); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);


                }
                else if (e.planeta == "Luna")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) x 250m(eje y) (rangos > 0)";

                    double t = 0;
                    double angRads = e.angulo * 0.0174533;
                    while ((altura / 2) + ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_LUNA * (t * t)) / 2) > (altura / 2) - 1)
                    {

                        //x,y                   zero                   zero
                        Point point = new Point((anchura / 2) + t * 10, (altura / 2) + ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_LUNA * (t * t)) / 2)); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
                else if (e.planeta == "Marte")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) x 175m(eje y) (rangos > 0)";


                    double t = 0;
                    double angRads = e.angulo * 0.0174533;
                    while ((altura / 2) + 5 * ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_MARTE * (t * t)) / 2) > (altura / 2) - 1)
                    {

                        //x,y                   zero                   zero
                        Point point = new Point((anchura / 2) + t * 5, (altura / 2) + 5 * ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_MARTE * (t * t)) / 2)); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
            }
            else if(e.tipo == "Tiro Parabólico Elevado")
            {
                if (e.planeta == "Tierra")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "25s(eje x) X 260m(eje y) (rangos > 0)";

                    double t = 0;
                    double angRads = e.angulo * 0.0174533;
                    while ((altura / 2) + 0.9*(e.altura + ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_TIERRA * (t * t)) / 2) ) > (altura / 2) - 1)
                    {

                        //x,y                   zero                    zero
                        Point point = new Point((anchura / 2) + t * 10, (altura / 2) +0.9*(e.altura + ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_TIERRA * (t * t)) / 2))); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
                else if (e.planeta == "Luna")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "50s(eje x) x 500m(eje y) (rangos > 0)";

                    double t = 0;
                    double angRads = e.angulo * 0.0174533;
                    while ((altura / 2) +0.5*(e.altura + ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_LUNA * (t * t)) / 2) )> (altura / 2) - 1)
                    {

                        //x,y                   zero                   zero
                        Point point = new Point((anchura / 2) + t * 5, (altura / 2) + 0.5*(e.altura + ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_LUNA * (t * t)) / 2))); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
                else if (e.planeta == "Marte")
                {
                    Polyline pl = new Polyline();
                    PointCollection pc = new PointCollection();
                    pl.Stroke = Brushes.Black;
                    MainWindow.miLabel.Content = "50s(eje x) x 500m(eje y) (rangos > 0)";


                    double t = 0;
                    double angRads = e.angulo * 0.0174533;
                    while ((altura / 2) + 0.5 *(e.altura+ ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_MARTE * (t * t)) / 2)) > (altura / 2) - 1)
                    {

                        //x,y                   zero                   zero
                        Point point = new Point((anchura / 2) + t * 5, (altura / 2) + 0.5 *(e.altura+ ((e.velocidad * Math.Sin(angRads) * t) - (GRAV_MARTE * (t * t)) / 2))); //10 (for better visualization)
                        pc.Add(point);
                        t = t + 0.01;
                    }
                    pl.Points = pc;

                    MainWindow.grafica.Children.Add(pl);

                }
            }
            //Adding axis & representation
            MainWindow.grafica.Children.Add(ejex);
            MainWindow.grafica.Children.Add(ejey);




        }
        DispatcherTimer timer;
        static double timme;
        Experimento exp;
        Ellipse el;
        public void representarAnimacion(Experimento e)
        {
            MainWindow.animacion.Children.Clear();
            timer = new DispatcherTimer();
            exp = e;

            el = new Ellipse();
            el.Height = 20;
            el.Width = 20;
            el.Stroke = Brushes.Blue;
            el.StrokeThickness = 1;
            el.Fill = Brushes.Green;

            

            

           if (e.planeta == "Tierra")
           {
                SolidColorBrush earthBrush = new SolidColorBrush(Color.FromRgb(21, 56, 18));
                MainWindow.animacion.Background = earthBrush;  
           }
           else if (e.planeta == "Luna")
           {
                SolidColorBrush moonBrush = new SolidColorBrush(Color.FromRgb(51, 53, 56));
                MainWindow.animacion.Background = moonBrush;
           }
           else if (e.planeta == "Marte")
           {
                SolidColorBrush marsBrush = new SolidColorBrush(Color.FromRgb(56, 24, 21));
                MainWindow.animacion.Background = marsBrush;
           }


            if (e.tipo == "Caída Libre")
            {
                Canvas.SetLeft(el, (MainWindow.animacion.Width) / 2);         //X Coordinate
                Canvas.SetTop(el, e.altura);    //Y Coordinate
                
                timer.Tick += OnTickCLibre;
                
            }
            else if (e.tipo == "Tiro Parabólico")
            {
                Canvas.SetLeft(el, 0);         //X Coordinate
                Canvas.SetTop(el, 0);    //Y Coordinate
                timer.Tick += OnTickTParab;

            }
            else if (e.tipo == "Tiro Parabólico Elevado")
            {
                Canvas.SetLeft(el, 0);         //X Coordinate
                Canvas.SetTop(el, e.altura);    //Y Coordinate                                
                timer.Tick += OnTickTParabElev;
                
            }

            MainWindow.animacion.Children.Add(el);
            timme = 0;
            timer.Interval = new TimeSpan(0, 0, 0, 0, 10);
            timer.Start();

        }
        
        void OnTickCLibre (object sender, EventArgs e)
        {
            if (exp.planeta == "Tierra")
            {
                if ((exp.altura - (GRAV_TIERRA / 2 * (timme * timme)))> 0)
                {
                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (MainWindow.animacion.Width) / 2);
                    Canvas.SetTop(el, exp.altura - (GRAV_TIERRA / 2 * (timme * timme)));
                    timme = timme + 0.010;

                }
                else
                {
                    timer.Stop();
                }
            }
            else if (exp.planeta == "Luna")
            {
                if ((exp.altura - (GRAV_LUNA / 2 * (timme * timme)))> 0)
                {
                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (MainWindow.animacion.Width) / 2);
                    Canvas.SetTop(el, exp.altura - (GRAV_LUNA / 2 * (timme * timme)));
                    timme = timme + 0.010;

                }
                else
                {
                    timer.Stop();
                }
            }
            else if (exp.planeta == "Marte")
            {
                if ((exp.altura - (GRAV_TIERRA / 2 * (timme * timme)))> 0)
                {
                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (MainWindow.animacion.Width) / 2);
                    Canvas.SetTop(el, exp.altura - (GRAV_LUNA / 2 * (timme * timme)));
                    timme = timme + 0.010;

                }
                else
                {
                    timer.Stop();
                }
            }           
            
        }

        void OnTickTParab(object sender, EventArgs e)
        {
            double angRads = exp.angulo * 0.0174533;
            if (exp.planeta == "Tierra")
            {

                if (((exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_TIERRA * (timme * timme) / 2)) > -0.001)
                {

                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (exp.velocidad * Math.Cos(angRads) * timme));
                    Canvas.SetTop(el, ((exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_TIERRA * (timme * timme) / 2)));
                    timme = timme + 0.010;
                }
                else
                {
                    timer.Stop();
                }
            }
            else if (exp.planeta == "Luna")
            {
                if (((exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_LUNA * (timme * timme) / 2)) > -0.001)
                {

                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (exp.velocidad * Math.Cos(angRads) * timme));
                    Canvas.SetTop(el, ((exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_LUNA * (timme * timme) / 2)));
                    timme = timme + 0.010;
                }
                else
                {
                    timer.Stop();
                }

            }
            else if (exp.planeta == "Marte")
            {
                if (((exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_MARTE * (timme * timme) / 2)) > -0.001)
                {

                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (exp.velocidad * Math.Cos(angRads) * timme));
                    Canvas.SetTop(el, ((exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_MARTE * (timme * timme) / 2)));
                    timme = timme + 0.010;
                }
                else
                {
                    timer.Stop();
                }

            }

        }
        void OnTickTParabElev(object sender, EventArgs e)
        {
            double angRads = exp.angulo * 0.0174533;
            if (exp.planeta == "Tierra")
            {

                if ((exp.altura + (exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_TIERRA * (timme * timme) / 2)) > -0.001)
                {

                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (exp.velocidad * Math.Cos(angRads) * timme));
                    Canvas.SetTop(el, (exp.altura + (exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_TIERRA * (timme * timme) / 2)));
                    timme = timme + 0.010;
                }
                else
                {
                    timer.Stop();
                }
            }else if (exp.planeta == "Luna")
            {
                if ((exp.altura + (exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_LUNA * (timme * timme) / 2)) > -0.001)
                {

                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (exp.velocidad * Math.Cos(angRads) * timme));
                    Canvas.SetTop(el, (exp.altura + (exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_LUNA * (timme * timme) / 2)));
                    timme = timme + 0.010;
                }
                else
                {
                    timer.Stop();
                }

            }
            else if (exp.planeta == "Marte")
            {
                if ((exp.altura + (exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_MARTE * (timme * timme) / 2)) > -0.001)
                {

                    //Console.WriteLine(timme);
                    Canvas.SetLeft(el, (exp.velocidad * Math.Cos(angRads) * timme));
                    Canvas.SetTop(el, (exp.altura + (exp.velocidad * Math.Sin(angRads) * timme) - (GRAV_MARTE * (timme * timme) / 2)));
                    timme = timme + 0.010;
                }
                else
                {
                    timer.Stop();
                }

            }
        }


    }

}
