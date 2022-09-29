// open new image
open();
folder = File.directory;
// get image title
ImgTitle = getTitle();
// create titles for splitted channels
RED = "C1-"+ImgTitle;
GFP = "C2-"+ImgTitle;
GREY = "C3-"+ImgTitle;
// split into separate channels
run("Split Channels");
// select gfp channel window
selectWindow(GFP);
// create option for registration using GFP channel
OptRegistr = "series_of_images="+ GFP +" brightness_of=[Interactive ...] approximate_size=[Interactive ...] type_of_detections=[Interactive ...] subpixel_localization=[3-dimensional quadratic fit] transformation_model=[Rigid (2d)] number_of_neighbors=3 redundancy=1 significance=3 allowed_error_for_ransac=5 global_optimization=[All-to-all matching with range ('reasonable' global optimization)] range=5 choose_registration_channel=1 image=[Fuse and display] interpolation=[Linear Interpolation]"
// launch image registration
run("Descriptor-based series registration (2d/3d + t)", OptRegistr);
//makeRectangle(0, 0, 1536, 1152);
rename("registered_GFP");

//reapply to other images
//RFP
OptRegistrRED = "series_of_images=" + RED + " reapply image=[Fuse and display] interpolation=[Linear Interpolation]"
selectWindow(RED);
run("Descriptor-based series registration (2d/3d + t)", OptRegistrRED);
rename("registered_RFP");
//GREY
OptRegistrGREY = "series_of_images=" + GREY + " reapply image=[Fuse and display] interpolation=[Linear Interpolation]"
selectWindow(GREY);
run("Descriptor-based series registration (2d/3d + t)", OptRegistrGREY);
rename("registered_GREY");

//merge channels
run("Merge Channels...", "c1=registered_RFP c2=registered_GFP c4=registered_GREY create");
newTitle = "registered_" + ImgTitle
rename(newTitle);

//close original images
RegBF = "[XYCTZ] "+GREY
selectWindow(RegBF);
close();
RegRED = "[XYCTZ] "+RED
selectWindow(RegRED);
close();
RegGFP = "[XYCTZ] "+GFP
selectWindow(RegGFP);
close();

//save generated image
selectWindow(newTitle);
registeredImg = folder + newTitle
saveAs("Tiff", registeredImg);
//close();
