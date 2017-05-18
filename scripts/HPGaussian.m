#! octave -qf
echo off;
printf("Initializing script...\n");
printf("Fetching arguments\n");

arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
asset = arg_list{3}; 
sigma   = str2num(arg_list{4});

printf("Loading image package...\n");
pkg load image;
a = imread( filename );
printf("Processing image...\n");

if size(a,3)==3
    a=rgb2gray(a);
end

printf("Applying filter\n");
printf("Sigma: %d\n",sigma);

H=fspecial('gaussian',size(a),sigma);
af=fftshift(fft2(a));
aff=af.*H;

affi=ifft2(aff);
%fftshow
fl=log(1+abs(aff));
fm=max(fl(:));
asset_result= im2uint8(fl/fm);


%ifftshow
ifl=abs(affi);
ifm=max(ifl(:));
result = a - im2uint8(ifl/ifm);

printf("Result wrote to: ");
imwrite( result, outputFile);
printf( "\nAsset wrote to" );
printf( asset );
printf("\n")
imwrite( asset_result, asset);

