    function varargout = Games(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Games_OpeningFcn, ...
                   'gui_OutputFcn',  @Games_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% initialization code


%Executes just before Games is made visible.
function Games_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;% Choose default command line output for Games
guidata(hObject, handles);% Update handles structure

%Outputs from this function are returned to the command line.
function varargout = Games_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;
global pic game S
card=imread('card.png');
for i=1:4
    for j=1:13
        pic((i-1)*13+j).data=card(floor([1:93]+93.5*(i-1)),floor([1:67]+67.5*(j)),:);
    end
end
for i=53:104
pic(i).data=pic(i-52).data;
end
pic(105).data=card(floor([1:93]+93.5*(3-1)),floor([1:67]),:);
pic(106).data=imread('boom.jpg');
pic(107).data=imread('blackjack.png');
pic(108).data=imread('win.jpg');
pic(109).data=imread('lose.jpg');
pic(110).data=imread('insurance.jpg');
game.n=0;
game.player1_score=zeros(1,12);
game.player2_score=zeros(1,12);
game.card=randperm(104);

game.cardn=104;
S{1}=handles.text21;
S{2}=handles.text22;
S{3}=handles.text23;
S{4}=handles.text24;
S{5}=handles.text25;
S{6}=handles.text26;
S{7}=handles.text27;
S{8}=handles.text28;
S{9}=handles.text29;
S{10}=handles.text30;
S{11}=handles.text31;
S{12}=handles.text32;
S{13}=handles.text46;
S{14}=handles.text33;
S{15}=handles.text34;
S{16}=handles.text35;
S{17}=handles.text36;
S{18}=handles.text37;
S{19}=handles.text38;
S{20}=handles.text39;
S{21}=handles.text40;
S{22}=handles.text41;
S{23}=handles.text42;
S{24}=handles.text43;
S{25}=handles.text44;
S{26}=handles.text47;

%Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
global game pic h1 h2 h3 S

game.s=0;
game.n=game.n+1;
if game.n<13
set(handles.text6,'string',num2str(game.n));
game.player1_bet=2;
game.player2_bet=2;
set(handles.text2,'string',num2str(game.player1_bet));
set(handles.text4,'string',num2str(game.player2_bet));
%player1
set(handles.checkbox1,'visible','off');
set(handles.pushbutton1,'visible','off');
set(handles.pushbutton2,'visible','off');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton4,'visible','off');
set(handles.pushbutton5,'visible','off');
%player2
set(handles.checkbox2,'visible','off');
set(handles.pushbutton6,'visible','off');
set(handles.pushbutton7,'visible','off');
set(handles.pushbutton8,'visible','off');
set(handles.pushbutton9,'visible','off');
set(handles.pushbutton10,'visible','off');

game.s=0;


if game.cardn<6
    game.cardn=104;
    game.card=randperm(104);
end

game.dealer_card=game.card(1:2);
game.card(1:2)=[];
game.player1_card=game.card(1:2);
game.card(1:2)=[];
game.player2_card=game.card(1:2);
game.card(1:2)=[];
game.cardn=game.cardn-6;


axes(handles.axes1);
game.dealer_pic=[pic(105).data,pic(game.dealer_card(2)).data];
h1=imshow(game.dealer_pic);
axes(handles.axes2);
game.player1_pic=[pic(game.player1_card(1)).data,pic(game.player1_card(2)).data];
h2=imshow(game.player1_pic);
axes(handles.axes3);
game.player2_pic=[pic(game.player2_card(1)).data,pic(game.player2_card(2)).data];
h3=imshow(game.player2_pic);

game.s=1;
if rem(game.dealer_card(1),13)==1 %
    if goal(game.dealer_card)==21
        axes(handles.axes1);
        game.dealer_pic=[pic(game.dealer_card(1)).data,pic(game.dealer_card(2)).data];
        imshow(game.dealer_pic);
        game.s=0;
        
        %
        goal1=goal(game.player1_card);
        goal2=goal(game.player2_card);
        if goal1==21
            game.player1_score(game.n)=0;
            axes(handles.axes2);
            imshow(pic(107).data);
        else
            game.player1_score(game.n)=-2;
            axes(handles.axes2);
            imshow(pic(109).data);
        end
        if goal2==21
            game.player2_score(game.n)=0;
            axes(handles.axes3);
            imshow(pic(107).data);
        else
            game.player2_score(game.n)=-2;
            axes(handles.axes3);
            imshow(pic(109).data);
        end
    end
else 
    if rem(game.dealer_card(2),13)==1
        game.s=3;
    end
end

