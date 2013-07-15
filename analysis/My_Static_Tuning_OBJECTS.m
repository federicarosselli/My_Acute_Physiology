 %% Static Tuning

for ob = object
    
    
        COLORSET=varycolor(numel(object));
        contami = contami+1;
        if ob == 0
                stimidentity = 'BBlank';
            elseif ob == 9
                stimidentity = 'WBlank';
            elseif ob == -1
                stimidentity = 'Bars';
            elseif ob == 1 || ob==2 || ob==3 || ob==4
                stimidentity = 'Objects';
            elseif ob == 111 || ob==222 || ob==333 || ob==444
                stimidentity = 'Gratings';
            elseif ob == 11 || ob==22
                stimidentity = 'Dots';
        end
            
            ww = cd;
            stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
            mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,12)==0.250000000000000));       
        selected_bits = a';       
        static_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
        for z = 1:numel(static_set)  
            
        I=motion_set(z);
        stim = selected_bits(z);
        sp_tr=[];

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            TUN.Static.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Static.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Static.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb(find(static_set==I))=TUN.Static.Me{nn}(z);
                sss(find(static_set==I))=TUN.Static.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 6 for FastMoving bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Static.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Static.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Static.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_set==I)+1)=TUN_Bl.Static.Me{nn};
                sss(find(motion_set==I)+1)=TUN_Bl.Static.Se{nn};

                h(nn)=figure(nn)
                
        
                
                
       %% plot    

%             subplot(2,1,1) 
            %figure(objs)
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            xlabel(['Static Tuning'])
            Y=[];
            for iu=1:numel(static_set)
                Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
            end
            h = area(static_set,Y,-5); % Set BaseValue via argument
            set(h(1),'FaceColor',[.5 0.5 0.5])
            set(h(2),'FaceColor',[.5 0.5 0.5])
            set(h(3),'FaceColor',[.5 0.5 0.5])
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb(end)-sss(end)/2)
            hold on
            line([static_set(1) static_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
            hold on
            her{ob}=errorbar(static_set,bbb(1:numel(static_set))',sss(1:numel(static_set))','-O','color',COLORSET(contami,:)) %,)
            xlim([static_set(1)-3 static_set(end)+3])
            set(gca, 'XTick', [static_set])
           
            
        
end
            legend([her{1},her{2},her{3},her{4}],{'Ent','Bunny','Orca','Pingu'})
 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/stT_', char(stimidentity),'.png']) 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/stT_', char(stimidentity),'.fig'])  
            close 