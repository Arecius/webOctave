#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
size_constant = str2num(arg_list{4});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
gim = imread( filename );
printf("Processing image...\n");

% Get grayscale image

if size(gim,3)==3
    gim=rgb2gray(gim);
end

% In double format
dim=im2double(gim);

% Generate the mask
h = fspecial( 'average',size_constant)

imp = imfilter(dim,h);

printf("Result wrote to: ");
printf( outputFile );
imwrite( imp, outputFile );