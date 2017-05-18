#! octave -qf
printf("Initializing script...BW3\n");
printf("Fetching arguments\n");

arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
asset = arg_list{3};
grade   = str2num(arg_list{4});
cutoff   = str2num(arg_list{5});
printf("Loading image package...\n");
pkg load image;
printf ("Reading image..\n");
gim = imread( filename );
printf("Processing image...\n");

if size(gim,3)==3
    gim=rgb2gray(gim);
end

h= size(gim,1);
w= size(gim,2);

[x,y]=meshgrid( -floor(w/2):floor(w-1)/2, -floor(h/2):floor(h-1)/2 );
hbf=1./(1.+(cutoff./(x.^2+y.^2).^0.5).^(2*grade));

printf("Applying filter\n");

af=fftshift(fft2(gim));

%fftshow
fl=log(1+abs(af));
fm=max(fl(:));
fftshow_img=im2uint8(fl/fm);

%filter
afl=af.*hbf;
fl=log(1+abs(afl));
fm=max(fl(:));
asset_result=im2uint8(fl/fm);

afli=ifft2(afl);

%ifftshow
ifl=abs(afli);
ifm=max(ifl(:));
final= gim - im2uint8(ifl/ifm);

printf("Grade: %d\n",grade);
printf("Cutoff: %d\n",cutoff);

printf("Result wrote to: ");
printf( outputFile)
imwrite( final, outputFile);
printf( "\nAsset wrote to: " );
printf( asset );
printf("\n")
imwrite( asset_result, asset);