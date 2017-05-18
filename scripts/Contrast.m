#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
low = str2num(arg_list{5});
high = str2num(arg_list{6});
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

contrast = imadjust(dim,[low high],[]);

%contrast=1./(1+(m_constant./(dim+eps)).^e_constant);

printf("Result wrote to: ");
printf( outputFile );
imwrite( contrast, outputFile );