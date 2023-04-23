function plotting_individual_traces_Phs_19_2023
%data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
data_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\testing_teresas_strains\2023-04-06\Rough_ana\';
% data_path={[data_main_path,'2023-03-08'],...
%            [data_main_path,'2023-03-30'],...
%            [data_main_path,'2023-04-05']};

%data_path={[data_main_path,'2023-03-30']};
%data_path={[data_main_path,'2023-04-05']};

conditions_names={'JLb293'};
color_cond={'r','b','k'};
%max_y=[300,300,300,2000,4000,6000,6000,6000,6000,10000,10000,10000];
figure; 
for dp=1
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
        try load([data_path,conditions_names{cn},'.mat']);
%             load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
            len=size(MY,2);
%             len=randperm(len);
%             if length(len)<25
%                 do_now=1:length(len);
%             else
%                 do_now=len(1:25);
%             end
            figure;
            ind=1;
            for i=1:25
                subplot(5,5,ind);
                plot(AYlen(:,i),'Linewidth',2);
                xlim([0,150])
                %ylim([0,1500]);
                if mod(ind,5)==1
                    ylabel('MY');
                end
                if ind>20
                    xlabel('Frame');
                end
                ind=ind+1;
                box on;
                set(gca,'Linewidth',2,'Fontweight','bold')
            end
            sgtitle('10xrsiV','Fontweight','bold');
            
        catch
         end 
    end
end

% %Making figure pretty
% for cn=1:length(conditions_names)
%     %plotting legend for last subplot
%     if cn==10
%         legend({'2023-03-08','2023-03-30','2023-03-04'});
%     end
%     subplot(6,2,cn);
%     hold on;
%     title(conditions_names{cn}(8:end));
% end
