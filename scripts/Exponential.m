#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
gamma = str2num(arg_list{4});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
gim = imread( filename );
printf("Processing image...\n");

% Get grayscale image
if size(gim,3)==3
    gim=rgb2gray(im);
end

% In double format
gim=im2double(gim);

% Exponantial transformation
imp = 255 * (gim/255).^ gamma;

printf("Result wrote to: ");
printf( outputFile );
imwrite( imp, outputFile );