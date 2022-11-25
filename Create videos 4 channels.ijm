//create list of images in input folder
input = getDirectory("Input directory where images are stored");
list = getFileList(input);

//ask where to save videos
output = getDirectory("Output directory for TIFFs");

//loop for opening images
for (image=0;image<list.length;image++){
// if statement to open only tif files
if (endsWith(list[image], ".tif")) {
	
	print(image); 
full = input +  list[image];
print(full);

//open image
open(full);

//save image name
name = getTitle();

// create new names 
RFP = "C1-"+name;
GFP = "C2-"+name;
PHASE = "C3-"+name;
BIOL = "C4-"+name;
selectWindow(name);

//set properties
frames = nSlices/4;
Stack.setXUnit("um");
run("Properties...", "channels=4 slices=1 frames="+frames+" pixel_width=2.03 pixel_height=2.03 voxel_depth=2.03");

// add scale bar
run("Scale Bar...", "width=100 height=589 thickness=4 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");

// deselect any ROI


//split channels
run("Split Channels");

// create names for saving
RFP_out = "compression=JPEG frame=48 save=["+output+name+"_Syn-RCaMP.avi]";
GFP_out = "compression=JPEG frame=48 save=["+output+name+"_Syn-iGABASnfr.avi]";
PHASE_out = "compression=JPEG frame=48 save=["+output+name+"_phase.avi]";
BIOL_out = "compression=JPEG frame=48 save=["+output+name+"_Per2.avi]";

// select each window and save it as avi with 48 frame per second then close
selectWindow(RFP);
run("AVI... ", RFP_out);
close();
selectWindow(GFP);
run("AVI... ", GFP_out);
close();
selectWindow(PHASE);
run("AVI... ", PHASE_out);
close();
selectWindow(BIOL);
run("AVI... ", BIOL_out);
close();
} // close if statement
} // end of for loop