%%%% Last update 21 August 2012, Houman

clc
close all
clear all

% FILE_TO='TEST';

BLOCK_NUM_SET=[1]
sub_block=0; %0=full block,1=first half block, 2=second half block
 
% FOLDER_FROM='\\zocconasphys2.cns.sissa.it\acute_objects\Recording_03_07_2012';
FOLDER_FROM='C:\TDT\OpenEx\Tanks\Fede_Acute_Recording_10_4_2013';

% FOLDER_FROM='C:\TDT\OpenEx\Tanks\Sina_Acute1_Rec_20_12_2012';

for BLOCK_NUM=BLOCK_NUM_SET
BCODE1=[];
TBCOD1=[];
ss=0;
FOLDER_TO=['\\zocconasphys1.cns.sissa.it\chronic_inv_rec\Tanks\Fede_Acute_Recording_10_4_2013\ANALYSED\Block-',num2str(BLOCK_NUM)];

TIME_CU=0;

[BCODE TBCOD]=plotchan2(FOLDER_FROM,['Block-',num2str(BLOCK_NUM)],'STIM',0,0,TIME_CU,0);
if isempty(TBCOD)
    error('TBCOD range is large, try smaller')
end
% 
if (TBCOD(end)>18000)
error('LONG RECORDING')
end

if (TBCOD(end)>15000 & TBCOD(end)<=18000)
    PER=6;
    TIME_S(1)=0;
    TIME_E(1)=3000;
    jj=unique(diff(TBCOD));
    TIME_S(2)=3000+jj(1);
    TIME_E(2)=6000;
    TIME_S(3)=6000+jj(1);
    TIME_E(3)=9000;
    TIME_S(4)=9000+jj(1);
    TIME_E(4)=TBCOD(end);
    TIME_S(5)=12000+jj(1);
    TIME_E(5)=TBCOD(end);
    TIME_S(6)=15000+jj(1);
    TIME_E(6)=TBCOD(end);
end

if (TBCOD(end)>12000 & TBCOD(end)<=15000)
    PER=5;
    TIME_S(1)=0;
    TIME_E(1)=3000;
    jj=unique(diff(TBCOD));
    TIME_S(2)=3000+jj(1);
    TIME_E(2)=6000;
    TIME_S(3)=6000+jj(1);
    TIME_E(3)=9000;
    TIME_S(4)=9000+jj(1);
    TIME_E(4)=TBCOD(end);
    TIME_S(5)=12000+jj(1);
    TIME_E(5)=TBCOD(end);
end

if (TBCOD(end)>9000 & TBCOD(end)<=12000)
    PER=4;
    TIME_S(1)=0;
    TIME_E(1)=3000;
    jj=unique(diff(TBCOD));
    TIME_S(2)=3000+jj(1);
    TIME_E(2)=6000;
    TIME_S(3)=6000+jj(1);
    TIME_E(3)=9000;
    TIME_S(4)=9000+jj(1);
    TIME_E(4)=TBCOD(end);
end

if (TBCOD(end)>6000 & TBCOD(end)<=9000)
    PER=3;
    TIME_S(1)=0;
    TIME_E(1)=3000;
    jj=unique(diff(TBCOD));
    TIME_S(2)=3000+jj(1);
    TIME_E(2)=6000;
    TIME_S(3)=6000+jj(1);
    TIME_E(3)=TBCOD(end);
end

if (TBCOD(end)>3000 & TBCOD(end)<=6000)
    PER=2;
    TIME_S(1)=0;
    TIME_E(1)=3000;
    jj=unique(diff(TBCOD));
    TIME_S(2)=3000+jj(1);
    TIME_E(2)=TBCOD(end);
end
if TBCOD(end)<=3000
    PER=1;
    TIME_S(1)=0;
    TIME_E(1)=0;
end

YANLG=[];
TANLG=[];
for PE=1:PER
[YANLG1 TANLG1]=plotchan2(FOLDER_FROM,['Block-',num2str(BLOCK_NUM)],'ANLG',2,TIME_S(PE),TIME_E(PE),0);
if (isempty(YANLG1) | isempty(TANLG1))
    error('long loading, read shorter portion')
