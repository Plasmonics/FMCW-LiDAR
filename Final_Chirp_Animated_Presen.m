%% Chirp signal 

Fsl = 160; 
ff = 800 ;  
f11l = 1000;             f22l = 1500; 


T1l= 1;
t1l = 0:1/Fsl:T1l ;  
 fm1l = [] ;
 tem1l = 1000 ;
f1 = [] ;
temp1 = 1 ;
 
 
 for i = 1 : length(t1l)
fm1l  = ((f22l - f11l) ./T1l).* t1l  ; 
    fm1l = [tem1l+fm1l] ;
    
    f1 = [f1 temp1] ;
    temp1 = temp1 + 0.0001*ff  ;

 end

 T2l = 0.04 +T1l;
 t2l = (T1l+ 1/Fsl):1/Fsl: T2l  ; 
 fm2l= [] ;
 tem2l = 1500 ;
 f2 = [] ;
temp2 = 1 ;

 for i = 1 : length(t2l)
fm2l  = ((0-f22l) ./T2l).* t2l  ; 
    fm2l = [tem2l+fm2l] ;
    
 f2 = [f2 temp2] ;
    temp2 = temp2 - 0.0001*ff  ;
 end
 
 T3l = 0.16 +T2l;
 t3l = (T2l+ 1/Fsl):1/Fsl:T3l  ; 
 fm3l= [] ;
 tem3l = 1000 ;
 f3 = [] ;
temp3 = 1 ;
 for i = 1 : length(t2l)
% fm3  = ((f11 - f22) ./T3).* t3  ; 
%     fm3 = [tem3+fm3] ;
fm3l = zeros(size(t3l));

% f3 = [f3 temp3] ;
%     temp3 =  ones(size(t3l)); 
f3 = ones(size(t3l)); 
 end
 
 T4l = 1+T3l;
t4l = (T3l+ 1/Fsl):1/Fsl:T4l ;  
 fm4l = [] ;
 tem4l= 1000 ;
 f4 = [] ;
temp4 = 1 ;

 for i = 1 : length(t4l)
fm4l = ((f22l - f11l) ./T1l).* t1l  ; 
    fm4l = [tem4l+fm4l] ;
    
 f4 = [f4 temp4] ;
    temp4 = temp4 + 0.0001*ff  ;
 end
 
  t2 = ( t2l-T1l);
  t3 = (t3l- T2l);
  t4 = (t4l- T3l);
  
  y1 = sin( 2* pi * t1l  .* f1 ) ;
%   y2 = cos( 2* pi * t2 .* f2 ) ;
%   y3 = cos( 2* pi * t3  .* f3 ) ;
y2 = zeros(size(cos( t2))) ;
y3 =  zeros(size(cos( t3))) ;
  y4 = sin( 2* pi * t4  .* f4 ) ;
  
T =[ t1l  t2l  t3l  t4l];
 fm = [ fm1l  fm2l  fm3l  fm4l];
 
y = [y1 y2  y3  y4 ];


subplot(2,1,1)
 
an= animatedline;
c = an.Color;
an.Color = 'cyan';
an.LineWidth = 2;
 set(gca,'Color','k') ;             %  gca for backdround color
 set(gca,'xcolor','w','ycolor','w');
xlabel('time (\mum)');       ylabel('frequency (MHz)');
xlim([0.01 2.2]);        ylim([1000 1500]);
% set(gcf,'size',[600 500])

 subplot(2,1,2)
 
am= animatedline;
d = am.Color;
am.Color = 'magenta';
am.LineWidth = 2;
 set(gca,'Color','k') ;             %  gca for backdround color
 set(gca,'xcolor','w','ycolor','w');
xlabel('time (\mum)');       ylabel('frequency  chirp');
xlim([0.01 2.2]);        ylim([-1 1]);



% an.MaximumNumPoints = 1000000;
numpoints = (Fsl*T) +1;

for i=1:length(T)
%     addpoints(an,T(i),fm(i));
%      subplot(2,1,1)
 addpoints(an,T(i),fm(i));
      drawnow;
%      subplot(2,1,2)
 addpoints(am,T(i),y(i));
     drawnow;
     
    set(gcf,'Color','k')              %  gca for backdround color
    F(i) = getframe(gcf);
     
     pause(0.1);
 
end
% drawnow % draw final frame
 video = VideoWriter('Chirp_show_Linear.avi',  'Uncompressed AVI');
%  video.FrameRate =60;
 open(video)
 writeVideo(video,F);
 close(video)