switch game.s
    case 0
        set(S{game.n},'string',num2str(game.player1_score(game.n)));
        set(S{game.n+13},'string',num2str(game.player2_score(game.n)));
        if game.n==12
        set(S{game.n+1},'string',num2str(sum(game.player1_score)));
        set(S{game.n+14},'string',num2str(sum(game.player2_score)));
        end
    case 1
        set(handles.pushbutton2,'visible','on');
        set(handles.pushbutton3,'visible','on');
        set(handles.pushbutton4,'visible','on');
        set(handles.pushbutton5,'visible','on');
    case 3
        set(handles.checkbox1,'visible','on');
        set(handles.pushbutton1,'visible','on');
end
end

%Executes on button press in checkbox2
function checkbox2_Callback(hObject, eventdata, handles)
%Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global game pic S 
game.in(2)=get(handles.checkbox2,'value');
set(handles.checkbox2,'visible','off');
set(handles.pushbutton6,'visible','off');

if game.in(2)==1
    game.player2_bet=game.player2_bet*1.5;
    set(handles.text4,'string',num2str(game.player1_bet));
end
game.s=0;
if goal(game.dealer_card)==21
    axes(handles.axes1);
    game.dealer_pic=[pic(game.dealer_card(1)).data,pic(game.dealer_card(2)).data];
    imshow(game.dealer_pic);
    game.s=0;
    
    
    goal1=goal(game.player1_card);
    goal2=goal(game.player2_card);
    if goal1==21
        game.player1_score(game.n)=0;
        axes(handles.axes2);
        imshow(pic(107).data);
    else
        game.player1_score(game.n)=-game.player1_bet;
        axes(handles.axes2);
        imshow(pic(109).data);
    end
    if goal2==21
        game.player2_score(game.n)=0;
        axes(handles.axes3);
        imshow(pic(107).data);
    else
        game.player2_score(game.n)=-game.player2_bet;
        axes(handles.axes3);
        imshow(pic(109).data);
    end
    if game.in(1)==1
        game.player1_score(game.n)=game.player1_bet;
        axes(handles.axes2);
        imshow(pic(110).data);
    end
    if game.in(2)==1
        game.player2_score(game.n)=game.player2_bet;
        axes(handles.axes3);
        imshow(pic(110).data);
    end
else
    game.s=1;
end

switch game.s
    case 0
        set(S{game.n},'string',num2str(game.player1_score(game.n)));
        set(S{game.n+13},'string',num2str(game.player2_score(game.n)));
        if game.n==12
        set(S{game.n+1},'string',num2str(sum(game.player1_score)));
        set(S{game.n+14},'string',num2str(sum(game.player2_score)));
        end
    case 1
        set(handles.pushbutton2,'visible','on');
        set(handles.pushbutton3,'visible','on');
        set(handles.pushbutton4,'visible','on');
        set(handles.pushbutton5,'visible','on');
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

global game pic

set(handles.pushbutton8,'visible','off');
set(handles.pushbutton10,'visible','off');
if game.cardn<1
    game.cardn=104;
    game.card=randperm(104);
end
game.cardn=game.cardn-1;
game.player2_card=[game.player2_card,game.card(1)];
game.card(1)=[];

if goal(game.player2_card)<=21
    axes(handles.axes3);
    game.player2_pic=[game.player2_pic,pic(game.player2_card(end)).data];
    imshow(game.player2_pic);
else
    game.player2_card=-1;
    axes(handles.axes3);
    imshow(pic(106).data);
    set(handles.pushbutton7,'visible','off');
end
if goal(game.player2_card)==21
    axes(handles.axes3);
    imshow(pic(107).data);
    set(handles.pushbutton7,'visible','off');
end

%Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)

global game S pic
game.player2_bet=game.player2_bet/2;
axes(handles.axes3);
imshow(pic(109).data);
game.player2_card=-1;
set(handles.pushbutton7,'visible','off');
set(handles.pushbutton8,'visible','off');
set(handles.pushbutton9,'visible','off');
set(handles.pushbutton10,'visible','off');

game.dealer_pic=[pic(game.dealer_card(1)).data,pic(game.dealer_card(2)).data];
axes(handles.axes1)
imshow(game.dealer_pic);
goal0=goal(game.dealer_card);
while goal0<17
    if game.cardn<1
        game.cardn=104;
        game.card=randperm(104);
    end
    game.cardn=game.cardn-1;
    game.dealer_card=[game.dealer_card,game.card(1)];
    game.card(1)=[];
    goal0=goal(game.dealer_card);
    axes(handles.axes1);
    game.dealer_pic=[game.dealer_pic,pic(game.dealer_card(end)).data];
    imshow(game.dealer_pic);
    pause(1)
end
if goal0>21
    goal0=-1;
end
goal1=goal(game.player1_card);
goal2=goal(game.player2_card);

%player1
if goal1<goal0
    axes(handles.axes2);
    imshow(pic(109).data);
    game.player1_score(game.n)=-game.player1_bet;