end
YANLG=[YANLG YANLG1];
TANLG=[TANLG TANLG1];
end

TFULL=TANLG(end);

TEND=TFULL/2;
switch sub_block
    case 0
% BCODE=BCODE(1);
% TBCOD=TBCOD(1);
YANLG=YANLG(TANLG>(TBCOD(1)-5));
TANLG=TANLG(TANLG>(TBCOD(1)-5));
    case 1
BCODE=BCODE(TBCOD<(TEND+1.5));
TBCOD=TBCOD(TBCOD<(TEND+1.5));
YANLG=YANLG(TANLG<(TEND+1.5));
TANLG=TANLG(TANLG<(TEND+1.5));
    case 2
BCODE=BCODE(TBCOD>(TEND-0.00));
YANLG=YANLG(TANLG>(TEND-0.00));   
TBCOD=TBCOD(TBCOD>(TEND-0.00));
TANLG=TANLG(TANLG>(TEND-0.00));
end

figure(11)
plot(TBCOD,BCODE,'-or')

tb1=TBCOD;
bc1=BCODE;

YDIG=(YANLG>(0.3*(max(YANLG)-min(YANLG))+min(YANLG)));

%%%for very bad analog use bcode for timing too
% YDIG=0*YANLG;
% for i=1:numel(BCODE)
%     tp=TBCOD(i);
%     YDIG(TANLG>=tp-10/1000 & TANLG<tp+250/1000-10/1000)=1;
% end

ST_PO=find(diff(YDIG)>0);
EN_PO=find(diff(YDIG)<0);

% if numel(ST_PO)>numel(EN_PO)
%     ST_PO=ST_PO(1:numel(EN_PO));
% end
% if numel(ST_PO)<numel(EN_PO)
%     EN_PO=EN_PO(1:numel(ST_PO));
% end

BIT_C=zeros(1,numel(YDIG));

% for n=2:numel(ST_PO)-2
% BIT_C(ST_PO(n):EN_PO(n))=BCODE(n-1);
% BIT_C(EN_PO(n)+1:ST_PO(n+1)-1)=0;
% end
n_er=0;
outlier=0;

for n=1:numel(BCODE)
   
% BIT_C(ST_PO(n-1):EN_PO(n))=BCODE(n-1); %%original
% BIT_C(EN_PO(n)+1:ST_PO(n)-1)=0;    %%original

% switch sub_block
%     case 0

% BIT_C(ST_PO(n-1):EN_PO(n-1))=BCODE(n-1);
% BIT_C(EN_PO(n-1)+1:ST_PO(n)-1)=0;
% % % % BIT_C(ST_PO(n):EN_PO(n))=BCODE(n-1);
% % % % BIT_C(EN_PO(n)+1:ST_PO(n+1)-1)=0;

[b1 n1]=min(abs(TANLG(ST_PO)-TBCOD(n))); 

if TANLG(ST_PO(n1))<TANLG(EN_PO(end))
EN=EN_PO(TANLG(EN_PO)>TANLG(ST_PO(n1)));

en_p=EN(1);
%EN_PO(TANLG(EN_PO)>(TANLG(ST_PO(n1))+0.1) & TANLG(EN_PO)<(TANLG(ST_PO(n1))+0.7));

tdiff=[];
bdiff=[];

if (numel(en_p)>0)
if (b1<0.2)

    if n1<numel(ST_PO)
    BIT_C(ST_PO(n1):en_p(1))=BCODE(n);
    BIT_C(en_p(1)+1:ST_PO(n1+1)-1)=0;
    else
    BIT_C(ST_PO(n1):en_p(1))=BCODE(n);
    BIT_C(en_p(1)+1:end)=0;
    end
    tdiff(n)=TBCOD(n)-TANLG(ST_PO(n1));
    bdiff(n)=BIT_C(ST_PO(n1)+10)-BCODE(n);

else
    if n1<numel(ST_PO)
BIT_C(ST_PO(n1):en_p(1))=0;
BIT_C(en_p(1)+1:ST_PO(n1+1)-1)=0;
    else
