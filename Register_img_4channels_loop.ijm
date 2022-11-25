// open new image
//open();
//folder = File.directory;

//select directory of images to open
input = getDirectory("Input directory where images are stored");

//select location where images/results are to be stored
output = getDirectory("Output directory for TIFFs");


//gets list of files
list = getFileList(input);

//loop for opening images
for (image=0;image<list.length;image++){
	print(image); 
full = input +  list[image];
print(full);
//open image
open(full);
//got original title
originalTitle = getTitle();
// rename image to avoid blanks
rename("image");
// get image title
ImgTitle = getTitle();
// create titles for splitted channels
RFP = ImgTitle+"_#4";
GFP = ImgTitle+"_#3";
GREY = ImgTitle+"_#2";
BIOL = ImgTitle+"_#1";

// deinterleave image with value = 4
run("Deinterleave", "how=4");
//select and rename all images to remove blank space introduced by deinterleave
selectWindow("image #1");
rename(BIOL);
selectWindow("image #2");
rename(GFP);
selectWindow("image #3");
rename(GREY);
selectWindow("image #4");
rename(RFP);
//exit
//remove outliers from Biolum channel
selectWindow(BIOL);
run("Remove Outliers...", "radius=2 threshold=25 which=Bright stack");
// select rfp channel window
selectWindow(RFP);
// create option for registration using RFP channel
OptRegistr = "series_of_images="+ RFP +" brightness_of=Medium approximate_size=[6 px] type_of_detections=[Maxima only] subpixel_localization=[3-dimensional quadratic fit] transformation_model=[Rigid (2d)] number_of_neighbors=3 redundancy=1 significance=3 allowed_error_for_ransac=5 global_optimization=[All-to-all matching with range ('reasonable' global optimization)] range=5 choose_registration_channel=1 image=[Fuse and display] interpolation=[Linear Interpolation]";
// launch image registration
run("Descriptor-based series registration (2d/3d + t)", OptRegistr);
rename("registered_RFP");

//reapply to other images
//GFP
OptRegistrGFP = "series_of_images=" + GFP + " reapply image=[Fuse and display] interpolation=[Linear Interpolation]";
selectWindow(GFP);
run("Descriptor-based series registration (2d/3d + t)", OptRegistrGFP);
rename("registered_GFP");
//GREY
OptRegistrGREY = "series_of_images=" + GREY + " reapply image=[Fuse and display] interpolation=[Linear Interpolation]";
selectWindow(GREY);
run("Descriptor-based series registration (2d/3d + t)", OptRegistrGREY);
rename("registered_GREY");
//BIOL
OptRegistrBIOL = "series_of_images=" + BIOL + " reapply image=[Fuse and display] interpolation=[Linear Interpolation]";
selectWindow(BIOL);
run("Descriptor-based series registration (2d/3d + t)", OptRegistrBIOL);
rename("registered_BIOL");
//merge channels
run("Merge Channels...", "c1=registered_RFP c2=registered_GFP c4=registered_GREY c6=registered_BIOL create");
newTitle = "registered_" + originalTitle;
rename(newTitle);
// channel 1 Red
Stack.setChannel(1)
run("Red");
// channel 2 green
Stack.setChannel(2)
run("Green");
// channel 3 grey
Stack.setChannel(3)
run("Grays");
// channel 4 magenta
Stack.setChannel(4)
run("Magenta");
//close original images
RegBF = "[XYCTZ] "+GREY;
selectWindow(RegBF);
close();
RegRFP = "[XYCTZ] "+RFP;
selectWindow(RegRFP);
close();
RegGFP = "[XYCTZ] "+GFP;
selectWindow(RegGFP);
close();
RegBIOL = "[XYCTZ] "+BIOL;
selectWindow(RegBIOL);
close();

//save generated image
selectWindow(newTitle);
registeredImg = output + newTitle;
saveAs("Tiff", registeredImg);
close();

} // close the loop of the opening of the images 
