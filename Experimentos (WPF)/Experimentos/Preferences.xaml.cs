using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
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
using System.Windows.Shapes;
using System.Xml.Serialization;

namespace Experimentos
{
    /// <summary>
    /// Interaction logic for Preferences.xaml
    /// </summary>
    /// 
    public delegate void delegadoRepresentaciones(Experimento e);

    public partial class Preferences : Window   //MODEL VIEW (the .xaml is the VIEW)
    {

        delegadoRepresentaciones delegadoPropio;
        public Preferences()
        {
            InitializeComponent();
            
            //Taking miLista data to fill the table
            miLista.ItemsSource = App.misExperimentos;
            Representaciones representaciones = new Representaciones();
            delegadoPropio = new delegadoRepresentaciones(representaciones.representarGrafica);
            delegadoPropio += new delegadoRepresentaciones(representaciones.representarAnimacion);


        }

        
        //Closing actions
        private void Pref_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            //Console.Write("Closing Preferences \n");
            //Send notification to change OPEN/FOCUS property in MainWindow.xaml.cs
            MainWindow.prefWindow = null;
        }
        private void Pref_Closed(object sender, EventArgs e)
        {
            //Console.Write("Preferences sucesfully closed \n");
            
        }


        //Añadir button have been pushed
        private void Button_Click(object sender, RoutedEventArgs e) 
        {
             clearButton.IsEnabled = true;

            //Obtain Data
            TextBox nombre = entradaNombre;
            
            if(!App.nombresDeMisExperimentos.Contains(nombre.Text))
            {
                Slider masa = entradaMasa;
                Slider altura = entradaAltura;
                Slider angulo = entradaAngulo;
                Slider velocidad = entradaVelocidad;

                RadioButton CaidaLibre = CLibre;
                RadioButton TiroParabolico = TParabólico;
                RadioButton TiroParabolicoElevado = TPElevado;
                String tipoAUsar = "None";
                if (CaidaLibre.IsChecked == true)
                {
                    tipoAUsar = "Caída Libre";
                }
                if (TiroParabolico.IsChecked == true)
                {
                    tipoAUsar = "Tiro Parabólico";
                }
                if (TiroParabolicoElevado.IsChecked == true)
                {
                    tipoAUsar = "Tiro Parabólico Elevado";
                }

                RadioButton tierra = Tierra;
                RadioButton luna = Luna;
                RadioButton marte = Marte;
                String planetaAUSar = "None";

                if (tierra.IsChecked == true)
                {
                    planetaAUSar = "Tierra";
                }
                if (luna.IsChecked == true)
                {
                    planetaAUSar = "Luna";
                }
                if (marte.IsChecked == true)
                {
                    planetaAUSar = "Marte";
                }



                //Add element
                App.misExperimentos.Add(new Experimento() { nombre = nombre.Text, masa = (float)masa.Value, planeta = planetaAUSar, tipo = tipoAUsar, altura = (float)altura.Value, angulo = (float)angulo.Value, velocidad = (float)velocidad.Value });
                App.nombresDeMisExperimentos.Add(nombre.Text);
                //Update view
                miLista.Items.Refresh();    //Refreshes the elements in miLista
                RibbonTabControl.SelectedIndex = 0; //First tab gains focus

            }
            else
            {
                MessageBoxResult result = MessageBox.Show("Ya existe un experimento con ese nombre, pruebe con otro", "Información", MessageBoxButton.OK, MessageBoxImage.Information);
            }

           
        }


        //Methods to activate/deactivate options depending on the type of experiment selected

        private void CLibre_Checked(object sender, RoutedEventArgs e)
        {
            //Disable "angulo" and "velocidad"
            if (entradaAltura != null)
            {
                entradaAltura.IsEnabled = true;
                entradaVelocidad.BorderBrush = Brushes.LightGreen;  //Not Working in W10
            }
            if(entradaAngulo != null)
            {
                entradaAngulo.IsEnabled = false;
                entradaVelocidad.BorderBrush = Brushes.Tomato;
            }
            if(entradaVelocidad != null)
            {
                entradaVelocidad.IsEnabled = false;
                entradaVelocidad.BorderBrush = Brushes.Tomato;
            }
            

        }

