using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PowerPointVerilogEngineDesigner
{
 

    public partial class SerialPortCom : Form
    {
        SerialPort port;
        Random random = new Random();
        public SerialPortCom()
        {
            InitializeComponent();
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if(e.KeyChar=='\r')button1.PerformClick();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            port.Write(textBox1.Text);
        }

        private void SerialPortCom_Load(object sender, EventArgs e)
        {
            port = new SerialPort("COM5", 500000, Parity.None);
            port.Open();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            for(long i=0;i<numericUpDown1.Value;i++)
            {
                port.Write(new byte[2] { (byte)random.Next() , (byte)random.Next() },0,2);
                Thread.Sleep(100);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            sendPicture(new Bitmap(textBox3.Text));
        }

        private void sendPicture(Bitmap bitmap)
        {
            long count = 0;
            byte[] array = new byte[bitmap.Height * bitmap.Width * 2*6+1];
            for(int j=0;j<bitmap.Height;j++)
            {
                for (int i = 0; i < bitmap.Width; i++)
                {
                    ulong hugeColor = 0;
                    Color color = bitmap.GetPixel(i, j);
                   // color = Color.FromArgb(128, 32, 64);
                    ulong rColor = (byte)(color.R / 8);
                    hugeColor=hugeColor + (rColor << 11);
                    ulong gColor = (byte)(color.G / 8);
                    hugeColor = hugeColor + (gColor << 6);
                    ulong bColor = (byte)(color.B / 8);
                    hugeColor = hugeColor + (bColor << 1);

                    byte finalB1 = (byte)(((hugeColor >> 8) & 0xFF));
                    byte finalB2 = (byte)(hugeColor & 0xFF);

                    // byte finalB1 = (byte)((hugeColor >> 24) & 0xFF);
                    // byte finalB2 = (byte)((hugeColor >> 16) & 0xFF);

                    array[count] = finalB1;
                    array[count + 1] = finalB2;
                    array[count + 2] = finalB1;
                    array[count + 3] = finalB2;
                    array[count + 4] = finalB1;
                    array[count + 5] = finalB2;

                    count += 6;
                   
                    //Console.WriteLine(finalB1 + "bbbb" + finalB2);

                }
            }

            port.Write(array, 0, array.Length);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Bitmap bitmap = new Bitmap(textBox3.Text);
            long count = 0;
            ulong[] array = new ulong[bitmap.Height * bitmap.Width];
            for (int j = 0; j < bitmap.Height; j++)
            {
                for (int i = 0; i < bitmap.Width; i++)
                {
                    ulong hugeColor = 0;
                    Color color = bitmap.GetPixel(i, j);
                    // color = Color.FromArgb(128, 32, 64);
                    ulong rColor = (byte)(color.R / 8);
                    hugeColor = hugeColor + (rColor << 10);
                    ulong gColor = (byte)(color.G / 8);
                    hugeColor = hugeColor + (gColor << 5);
                    ulong bColor = (byte)(color.B / 8);
                    hugeColor = hugeColor + (bColor << 0);

                    array[count] = hugeColor;

                    count += 1;


                }
            }

            using (StreamWriter writer = new StreamWriter(textBox4.Text))
            {
                writer.WriteLine("DEPTH = " + array.Length+";");
                writer.WriteLine("WIDTH = 15;");
                writer.WriteLine("ADDRESS_RADIX = DEC;");
                writer.WriteLine("DATA_RADIX = DEC;");
                writer.WriteLine("CONTENT");
                writer.WriteLine("BEGIN ");

                for(int i=0;i<array.Length;i++)
                {
                    writer.WriteLine(i + ":" + array[i] + ";");
                }

                writer.WriteLine("END;");

            }
              
        }
    }
}
