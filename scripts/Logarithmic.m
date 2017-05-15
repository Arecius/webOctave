#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
log_constant = str2num(arg_list{3});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");
% Get grayscale image
gim=rgb2gray(im);

% Log transformation
% Iterate over the image
% im( i, j ) -> pixel

[M,N]=size(gim);
for i=1:M
    for j=1:N
        in = double( gim(i,j) );
        imp(i,j) = log_constant.*log10( 1+in );
    end
end
printf("Result wrote to: ");
printf( outputFile )
imwrite( imp, outputFile );