end
if goal1==goal0
    game.player1_score(game.n)=0;
end
if goal1>goal0
    axes(handles.axes2);
    imshow(pic(108).data);
    game.player1_score(game.n)=game.player1_bet;
end

%player2
if goal2<goal0
    axes(handles.axes3);
    imshow(pic(109).data);
    game.player2_score(game.n)=-game.player2_bet;
end
if goal2==goal0
    game.player2_score(game.n)=0;
end
if goal2>goal0
    axes(handles.axes3);
    imshow(pic(108).data);
    game.player2_score(game.n)=game.player2_bet;
end

set(S{game.n},'string',num2str(game.player1_score(game.n)));
set(S{game.n+13},'string',num2str(game.player2_score(game.n)));
if game.n==12
    set(S{game.n+1},'string',num2str(sum(game.player1_score)));
    set(S{game.n+14},'string',num2str(sum(game.player2_score)));
end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
global game S pic goal0 goal1 goal2
set(handles.pushbutton7,'visible','off');
set(handles.pushbutton8,'visible','off');
set(handles.pushbutton9,'visible','off');
set(handles.pushbutton10,'visible','off');

game.dealer_pic=[pic(game.dealer_card(1)).data,pic(game.dealer_card(2)).data];
axes(handles.axes1)
imshow(game.dealer_pic);
goal0=goal(game.dealer_card);
while goal0<17
    if game.cardn<1
        game.cardn=104;
        game.card=randperm(104);
    end
    game.cardn=game.cardn-1;
    game.dealer_card=[game.dealer_card,game.card(1)];
    game.card(1)=[];
    goal0=goal(game.dealer_card);
    axes(handles.axes1);
    game.dealer_pic=[game.dealer_pic,pic(game.dealer_card(end)).data];
    imshow(game.dealer_pic);
    pause(1)
end
if goal0>21
    goal0=-1;
end
goal1=goal(game.player1_card);
goal2=goal(game.player2_card);

%player1
if goal1<goal0
    axes(handles.axes2);
    imshow(pic(109).data);
    game.player1_score(game.n)=-game.player1_bet;
end
if goal1==goal0
    game.player1_score(game.n)=0;
end
if goal1>goal0
    axes(handles.axes2);
    imshow(pic(108).data);
    game.player1_score(game.n)=game.player1_bet;
end

%player2
if goal2<goal0
    axes(handles.axes3);
    imshow(pic(109).data);
    game.player2_score(game.n)=-game.player2_bet;
end
if goal2==goal0
    game.player2_score(game.n)=0;
end
if goal2>goal0
    axes(handles.axes3);
    imshow(pic(108).data);
    game.player2_score(game.n)=game.player2_bet;
end

set(S{game.n},'string',num2str(game.player1_score(game.n)));
set(S{game.n+13},'string',num2str(game.player2_score(game.n)));
if game.n==12
    set(S{game.n+1},'string',num2str(sum(game.player1_score)));
    set(S{game.n+14},'string',num2str(sum(game.player2_score)));
end


%Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
global game S pic
game.player2_bet=game.player2_bet*2;
set(handles.text4,'string',num2str(game.player2_bet));
if game.cardn<1
    game.cardn=104;
    game.card=randperm(104);
end
game.cardn=game.cardn-1;
game.player2_card=[game.player2_card,game.card(1)];
game.card(1)=[];

if goal(game.player2_card)<=21
    axes(handles.axes3);
    game.player2_pic=[game.player2_pic,pic(game.player2_card(end)).data];
    imshow(game.player2_pic);
else
    game.player2_card=-1;
    axes(handles.axes3);
    imshow(pic(106).data);
end
if goal(game.player2_card)==21
    axes(handles.axes3);
    imshow(pic(107).data);
end

set(handles.pushbutton7,'visible','off');
set(handles.pushbutton8,'visible','off');
set(handles.pushbutton9,'visible','off');
set(handles.pushbutton10,'visible','off');
game.dealer_pic=[pic(game.dealer_card(1)).data,pic(game.dealer_card(2)).data];
axes(handles.axes1)
imshow(game.dealer_pic);
goal0=goal(game.dealer_card);
while goal0<17
    if game.cardn<1
        game.cardn=104;
        game.card=randperm(104);
    end
    game.cardn=game.cardn-1;
    game.dealer_card=[game.dealer_card,game.card(1)];
    game.card(1)=[];
    goal0=goal(game.dealer_card);
    axes(handles.axes1);
    game.dealer_pic=[game.dealer_pic,pic(game.dealer_card(end)).data];
    imshow(game.dealer_pic);
    pause(1)
end
if goal0>21
    goal0=-1;
end
goal1=goal(game.player1_card);
goal2=goal(game.player2_card);

%player1
if goal1<goal0
    axes(handles.axes2);
    imshow(pic(109).data);
    game.player1_score(game.n)=-game.player1_bet;
