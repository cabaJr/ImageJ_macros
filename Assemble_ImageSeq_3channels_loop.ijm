// define target folder
inputfold = getDirectory("Input directory where images are stored");
// define output folder
outputfold = getDirectory("_Input directory where images are saved");
// define keyword for brightfield
K1=getString("Write filter for Brightfield images", "BF");
filterK1 = "filter=" + K1;
// define keyword for GFP
K2=getString("_Write filter for Brightfield images", "GFP");
filterK2 = "filter=" + K2;
// define keyword for RFP
K3=getString("_Write filter for Brightfield images", "RFP");
filterK3 = "filter=" + K3;

// ask user how many wells to assemble
wellsNumber = getNumber("How many wells do you have?", 6);
// create empty array to contain wells names
wells = newArray();
//for cycle to fill wells names into an array
for (i = 0; i < wellsNumber; i++) {
	//get wells names
	wellsInput = getString("List the wells that you want to assemble", "A1");
	//assign wellnames to new array
	wells = Array.concat(wells,wellsInput);
}

// start loop
for (image=0;image<wellsNumber;image++){
	//create filter BF
	currentWell = wells[image];
	//currentWell = Array.slice(wells,image,image+1);
	print(currentWell);
	//exit;
	filterK1_well = filterK1 + "_" + currentWell;
	filterK2_well = filterK2 + "_" + currentWell;
	filterK3_well = filterK3 + "_" + currentWell;

	// assemble BF
	File.openSequence(inputfold, filterK1_well);
	run("16-bit");
	rename("BF");
	// assemble GFP
	File.openSequence(inputfold, filterK2_well);
	rename("GFP");
	// assemble RFP
	File.openSequence(inputfold, filterK3_well);
	rename("RFP");
	
	//merge image
	run("Merge Channels...", "c1=RFP c2=GFP c4=BF create");
	
	// get name for image
	//name = getString("Type image name", "merged");
	savingpath = outputfold + currentWell + "_merged" +".tiff";
	
	//save image
	saveAs("Tiff", savingpath);
	// close image
	close();
}
print("The macro has finished assemblying your files!");
