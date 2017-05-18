%%Donde:
%%P(k) = w0
%%Mg = w1
%%M(k)
printf("Initializing script...\n");
printf("Fetching arguments\n");

arg_list = argv ();
filename = arg_list{1};
outputFile = arg_list{2};
asset = arg_list{3};
printf("Loading image package...\n");
pkg load image;

printf ("Reading image..\n");
I = imread( filename );
printf("Processing image...\n");

if size(I,3)==3
    I=rgb2gray(I);
end
%%figure(1),imshow(I); % display the  Original Image
%%figure(2),imhist(I); % display the Histogram
%%=================================================================================================
n=imhist(I); % Compute the histogram
N=sum(n); % sum the values of all the histogram values
max=0; %initialize maximum to zero
%%================================================================================================
for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
end
%%================================================================================================
for T=2:255      % step through all thresholds from 2 to 255
    w0=sum(P(1:T)); % Probability of class 1 (separated by threshold)
    w1=sum(P(T+1:256)); %probability of class2 (separated by threshold)
    u0=dot([0:T-1],P(1:T))/w0; % class mean u0
    u1=dot([T:255],P(T+1:256))/w1; % class mean u1
    sigma=w0*w1*((u1-u0)^2); % compute sigma i.e variance(between class)
    if sigma>max % compare sigma with maximum 
        max=sigma; % update the value of max i.e max=sigma
        sigmas(T)=sigma;
        threshold=T-1; % desired threshold corresponds to maximum variance of between class
    end
end
%%====================================================================================================
bw=im2bw(I,threshold/255); % Convert to Binary Image
%%figure(3),imshow(bw); % Display the Binary Image
printf("Result wrote to: ");
printf( outputFile );
printf("\n")
imwrite( bw, outputFile );

printf( "\nAsset wrote to" );
printf( asset );
printf("\n")
saveas(plot(1:size(sigmas,2),sigmas),asset)

%%==============================================================================================
