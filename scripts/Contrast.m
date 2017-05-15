#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
e_constant = str2num(arg_list{3});
m_constant = str2num(arg_list{4});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");

% Get grayscale image
gim=rgb2gray(im);

% In double format
dim=im2double(gim);

contrast=1./(1+(m_constant./(dim+eps)).^e_constant);

printf("Result wrote to: ");
printf( outputFile );
imwrite( contrast, outputFile );