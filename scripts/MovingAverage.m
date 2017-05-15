#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
size_constant = str2num(arg_list{3});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");

% Get grayscale image
gim=rgb2gray(im);

% In double format
dim=im2double(gim);

% Generate the mask
mask = ones(size_constant,size_constant)/(size_constant*size_constant);

imp = imfilter(im,mask);

printf("Result wrote to: ");
printf( outputFile );
imwrite( imp, outputFile );