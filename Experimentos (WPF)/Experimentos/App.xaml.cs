using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading.Tasks;
using System.Windows;

namespace Experimentos  
{

    public partial class App : Application  //MODEL
    {
        
        public static List<Experimento> misExperimentos = new List<Experimento>();
        public static List<String> nombresDeMisExperimentos = new List<string>();

    }

    //:::::::::::::::::EXPERIMENT:::::::::::::::::::::::
    [Serializable()]
    public class Experimento
    {

        //--------------------------------------------//
        //        PROPERTIES DECLARATION ZONE         //
        //--------------------------------------------//

        public string nombre { get; set; }       
        public string tipo { get; set; }   //Caída Libre || Tiro Parabólico || Tiro Parabólico Elevado
        public string planeta { get; set; }    //Tierra || Luna || Marte
        public float masa { get; set; }
        public float altura { get; set; }
        public float angulo { get; set; }
        public float velocidad { get; set; }
        

    }

}
