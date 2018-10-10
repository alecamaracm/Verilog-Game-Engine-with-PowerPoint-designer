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

            using (StreamWriter writer = new StreamWriter(currentProjectFolderPath + "\\IH8Verilog_main.v"))
            {
                writer.WriteLine("module PP2VerilogDrawingController(xPixel,yPixel,VGAr,VGAg,VGAb);"+Environment.NewLine);

                writer.WriteLine("input [9:0]xPixel;"+Environment.NewLine+"input[8:0]yPixel;");
                writer.WriteLine("output [7:0]VGAr;");
                writer.WriteLine("output [7:0]VGAg;");
                writer.WriteLine("output [7:0]VGAb;");
                writer.WriteLine("reg [7:0]VGAr;");
                writer.WriteLine("reg [7:0]VGAg;");
                writer.WriteLine("reg [7:0]VGAb;");
                writer.WriteLine();

                writer.WriteLine("always @(*)");
                writer.WriteLine("begin");

                writer.WriteLine("\tVGAr=" + formatNumber("b",8,"00000000")+";");
                writer.WriteLine("\tVGAg=" + formatNumber("b",8,"00000000")+"; ");
                writer.WriteLine("\tVGAb=" + formatNumber("b", 8,"00000000") + "; ");

                drawBasicShapes(writer,mainDocument.Slides[0]);

                writer.WriteLine("end");

              //  writer.WriteLine("assign VGAr = ((xPixel < 3) || (xPixel > 636) || (yPixel < 3) || (yPixel > 476)) ? 230 : 191;");
             //   writer.WriteLine("assign VGAg = ((xPixel < 3) || (xPixel > 636) || (yPixel < 3) || (yPixel > 476)) ? 46 : 128;");
             //   writer.WriteLine("assign VGAb = ((xPixel < 3) || (xPixel > 636) || (yPixel < 3) || (yPixel > 476)) ? 0 : 64;");    

                writer.WriteLine(Environment.NewLine+"endmodule");
           
            }
        }

        private void drawBasicShapes(StreamWriter writer, Slide slide)
        {
            foreach(Shape shape in slide.Content.Drawings)
            {
                if(shape.Format.Fill.FillType==FillFormatType.Solid)
                {
                    if(shape.ShapeType==ShapeGeometryType.Rectangle)
                    {
                        SolidFillFormat f = (SolidFillFormat)shape.Format.Fill;                        
                        writer.WriteLine("\t//Drawing Solid shape " + shape.Name);
                        writeColor(writer, f.Color,getScaledLayout(shape.Layout));
                    }
                    
                }
            }
        }

        DrawingLayout getScaledLayout(DrawingLayout layout)
        {
            layout.Left = ((layout.Left / 72.0) / 13.333333) * 640;
            layout.Width = ((layout.Width / 72.0) / 13.333333) * 640;
            layout.Top = ((layout.Top / 72.0) / 7.5) * 480;
            layout.Height = ((layout.Height / 72.0) / 7.5) * 480;
            return layout;


        }

        void writeConditionalSquare(StreamWriter writer)
        {
            
        }

        void writeColor(StreamWriter writer, GemBox.Presentation.Color color,DrawingLayout scaledLayout)
        {
            writer.WriteLine("\tif(xPixel>"+(int)scaledLayout.Left.To(LengthUnit.Point)+" && xPixel<"+((int)scaledLayout.Left.To(LengthUnit.Point) + (int)scaledLayout.Width.To(LengthUnit.Point)) + 
                " && yPixel>"+(int)scaledLayout.Top.To(LengthUnit.Point) + " && yPixel<"+((int)scaledLayout.Top.To(LengthUnit.Point) + (int)scaledLayout.Height.To(LengthUnit.Point)) + ") VGAr="
                + formatNumber("b", 8, Convert.ToString(color.R, 2).PadLeft(8, '0')) + ";");

            writer.WriteLine("\tif(xPixel>" + (int)scaledLayout.Left.To(LengthUnit.Point) + " && xPixel<" + ((int)scaledLayout.Left.To(LengthUnit.Point) + (int)scaledLayout.Width.To(LengthUnit.Point)) + 
                " && yPixel>" + (int)scaledLayout.Top.To(LengthUnit.Point) + " && yPixel<" + ((int)scaledLayout.Top.To(LengthUnit.Point) + (int)scaledLayout.Height.To(LengthUnit.Point)) + ") VGAg=" 
                + formatNumber("b", 8, Convert.ToString(color.G, 2).PadLeft(8, '0')) + "; ");

            writer.WriteLine("\tif(xPixel>" + (int)scaledLayout.Left.To(LengthUnit.Point) + " && xPixel<" + ((int)scaledLayout.Left.To(LengthUnit.Point) + (int)scaledLayout.Width.To(LengthUnit.Point)) + 
                " && yPixel>" + (int)scaledLayout.Top.To(LengthUnit.Point) + " && yPixel<" + ((int)scaledLayout.Top.To(LengthUnit.Point) + (int)scaledLayout.Height.To(LengthUnit.Point)) + ") VGAb=" 
                + formatNumber("b", 8, Convert.ToString(color.B, 2).PadLeft(8, '0')) + "; ");
        }

        string formatNumber(string type,int length,string value)
        {
            return String.Format("{0}'{1}{2}",length,type,value);
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
