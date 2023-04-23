function checking_repeats_Phs_P19_2023
%Function to compare the mean expression of the repeats
%
data_path={'\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\not_so_go_oscillations\2022-06-29\subAuto\Data\'};


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
for dp=1:length(data_path)
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
         try load([data_path{dp},conditions_names{cn},'.mat']);
%            load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'elong_rate');
            subplot(4,2,cn);
            hold on;
            elong_rate(elong_rate>2|elong_rate<0)=nan;
            plot(nanmean(elong_rate,2),color_cond{dp},'Linewidth',2);
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
    xlabel('Frames')
    ylabel('GR');
    box on;
    set(gca, 'Linewidth',2,'FontWeight','bold')
end



%Comparing Growth rates per experiment
figure;
color_map={'k','r','r','m','b','c','y','g','g--','g-.-'};
legend_names=cellfun(@(a) a(8:end),conditions_names,'UniformOutput',false);
%t_name={'2023-03-08','2023-03-30','2023-04-05'};
t_name={'0 uM','2 uM','3 uM','4 uM','5 uM','6 uM','7 uM','8 uM'};

for dp=1
    %subplot(3,1,dp);
    ind=1;
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
         try load([data_path{dp},conditions_names{cn},'.mat'],'elong_rate');
%            load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'elong_rate');
            hold on;
            elong_rate(elong_rate>2|elong_rate<0)=nan;
            plot(nanmean(elong_rate,2),color_map{ind},'Linewidth',2);
            ind=ind+1;
        catch
         end 
    end
        legend(t_name);
        xlabel('Frames');
        ylabel('GR');
        box on;
        set(gca, 'Linewidth',2,'FontWeight','bold')
    end
end

 