        private void TParabólico_Checked(object sender, RoutedEventArgs e)
        {
            //Disable "altura"
            if (entradaAltura != null)
            {
                entradaAltura.IsEnabled = false;
                entradaVelocidad.BorderBrush = Brushes.Tomato;
            }
            if (entradaAngulo != null)
            {
                entradaAngulo.IsEnabled = true;
                entradaVelocidad.BorderBrush = Brushes.LightGreen;
            }
            if (entradaVelocidad != null)
            {
                entradaVelocidad.IsEnabled = true;
                entradaVelocidad.BorderBrush = Brushes.LightGreen;
            }

        }

        private void TPElevado_Checked(object sender, RoutedEventArgs e)
        {
            if (entradaAltura != null)
            {
                entradaAltura.IsEnabled = true;
                entradaVelocidad.BorderBrush = Brushes.LightGreen;
            }
            if (entradaAngulo != null)
            {
                entradaAngulo.IsEnabled = true;
                entradaVelocidad.BorderBrush = Brushes.LightGreen;
            }
            if (entradaVelocidad != null)
            {
                entradaVelocidad.IsEnabled = true;
                entradaVelocidad.BorderBrush = Brushes.LightGreen;
            }

        }

        //Selection Changed
        private void miLista_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            rmButton.IsEnabled = true;
            viewButton.IsEnabled = true;
            clearButton.IsEnabled = true;
        }

        //Need to show the selected experiment
        private void Button_View(object sender, RoutedEventArgs e)
        {
            ListView lista = miLista;
            int elementoseleccionado = lista.SelectedIndex;

            if (App.misExperimentos.ElementAt(elementoseleccionado) != null)
            {
                Experimento experimentoAMostrar = App.misExperimentos.ElementAt(elementoseleccionado);
                delegadoPropio(experimentoAMostrar);
            }

        }

        //Remove selected item from list
        private void Button_Remove(object sender, RoutedEventArgs e)
        {
            ListView lista = miLista;
            int elementoseleccionado = lista.SelectedIndex;

            lista.SelectedItems.Clear();
            App.misExperimentos.RemoveAt(elementoseleccionado);
            App.nombresDeMisExperimentos.RemoveAt(elementoseleccionado);

            miLista.Items.Refresh();    //Refreshes the elements in miLista
            if(miLista.Items.Count == 0)
            {
                rmButton.IsEnabled = false;
                viewButton.IsEnabled = false;
                clearButton.IsEnabled = false;
                RibbonTabControl.SelectedIndex = 1; //First tab gains focus
            }

        }

        //Remove all elements
        private void Button_Clear(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Esto eliminará todos sus experimentos, ¿desea continuar?", "Atención", MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (result == MessageBoxResult.Yes)
            {
                rmButton.IsEnabled = false;
                viewButton.IsEnabled = false;
                clearButton.IsEnabled = false;

                ListView lista = miLista;
                int elementoseleccionado = lista.SelectedIndex;

                if (lista.SelectedIndex > 1)
                {
                    lista.SelectedIndex = lista.SelectedIndex - 1;
                }

                App.misExperimentos.Clear();
                App.nombresDeMisExperimentos.Clear();
                miLista.Items.Refresh();    //Refreshes the elements in miLista
                RibbonTabControl.SelectedIndex = 1; //Creation tab gains focus
                
                //Sometimes buttons failed to change it's status, so...
                rmButton.IsEnabled = false;
                viewButton.IsEnabled = false;
                clearButton.IsEnabled = false;
            }
            
        }

        private void entradaNombre_TextChanged(object sender, TextChangedEventArgs e)
        {
            if(entradaNombre.Text.Length != 0)
            {
                add_Button.IsEnabled = true;
            }else
            {
                add_Button.IsEnabled = false;
            }
            
        }

        //Open data file
        private void AbrirArchivo_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            openFileDialog.Filter = "XML files (*.xml)|*.xml";
            openFileDialog.ShowDialog();

            string pathOfOpenedFile = openFileDialog.FileName;
            string security = pathOfOpenedFile.Substring(pathOfOpenedFile.Length - 3);  //Security should be improved
            if(security == "xml")
            {
                Console.WriteLine(pathOfOpenedFile);

                App.misExperimentos.Clear();
                App.nombresDeMisExperimentos.Clear();

                List<Experimento> cargarExperimentos = new List<Experimento>();
                cargarExperimentos = XmlSerialization.ReadFromXmlFile<List<Experimento>>(pathOfOpenedFile);
                for (int i = 0; i < cargarExperimentos.Count; i++)
                {
                    App.misExperimentos.Add(cargarExperimentos.ElementAt(i));
                    App.nombresDeMisExperimentos.Add(cargarExperimentos.ElementAt(i).nombre);

                }
                ListView lista = miLista;
                miLista.Items.Refresh();    //Refreshes the elements in miLista
                RibbonTabControl.SelectedIndex = 0; //First tab gains focus
            }else
            {
                MessageBoxResult result = MessageBox.Show("No se ha seleccionado un archivo .xml", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            

        }

        //Save data file
        private void GuardarArchivo_Click(object sender, RoutedEventArgs e)
        {
            List<Experimento> guardarExperimentos = new List<Experimento>();
            guardarExperimentos = App.misExperimentos;
            string pathToDesktop = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            string userName = Environment.UserName;
            Random rnd = new Random();
            int randomNUM = rnd.Next(1, 50);

            string path = pathToDesktop + "\\" + userName + randomNUM.ToString() +".xml";
                        
            Console.WriteLine(path);
            if(guardarExperimentos.Count != 0)
            {
                XmlSerialization.WriteToXmlFile<List<Experimento>>(path, guardarExperimentos);
                MessageBoxResult result = MessageBox.Show("Datos guardados en " + path, "Información", MessageBoxButton.OK, MessageBoxImage.Information);
            }else
            {
                MessageBoxResult result = MessageBox.Show("No hay datos que guardar ", "Información", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            
        }
    }

    //For the XML Serialization I've used this class that I found in: http://blog.danskingdom.com/saving-and-loading-a-c-objects-data-to-an-xml-json-or-binary-file/

    /// <summary>
    /// Functions for performing common XML Serialization operations.
    /// <para>Only public properties and variables will be serialized.</para>
    /// <para>Use the [XmlIgnore] attribute to prevent a property/variable from being serialized.</para>
    /// <para>Object to be serialized must have a parameterless constructor.</para>
    /// </summary>
    public static class XmlSerialization
    {
        /// <summary>
        /// Writes the given object instance to an XML file.
        /// <para>Only Public properties and variables will be written to the file. These can be any type though, even other classes.</para>
        /// <para>If there are public properties/variables that you do not want written to the file, decorate them with the [XmlIgnore] attribute.</para>
        /// <para>Object type must have a parameterless constructor.</para>
        /// </summary>
        /// <typeparam name="T">The type of object being written to the file.</typeparam>
        /// <param name="filePath">The file path to write the object instance to.</param>
        /// <param name="objectToWrite">The object instance to write to the file.</param>
        /// <param name="append">If false the file will be overwritten if it already exists. If true the contents will be appended to the file.</param>
        public static void WriteToXmlFile<T>(string filePath, T objectToWrite, bool append = false) where T : new()
        {
            TextWriter writer = null;
            try
            {
                var serializer = new XmlSerializer(typeof(T));
                writer = new StreamWriter(filePath, append);
                serializer.Serialize(writer, objectToWrite);
            }
            finally
            {
                if (writer != null)
                    writer.Close();
            }
        }

        /// <summary>
        /// Reads an object instance from an XML file.
        /// <para>Object type must have a parameterless constructor.</para>
        /// </summary>
        /// <typeparam name="T">The type of object to read from the file.</typeparam>
        /// <param name="filePath">The file path to read the object instance from.</param>
        /// <returns>Returns a new instance of the object read from the XML file.</returns>
        public static T ReadFromXmlFile<T>(string filePath) where T : new()
        {
            TextReader reader = null;
            try
            {
                var serializer = new XmlSerializer(typeof(T));
                reader = new StreamReader(filePath);
                return (T)serializer.Deserialize(reader);
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }
        }

    }




}