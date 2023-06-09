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
color_cond={'r','b','k'};
figure;  
for dp=1:length(data_path)
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
         try load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
%            load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
            subplot(6,2,cn);
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
    subplot(6,2,cn);
    hold on;
    title(conditions_names{cn}(8:end));
    box on;
    xlabel('Frames');
    ylabel('MY');
    set(gca, 'Linewidth',2,'FontWeight','bold')
end

 