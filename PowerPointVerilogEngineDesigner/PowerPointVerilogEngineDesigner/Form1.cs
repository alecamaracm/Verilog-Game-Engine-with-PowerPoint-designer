using GemBox.Presentation;
using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PowerPointVerilogEngineDesigner
{
    public partial class Form1 : Form
    {
        PresentationDocument mainDocument;
        List<PresentationDocument> referenceDocuments = new List<PresentationDocument>();

        string currentProjectFilePath = "";
        string currentProjectFolderPath = "";



        public Form1()
        {
            ComponentInfo.SetLicense("FREE-LIMITED-KEY");
           
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            mainDocument = PresentationDocument.Load(currentProjectFolderPath + "\\PPVerilogEngine\\main.pptx");
            foreach(var slide in mainDocument.Slides)
            {
                foreach(Shape shape in slide.Content.Drawings)
                {
                    Console.WriteLine(shape.Name);
                }
            }
        }

        private void fileToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void saveProjectToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if(currentProjectFilePath=="")
            {
                if(saveFileDialog1.ShowDialog()==DialogResult.OK)
                {
                    currentProjectFilePath = saveFileDialog1.FileName;
                    currentProjectFolderPath = new FileInfo(currentProjectFilePath).Directory.FullName;
                }
            }

            if(currentProjectFilePath!="")
            {
                using (StreamWriter writer = new StreamWriter(currentProjectFilePath))
                {
                    if (textBoxProjectName.Text == "") textBoxProjectName.Text = Interaction.InputBox("Project name:", "Project name",new FileInfo(currentProjectFilePath).Directory.Name);
                    writer.WriteLine(textBoxProjectName.Text);
                }
            }
        }

        private void openProjectToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                currentProjectFilePath = openFileDialog1.FileName;
                currentProjectFolderPath = new FileInfo(currentProjectFilePath).Directory.FullName;
                using (StreamReader reader = new StreamReader(currentProjectFilePath))
                {
                    textBoxProjectName.Text = reader.ReadLine();
                }
            }        
        }
    }
}
