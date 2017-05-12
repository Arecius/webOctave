#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
bw = imread( filename );
printf("Processing image...\n");
bw2 = imcomplement(bw);
printf("Result wrote to: ");
printf( outputFile )
imwrite( bw2, outputFile );