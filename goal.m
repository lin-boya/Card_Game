function y=goal(x)
x0=rem(x,13);

n=length(x);
x0(x0==11)=10;
x0(x0==12)=10;
x0(x0==0)=10;

one_n=0;
one_n=sum(x0==1);

if one_n==0
    y=sum(x0);
else 
    y0=sum(x0(x0~=1));
    y1=y0+[0:one_n]*11+[one_n:-1:0]*1;
    if min(y1)>=21
        y=min(y1);
    else
        y2=21-y1;
        y2(y2<0)=[];
        a=find(y2==min(y2));
        y=y1(a(1));
    end
end

%   Academic Integrity Statement:
%
%      We have not used source code obtained from
%       any other unauthorized source, either modified
%       or unmodified.  Neither have we provided access
%       to our code to other teams. The project we are
%       submitting is our own original work.
