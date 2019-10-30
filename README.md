# ECE287Project

A fully-featured game engine that takes a game designed in PowerPoint (Yes, really!) and creates a Verilog design ready to be uploaded to an FPGA.
The project is no longer maintained, but it should work as it is right now.

The engine has support for:
  - Multiple scenes and transitions between them.
  - Nearly an unlimited number of "objects" in the scene.
  - Animations, collision detection and gravity.
  - Picture compression to minimize the memory usage
  - Support for both Block-RAM and raw register picture storage.
  - Transparency support (Unlimited layers) (Some bugs are still present in the rasterizer)
  - Mouse and keyboard support (PS2 only)
  - Support for multiple user scripts
  - Most of the internal variables can be exposed in a safe way.
  - Sprite support (Max 255 sprites per picture)

Tested with MAX10 and Cyclone V FPGAs


![](https://i.imgur.com/4VcOSxyr.png)

![](https://github.com/alecamaracm/ECE287Project/blob/master/Capture2.PNG?raw=true)


## **Useful Tags for the PowerPoint compiler:**
Supported Tags  and their 	Operations

[NAME=______];   	Gives the object a name. This is need on all objects and pictures.

[MOVEABLE];	        Tells the compiler to make this object movable. If you use this tag and don’t give it a desired 
                        way of movement. Then it will add the nameX and nameY to the header of the file.
                        
[BORDER];	        Lets the compiler know to bounce it off the giver border or the edges of the screen.

[TRANSPARENT];	        Let the compiler know to use the object or pictures set transparency.

[BOUNCING];	        This tells the compiler to make the object bounce around the screen.

[AnimationSpeed=___];   The speed the object will travel per frame refresh (60 screen refreshes per second)(speed in in 
                        pixels).
                        
[MEMORY];	        Tell the compiler to store the picture into ram.

[COMPRESIONLEVEL=___];	How much you would like to compress the image. 
Default is one.

[CURSOR];	        Tells the compiler to make this object controlled by the mouse. 
[COLORBITS=____];	How many bits you wish to use for each color (RGB). Only use this if the image is not being stored 
                        in memory.
                        
[WASDMovement];         This object will move with the “wasd” keys. Must also have the tag [MOVEABLE];

[ARROWMovement];	This object will move with the  arrow keys. Must also have the tag [MOVEABLE];

[SKIPX]; or [SKIPY];	Tell the compiler you wish to skip part of the picture.

[VISIBLE];	        Tell the compiler you wish to control when this picture is visible.


![](https://i.imgur.com/ncW8t0o.jpg)
