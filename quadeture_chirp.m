Fsl = 8*10^6; 
% ff = 800 ;  
f11l = 0.1;             f22l = 15; 


T1l= 1;
t1l = 0:1/Fsl:T1l ;  

B= f22l -f11l  ;
V_D= 0.3 ;

 Chirp = cos((2.* pi.* f11l.*t1l) + ((pi.*B .*t1l.^2)/ T1l));
E_in= 0.002.* sin(2.* pi.* 563*10^4.* t1l);
%E_out = E_in .* (cos(((pi .* V_D)./ (2.* pi)) .*( cos((2.* pi.* f11l.*t1l) + ((pi.*B .*t1l.^2)/ T1l)) - (pi./2))));
E_out_A = E_in .* (cos((((pi .* V_D)./ (2.* pi)) .*Chirp )- (pi./2)));
E_out_P = E_in .* (cos(((pi .* V_D)./ (2.* pi)) .*( Chirp)));

figure
plot (t1l,  Chirp);

figure
plot (t1l, E_in);

figure
plot (t1l, E_out_A);

figure
plot (t1l, E_out_P);


E_out_A_fft = fft(E_out_A);

figure
plot (t1l, E_out_A_fft);

E_out_P_fft = fft(E_out_P);

figure
plot (t1l, E_out_P_fft);