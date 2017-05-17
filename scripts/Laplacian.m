#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
threshold   = str2num(arg_list{3});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");

% Get grayscale image
gim=rgb2gray(im);

%imgradient = edge(gim,'log',)

H = fspecial('laplacian', threshold);
L = imfilter(gim,H,'replicate');


printf("Result wrote to: ");
printf( outputFile );
imwrite( L, outputFile );