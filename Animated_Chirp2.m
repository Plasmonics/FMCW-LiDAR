Fs = 80; 
T=2;
t = 0:1/Fs:T  ;  

f = 400 ;  
f1 = [] ;
temp1 = 1 ;
for i = 1 : length(t)

    f1 = [f1 temp1] ;
    temp1 = temp1 + 0.00005 *f  ;
end

y1 = cos( 2* pi * t .* f1 ) ;

%    figure
%    plot(y1) ;
 set(gca,'Color','k') ;             %  gca for backdround color
 set(gca,'xcolor','w','ycolor','w');
xlabel('time');       ylabel('signal');
%xlim([0.01 1]);        ylim([-1 1])
an= animatedline;
c = an.Color;
an.Color = 'magenta';
an.LineWidth = 2;
% an.MaximumNumPoints = 1000000;
numpoints = (Fs*T) +1;

for i=1:length(t)
    addpoints(an,t(i),y1(i));
     drawnow;
    set(gcf,'Color','k')              %  gca for backdround color
    F(i) = getframe(gcf);
     
     pause(0.1);
 
end
% drawnow % draw final frame
 video = VideoWriter('Chirp_show_Present.avi',  'Uncompressed AVI');
%  video.FrameRate =60;
 open(video)
 writeVideo(video,F);
 close(video)
 
%  ani = animation.FuncAnimation(fig, update, init_func=init, interval=200, frames=22, blit=False)
%  ani.save('animation.gif', writer="imagemagick", savefig_kwargs=dict(facecolor='#EAEAF2'))
 

%sound (y, Fs);
% figure
% plot(t,y1) ;
% 