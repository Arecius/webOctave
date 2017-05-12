#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
log_constant = arg_list{3};
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");
% Log transformation
% Iterate over the image
%im( i, j ) -> pixel
for i=1:size(im,1)
    for j=1:size(im,2)
        in = double( im(i,j) + 1);
        imp(i,j) = log_constant.*log10( in );
    end
end
printf("Result wrote to: ");
printf( outputFile )
imwrite( imp, outputFile );