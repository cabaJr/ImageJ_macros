// define target folder
inputfold = getDirectory("Input directory where images are stored");
// define output folder
outputfold = getDirectory("_Input directory where images are saved");
// define keyword for brightfield
K1=getString("Write filter for Brightfield images", "BF");
filterK1 = "filter=" + K1
// define keyword for GFP
K2=getString("_Write filter for Brightfield images", "GFP");
filterK2 = "filter=" + K2
// define keyword for RFP
K3=getString("_Write filter for Brightfield images", "RFP");
filterK3 = "filter=" + K3

// assemble BF
File.openSequence(inputfold, filterK1);
run("16-bit");
rename("BF");
// assemble GFP
File.openSequence(inputfold, filterK2);
rename("GFP");
// assemble RFP
File.openSequence(inputfold, filterK3);
rename("RFP");

//merge image
run("Merge Channels...", "c1=RFP c2=GFP c4=BF create");

// get name for image
name = getString("Type name image name", "merged");
savingpath = inputfold + name +".tiff"

//save image
saveAs("Tiff", savingpath);
// close image
close();