end
if goal1==goal0
    game.player1_score(game.n)=0;
end
if goal1>goal0
    axes(handles.axes2);
    imshow(pic(108).data);
    game.player1_score(game.n)=game.player1_bet;
end

%player2
if goal2<goal0
    axes(handles.axes3);
    imshow(pic(109).data);
    game.player2_score(game.n)=-game.player2_bet;
end
if goal2==goal0
    game.player2_score(game.n)=0;
end
if goal2>goal0
    axes(handles.axes3);
    imshow(pic(108).data);
    game.player2_score(game.n)=game.player2_bet;
end

set(S{game.n},'string',num2str(game.player1_score(game.n)));
set(S{game.n+13},'string',num2str(game.player2_score(game.n)));
if game.n==12
    set(S{game.n+1},'string',num2str(sum(game.player1_score)));
    set(S{game.n+14},'string',num2str(sum(game.player2_score)));
end

%Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)



%Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global game
game.in(1)=get(handles.checkbox1,'value');
set(handles.checkbox1,'visible','off');
set(handles.pushbutton1,'visible','off');
set(handles.checkbox2,'visible','on');
set(handles.pushbutton6,'visible','on');
if game.in(1)==1
    game.player1_bet=game.player1_bet*1.5;
    set(handles.text2,'string',num2str(game.player1_bet));
end
%Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global game pic

set(handles.pushbutton3,'visible','off');
set(handles.pushbutton5,'visible','off');
if game.cardn<1
    game.cardn=104;
    game.card=randperm(104);
end
game.cardn=game.cardn-1;
game.player1_card=[game.player1_card,game.card(1)];
game.card(1)=[];

if goal(game.player1_card)<=21
    axes(handles.axes2);
    game.player1_pic=[game.player1_pic,pic(game.player1_card(end)).data];
    imshow(game.player1_pic);
else
    game.player1_card=-1;
    axes(handles.axes2);
    imshow(pic(106).data);
    set(handles.pushbutton2,'visible','off');
end
if goal(game.player1_card)==21
    axes(handles.axes2);
    imshow(pic(107).data);
    set(handles.pushbutton2,'visible','off');
end
%Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global game pic
axes(handles.axes2);
imshow(pic(109).data);
game.player1_bet=game.player1_bet/2;
game.player1_card=-1;

set(handles.pushbutton2,'visible','off');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton4,'visible','off');
set(handles.pushbutton5,'visible','off');

set(handles.pushbutton7,'visible','on');
set(handles.pushbutton8,'visible','on');
set(handles.pushbutton9,'visible','on');
set(handles.pushbutton10,'visible','on');
%Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

set(handles.pushbutton2,'visible','off');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton4,'visible','off');
set(handles.pushbutton5,'visible','off');

set(handles.pushbutton7,'visible','on');
set(handles.pushbutton8,'visible','on');
set(handles.pushbutton9,'visible','on');
set(handles.pushbutton10,'visible','on');



%Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global game pic
set(handles.pushbutton2,'visible','off');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton4,'visible','off');
set(handles.pushbutton5,'visible','off');

set(handles.pushbutton7,'visible','on');
set(handles.pushbutton8,'visible','on');
set(handles.pushbutton9,'visible','on');
set(handles.pushbutton10,'visible','on');
game.player1_bet=game.player1_bet*2;
set(handles.text2,'string',num2str(game.player1_bet));
if game.cardn<1
    game.cardn=104;
    game.card=randperm(104);
end
game.cardn=game.cardn-1;
game.player1_card=[game.player1_card,game.card(1)];
game.card(1)=[];

if goal(game.player1_card)<=21
    axes(handles.axes2);
    game.player1_pic=[game.player1_pic,pic(game.player1_card(end)).data];
    imshow(game.player1_pic);
else
    game.player1_card=-1;
    axes(handles.axes2);
    imshow(pic(106).data);
end
if goal(game.player1_card)==21
    axes(handles.axes2);
    imshow(pic(107).data);
end


%Executes on button press in pushbutton3.
function pushbutton12_Callback(hObject, eventdata, handles)
global game pic
axes(handles.axes2);
imshow(pic(109).data);
game.player1_bet=game.player1_bet/2;
game.player1_card=0;

set(handles.pushbutton2,'visible','off');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton4,'visible','off');
set(handles.pushbutton5,'visible','off');

set(handles.pushbutton7,'visible','on');
set(handles.pushbutton8,'visible','on');
set(handles.pushbutton9,'visible','on');
set(handles.pushbutton10,'visible','on');

% Academic Integrity Statement:

%      We have not used source code obtained from
%       any other unauthorized source, either modified
%       or unmodified.  Neither have we provided access
%       to our code to other teams. The project we are
%       submitting is our own original work.