#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
A   = str2num(arg_list{4});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
gim = imread( filename );
printf("Processing image...\n");

if size(gim,3)==3
    gim=rgb2gray(gim);
end

% In double format
dim=im2double(gim);

kernel = -1 * ones(3);
kernel(2,2) = 8 + A;
printf("Applying filter\n")
L = imfilter( dim, kernel, 'conv')


printf("Result wrote to: ");
printf( outputFile );
imwrite( L, outputFile );

