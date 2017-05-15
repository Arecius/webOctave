#! octave -qf
printf("Initializing script...\n");
printf("Fetching arguments\n");
arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
exp_constant = str2num(arg_list{3});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
im = imread( filename );
printf("Processing image...\n");

% Get grayscale image
gim=rgb2gray(im);

% In double format
gim=im2double(gim);

% Exp transformation
% Iterate over the image
% im( i, j ) -> pixel

% Gamma Correction Array
%g =[0.5 0.7 0.9 1 2 3 4 5 6];
g=0.6;


% computing size m,n 
[M,N]=size(gim);

% Exponantial transformation
for r=1:length(g)
    for p = 1 : M
        for q = 1 : N
            imp(p, q) = exp_constant*gim(p, q).^ g(r);  
        end
    end
end

printf("Result wrote to: ");
printf( outputFile );
imwrite( imp, outputFile );