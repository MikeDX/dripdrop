/*
 * dripdrop.prg by MikeDX
 * (c) 2016 DX Games
 */

PROGRAM dripdrop;

PRIVATE

new_pal[255];

BEGIN

//Write your code here, make something amazing!

set_mode(640480);
set_fps(60,0);

load_fpg("dripdrop.fpg");

for(y=1;y<17;y++)
load_fpg("dripdrop.fpg");

for(x=1;x<255;x++)
new_pal[x]=(x-(16*y))%255;
end
for(x=1;x<33;x++)
convert_palette(y,x,&new_pal);
end
end


define_region(1,0,0,640,480);
start_scroll(0,file,901,901,1,15);


DRIP(160,100,_q,_w,0);
DRIP(240,100,_o,_p,1);

if(1)
for(x=0;x<640;x+=8)
DRIP(rand(32,640-32),300,_q,_w,rand(0,16));
DRIP(rand(32,640-32),200,_o,_p,rand(0,16));
end
end

PLATFORM(160,300,1);
PLATFORM(240,350,1);
PLATFORM(360,400,1);
PLATFORM(480,450,1);
PLATFORM(160,500,1);
PLATFORM(240,550,1);
PLATFORM(360,600,1);
PLATFORM(480,650,1);
PLATFORM(480,700,1);
PLATFORM(480,750,1);
PLATFORM(480,800,1);

// BORDERS

for(x=0;x<640;x+=90)
PLATFORM(x+32,480,0);
end

//PLATFORM(80,1100);


//scroll.camera=id;
ctype=c_scroll;
region = 1;
x=0;
y=0;

LOOP


scroll.y0++;


FRAME;

END


exit("Thanks for playing!",1);

END


PROCESS DRIP(x,y,key_left, key_right,file);

PRIVATE

c;
speed=0;
BEGIN
ctype=c_scroll;
region = 1;
GRAPH=1;
speed = 0;
//size=rand(50,100);

loop

if(y-scroll.y0<16)
graph=32-(y-scroll.y0+16);
if(graph>32)
graph=1;
if(rand(0,1))
graph=101;
end

end

end


if(key(key_left) && x>8)
x--;
end

if(key(key_right) && x<632)
x++;
end


c=collision(type DRIP);
if(c)
if(c.x>x)
x-=rand(1,5);
else
x+=rand(1,5);
end

if(x>632)
x=632;
end

end




c=collision(type platform);
if(c)
if(c.ctype==c_scroll)
y=c.y-24;
else
y=scroll.y0+c.y-24;
end

speed=0;

end

if(!collision(type platform))

y+=speed;
if(speed<5)
speed++;
end

end


if(y>scroll.y0+480)
y-=480;
end


frame;

end



end


PROCESS platform(x,y,scrolling)

BEGIN

GRAPH=900;
region =1;
if(scrolling)
ctype=c_scroll;

//loop
while(y>scroll.y0)
    frame;
end

PLATFORM(rand(32,640-32),scroll.y0+480,1);

else

loop
frame;
end


end

end

