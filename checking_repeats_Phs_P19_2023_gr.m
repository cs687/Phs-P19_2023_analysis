function checking_repeats_Phs_P19_2023
%Function to compare the mean expression of the repeats
%
data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
data_path={[data_main_path,'2023-03-08'],...
           [data_main_path,'2023-03-30'],...
           [data_main_path,'2023-04-05']};

conditions_names={'JLB259_0uM',...
                  'JLB259_2uM',...
                  'JLB259_3uM',...
                  'JLB259_4uM',...
                  'JLB259_5uM',...
                  'JLB259_6uM',...
                  'JLB259_7uM',...
                  'JLB259_8uM',...
                  'JLB259_9uM',...
                  'JLB259_10uM',...
                  'JLB259_11uM',...
                  'JLB259_12uM',...
                  };
% color_cond={'r','b','k'};
% figure;  
% for dp=1:length(data_path)
%     for cn=1:length(conditions_names)
% % for dp=1
% %     for cn=5:12
%          try load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'elong_rate');
% %            load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'elong_rate');
%             subplot(6,2,cn);
%             hold on;
%             elong_rate(elong_rate>2|elong_rate<0)=nan;
%             plot(nanmean(elong_rate,2),color_cond{dp});
%         catch
%          end 
%     end
% end
% 
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



%Comparing Growth rates per experiment
figure;
color_map={'k','r','r--','m','b','c','y','g','g--','g-.-'};
legend_names=cellfun(@(a) a(8:end),conditions_names,'UniformOutput',false);
t_name={'2023-03-08','2023-03-30','2023-04-05'};

for dp=1:length(data_path)
    subplot(3,1,dp);
    ind=1;
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
         try load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'elong_rate');
%            load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'elong_rate');
            hold on;
            elong_rate(elong_rate>2|elong_rate<0)=nan;
            plot(nanmean(elong_rate,2),color_map{ind});
            ind=ind+1;
        catch
         end 
    end
    if dp==1
        legend(legend_names(3:end));
    else
        legend(legend_names(1:10));
    end
    title(t_name{dp})
end

 