BIT_C(ST_PO(n1):en_p(1))=0;
BIT_C(en_p(1)+1:end)=0;
    end
outlier=outlier+1;
end

else
    n_er=n_er+1;
end

% end
end
end

% BIT_C(EN_PO(n)+1:end)=0;
% figure;plot(TANLG,YANLG);
% hold on;plot(TANLG,BIT_C,'r');
% hold on;plot(TBCOD,BCODE);

BCODE1=[BCODE1 BIT_C];
TBCOD1=[TBCOD1 TANLG];

BCODE=BCODE1;
TBCOD=TBCOD1;

% pause

figure(11);
hold on
plot(TBCOD(1:end),BCODE(1:end),'b')
% xlim([3500 3510])

figure(12);
plot(TANLG(TANLG>400 & TANLG<402),YANLG(TANLG>400 & TANLG<402))

figure(13);
subplot(2,2,1)
boxplot(tdiff)
ylabel('\Delta t')
subplot(2,2,2)
hist(tdiff,10)
ylabel('\Delta t hist')
subplot(2,2,3)
boxplot(bdiff)
ylabel('\delta bit')
subplot(2,2,4)
hist(bdiff,10)
ylabel('\Delta bit hist')
hold on
xlabel([' # corrected bitcodes= ',num2str(outlier),' ,# of er bits= ',num2str(n_er)])

BCODE2=BCODE;
rrs=find(BCODE~=0);
MAA=max(BCODE);

% if numel(BLOCK_NUM_SET)==1'y';% 
%reply_S =input('Is Stimulus OK (check both figures 11, 12 & 13)? y/n [y]: ', 's');
% else
 reply_S='y';    
% end

if isempty(reply_S)
    reply_S = 'y';
end

% if reply_S=='y'
for i=1:32
Yeneu{i}=[];
Teneu{i}=[];
TIMES{i}=[];
pYeneu{i}=[];
pTeneu{i}=[];
pTIMES{i}=[];
end

for channel=1:32

clearvars -except Yeneu Teneu TIMES pYeneu pTeneu pTIMES BLOCK_NUM BLOCK_NUM_SET TIME_S TIME_E PER sub_block M SPIKES ss channel BCODE TBCOD TIME_CU BLOCK_NUM FOLDER_FROM FILE_TO FOLDER_TO BLOCK_NUM_SET sub_block TEND EN_PO ST_PO

channel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ch=channel;
for PE=1:PER
[Yeneu1 Teneu1 TIMES1]=plotchan2(FOLDER_FROM,['Block-',num2str(BLOCK_NUM)],'eNeu',Ch,TIME_S(PE),TIME_E(PE),0);
% if (isempty(Yeneu1) | isempty(Teneu1) | isempty(TIMES1))
%     error('long loading, per favore read shorter portion')
% end
Yeneu{Ch}=[Yeneu{Ch} Yeneu1];
Teneu{Ch}=[Teneu{Ch} Teneu1];
TIMES{Ch}=[TIMES{Ch} TIMES1];
end

for PE=1:PER
[pYeneu1 pTeneu1 pTIMES1]=plotchan2(FOLDER_FROM,['Block-',num2str(BLOCK_NUM)],'pNeu',Ch,TIME_S(PE),TIME_E(PE),0);
% if (isempty(pYeneu1) | isempty(pTeneu1) | isempty(pTIMES1))
%     error('long loading, read shorter portion')
% end
pYeneu{Ch}=[pYeneu{Ch} pYeneu1];
pTeneu{Ch}=[pTeneu{Ch} pTeneu1];
pTIMES{Ch}=[pTIMES{Ch} pTIMES1];
end

end
% clearvars -except SPIKES BCODE TBCOD FOLDER_TO M sub_block BLOCK_NUM
F11=figure(11);
F12=figure(12);
F13=figure(13);
save([FOLDER_TO '\MATLAB_DATA.mat'],'-v7.3')
saveas(F11,[FOLDER_TO '\BitCode.png'],'png')
saveas(F12,[FOLDER_TO '\AnalogWave.png'],'png')
saveas(F13,[FOLDER_TO '\error.png'],'png')
end
