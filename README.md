# ImageJ_macros
Repository containing macro for image preprocessing

Assemble_ImageSeq_3channels.ijm

This macro has been built to quickly assemble images exported from the incucyte.
It requires specifying the target folder where images are stored and the keywords 
to identify the different channels

Steps:
1. Select target folder
2. Select folder where merged image will be saved
3. Define keyword for Brightfield channel (Phase)
4. Define keyword for Green channel
5. Define keyword for Red channel


Register_img_3channels.ijm 

This macro works in tandem with Assemble_ImageSeq_3channels.ijm, to execute
registration of multichannel (3) images. After launching the macro, you
need to open an image and the macro will start the registration process. 
The user has to define the area used for detecting points and then hit "done".

The macro will apply the same registration to all channels and then save the
new image in the same location
