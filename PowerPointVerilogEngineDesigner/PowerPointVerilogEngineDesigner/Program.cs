using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PowerPointVerilogEngineDesigner
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {

            WebClient client = new WebClient();
            string version = client.DownloadString("https://pastebin.com/raw/qhXP0B8c");
            string myVersion = Assembly.GetEntryAssembly().GetName().Version.ToString();
            if (version!=myVersion)
            {
                Interaction.MsgBox("There is a new version available. Please update to that one.\nWe are not Microsoft, but we might erase all your data when updating.\nWe are not apple, but it will(iam) force you to update (Kind of)",MsgBoxStyle.Critical,"You shall not pass!!!!");
                if(Interaction.MsgBox("After having a look at that very serious error message, are you convinced you want to update?",MsgBoxStyle.YesNo,"Update?")==MsgBoxResult.Yes)
                {
                    Process.Start("https://github.com/alecamaracm/ECE287Project");
                    return;
                }else
                {
                    Interaction.MsgBox("It's fine, it's fine. We will let you pass... (maybe)", MsgBoxStyle.Information, "You DO shall pass!!!!");
                }
            }

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1(version != myVersion));
        }
    }
}
