#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
A   = str2num(arg_list{3});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");

% Get grayscale image
gim=rgb2gray(im);

% In double format
dim=im2double(gim);

kernel = -1 * ones(3);
kernel(2,2) = 8 + A;
printf("Applying filter\n")
L = imfilter( dim, kernel, 'conv')


printf("Result wrote to: ");
printf( outputFile );
imwrite( L, outputFile );

