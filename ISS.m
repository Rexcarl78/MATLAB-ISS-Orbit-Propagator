clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//CONSTANTS AND INITIALIZATION//
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
go=9.81; %Gravity aceleration on the Earth's surface
ang_ve=7.292*1e-5; %Earth's angular velocity
Rt=6371000;
g= @(d) go*(Rt/abs(d))^2; %Variable gravity function
%Initial conditions
latitude_o=21.12;
longitude_o=-152.83;
attitude_o=416700;
azimuth=316.6;
do=attitude_o+6371000; %Distance to the Earth's center
vo=7660; %Absolute velocity (seen from a Earth-fixed non-rotating frame of reference)
xo=do*cosd(latitude_o)*cosd(longitude_o);
yo=do*cosd(latitude_o)*sind(longitude_o);
zo=do*sind(latitude_o);
%Decomposing the vector velocity in our frame of reference
vxo=-vo*sind(azimuth)*sind(longitude_o)-vo*cosd(azimuth)*sind(latitude_o)*cosd(longitude_o);
vyo=vo*sind(azimuth)*cosd(longitude_o)-vo*cosd(azimuth)*sind(longitude_o)*sind(latitude_o);
vzo=vo*cosd(azimuth)*cosd(latitude_o);
m_tot=420000;%ISS mass (kg)
dt=1;%Time step
to=0; %Initial time
T=5580; %Final time of simulation
t=to:dt:T;
N=length(t);% Iterations
%Prelocate the data vectors
v=zeros(1,N);
d=zeros(1,N);
latitude=zeros(1,N);
longitude=zeros(1,N);
altitude=zeros(1,N);
Y=zeros(6,N); %State vector (position and velocity)
rel_x=zeros(1,N); %Relative position seen from the Earth (rotating) (initially below the ISS, still in that point along the simulation)
rel_y=zeros(1,N);
Y(1,1)=xo;
Y(2,1)=yo;
Y(3,1)=zo;
Y(4,1)=vxo;
Y(5,1)=vyo;
Y(6,1)=vzo;
rel_x(1)=xo;
rel_y(1)=yo;
d(1)=do;
v(1)=vo;
latitude(1)=latitude_o;
longitude(1)=longitude_o;
altitude(1)=attitude_o;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//Fourth-order Runge-Kutta implementation//
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:(N-1)%RK4
    %Step 1
    a1x= -g(d(i))*Y(1,i)/d(i);
    a1y = -g(d(i))*Y(2,i)/d(i);
    a1z = -g(d(i))*Y(3,i)/d(i);
    kx1=Y(4,i);
    ky1=Y(5,i);
    kz1=Y(6,i);
    %Step 2
    x_e2=Y(1,i)+(dt/2)*kx1;
    y_e2=Y(2,i)+(dt/2)*ky1;
    z_e2=Y(3,i)+(dt/2)*kz1;
    d_e2=sqrt(x_e2^2+y_e2^2+z_e2^2);
    a2x= -g(d_e2)*x_e2/d_e2;
    a2y = -g(d_e2)*y_e2/d_e2;
    a2z = -g(d_e2)*z_e2/d_e2;
    kx2 = Y(4,i) + (dt/2) * a2x;
    ky2 = Y(5,i) + (dt/2) * a2y;
    kz2 = Y(6,i) + (dt/2) * a2z;
    %Step 3
    x_e3=Y(1,i)+(dt/2)*kx2;
    y_e3=Y(2,i)+(dt/2)*ky2;
    z_e3=Y(3,i)+(dt/2)*kz2;
    d_e3=sqrt(x_e3^2+y_e3^2+z_e3^2);
    a3x=-g(d_e3)*x_e3/d_e3;
    a3y =-g(d_e3)*y_e3/d_e3;
    a3z =-g(d_e3)*z_e3/d_e3;
    kx3 = Y(4,i) + (dt/2) * a3x;
    ky3 = Y(5,i) + (dt/2) * a3y;
    kz3 = Y(6,i) + (dt/2) * a3z;
    %Step 4
    x_e4 = Y(1,i) + dt * kx3;
    y_e4=Y(2,i)+dt*ky3;
    z_e4=Y(3,i)+dt*kz3;
    d_e4 = sqrt(x_e4^2+y_e4^2+z_e4^2);
    a4x= -g(d_e4)*x_e4/d_e4;
    a4y = -g(d_e4)*y_e4/d_e4;
    a4z = -g(d_e4)*z_e4/d_e4;
    kx4 = Y(4,i) + dt * a4x;
    ky4 = Y(5,i) + dt * a4y;
    kz4 = Y(6,i) + dt * a4z;
    % We calculate the final values
    Y(1,i+1) = Y(1,i) + (dt/6) * (kx1 + 2*kx2 + 2*kx3 + kx4);
    Y(2,i+1)=Y(2,i) + (dt/6) * (ky1 + 2*ky2 + 2*ky3 + ky4);
    Y(3,i+1)=Y(3,i) + (dt/6) * (kz1 + 2*kz2 + 2*kz3 + kz4);
    Y(4,i+1) = Y(4,i) + (dt/6) * (a1x + 2*a2x + 2*a3x + a4x);
    Y(5,i+1)=Y(5,i)+ (dt/6) * (a1y + 2*a2y + 2*a3y + a4y);
    Y(6,i+1) = Y(6,i) + (dt/6) * (a1z + 2*a2z + 2*a3z + a4z);
    v(i+1) =sqrt(Y(4,i+1)^2+Y(5,i+1)^2 +Y(6,i+1)^2);
    d(i+1) = sqrt(Y(1,i+1)^2 + Y(2,i+1)^2 + Y(3,i+1)^2);
     if (d(i+1)-Rt)<0 %Crash break
        d(i+1)=Rt;
        disp('Error');
        break; 
     end
    %Relative position seen from the Earth (rotating) (initially below the
    %ISS, still in that point along the simulation)
    rel_x(i+1)=Y(1,i)*cos(ang_ve*t(i+1))+Y(2,i)*sin(ang_ve*t(i+1));
    rel_y(i+1)=-Y(1,i)*sin(ang_ve*t(i+1))+Y(2,i)*cos(ang_ve*t(i+1));
    %Coordinates
    latitude(i+1)=atan2d(Y(3,i+1),sqrt(Y(1,i+1)^2+Y(2,i+1)^2));
    %We have to consider Earth rotation, so we use relative position
    longitude(i+1)=mod(atan2d(rel_y(i+1),rel_x(i+1))+180,360)-180;
    altitude(i+1)=d(i+1)-Rt;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//ANIMATION AND GRAPHICS//
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3D Trajectory of the ISS
figure(1)
hold on
grid on;
axis equal
sgtitle('3D Trajectory')
[Ex,Ey,Ez]=sphere(100);
Earth_img=imread("Earth-Surface.jpg");
Earth_img_rot=flip(Earth_img,1);
Earth=surf(Ex*Rt,Ey*Rt,Ez*Rt,'FaceColor','texturemap','Cdata',Earth_img_rot,'EdgeColor','none');
RotationAxis=[0,0,1];
rotate(Earth,RotationAxis,rad2deg(ang_ve*T)); %We ensure that the final position matches the final coordinates calculated
sun_light=light;
set(sun_light,'Position',[14960000000,0,0]);
view(3);
plot3(Y(1,:),Y(2,:),Y(3,:),'r-');
%ISS coordinates along the time of simulation
figure(2)
title('Ground Track')
hold on;
imagesc([-180 180],[90,-90],Earth_img);
axis tight
set(gca, 'YDir', 'normal');
xlim([-180,180]);
ylim([-90,90]);
%Copying the original vectors
lon_copy=longitude;
lat_copy=latitude;
%Find (with a security margin) if the ISS completed an orbit and skip the
%next data to avoid straight lines on the final figure
jump_index=find(abs(diff(lon_copy))>350);
lon_copy(jump_index)=NaN;
lat_copy(jump_index)=NaN;
plot(lon_copy,lat_copy,'r');
%Animation
%WARNING:Animating a long simulation may collapse MATLAB
animate=input('Run a video of the ISS movement? [1]=Yes [0]=No: ');
video_speed=input('Write the speed of the video:');
figure(3)
hold on
grid on;
title('Animated Trajectory','Color','White');1
set(gcf,'Color','k');
set(gca,'Color','none')
axis equal
[Ex,Ey,Ez]=sphere(100);
Earth=surf(Ex*Rt,Ey*Rt,Ez*Rt,'FaceColor','texturemap','Cdata',Earth_img_rot,'EdgeColor','none');
lighting flat
material dull
%sun_light=light;
%set(sun_light,'Position',[14960000000,0,0]);
view(3);
Station=plot3(Y(1,1),Y(2,1),Y(3,1),'go','MarkerSize',10,'Markerface','g');
path=animatedline(Y(1,1),Y(2,1),Y(3,1),'Color','r');
txt=annotation('textbox','String','Initialization...','BackgroundColor','y');
Video=VideoWriter('trajectory_animation_test3.mp4','MPEG-4');
Video.FrameRate=N/T*video_speed;
axis equal
open(Video);
for i=2:N
    set(Station,'XData',Y(1,i),'YData',Y(2,i),'ZData',Y(3,i));
    addpoints(path,Y(1,i),Y(2,i),Y(3,i));
    rotate(Earth,RotationAxis,rad2deg(ang_ve*dt));
    % Current ISS position
    ISS_pos = [Y(1,i), Y(2,i), Y(3,i)];
    % Direction from Earth's center to the ISS
    cam_direction = ISS_pos / norm(ISS_pos);
    % Place the camera 500 km farther away from Earth than the ISS
    camera_distance = 500000;      % meters
    camera_position = ISS_pos + camera_distance * cam_direction;
    campos(gca,camera_position);
    camtarget(gca,ISS_pos);
    camup(gca,[0 0 1]);
    str={sprintf('Speed: (%.4f) km/s',v(i)/1000),sprintf('Altitude (%.4f) km',(altitude(i))/1000)};
    set(txt,'String',str);
    frame=getframe(gcf);
    writeVideo(Video,frame);
end
close(Video);