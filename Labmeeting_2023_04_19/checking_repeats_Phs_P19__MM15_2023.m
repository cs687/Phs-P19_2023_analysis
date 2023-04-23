function checking_repeats_Phs_P19_2023
%Function to compare the mean expression of the repeats
%
% data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
% data_path={[data_main_path,'2023-03-08'],...
%            [data_main_path,'2023-03-30'],...
%            [data_main_path,'2023-04-05']};
data_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\not_so_go_oscillations\2022-06-29\subAuto\Data\';


conditions_names={'JLB263-2_0uM_IPTG',...
                  'JLB263-2_2uM_IPTG',...
                  'JLB263-2_3uM_IPTG',...
                  'JLB263-2_4uM_IPTG',...
                  'JLB263-2_5uM_IPTG',...
                  'JLB263-2_6uM_IPTG',...
                  'JLB263-2_7uM_IPTG',...
                  'JLB263-2_8uM_IPTG',...
                  };
color_cond={'r','b','k'};
figure;  
for dp=1
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
         try load([data_path,conditions_names{cn},'.mat'],'MY');
%            load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
            subplot(4,2,cn);
            hold on;
            plot(nanmean(MY,2),color_cond{dp},'Linewidth',2);
            
        catch
         end 
    end
end

%Making figure pretty
for cn=1:length(conditions_names)
    %plotting legend for last subplot
    if cn==10
        legend({'2023-03-08','2023-03-30','2023-03-04'});
    end
    subplot(4,2,cn);
    hold on;
    title(conditions_names{cn}(8:end));
    box on;
    xlabel('Frames');
    ylabel('MY');
    set(gca, 'Linewidth',2,'FontWeight','bold')
end

 