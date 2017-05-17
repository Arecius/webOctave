#! octave -qf
echo off;
printf("Initializing script...\n");
printf("Fetching arguments\n");

arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
sigma   = str2num(arg_list{3});

printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
a = imread( filename );
printf("Processing image...\n");

H=fspecial('gaussian',size(a),sigma);
af=fftshift(fft2(a));
aff=af.*H;

affi=ifft2(aff);

%ifftshow
ifl=abs(affi);
ifm=max(ifl(:));
result= a - im2uint8(ifl/ifm);


printf("Applying filter\n");

imwrite( result, outputFile);
printf("Sigma: %d\n",sigma);
