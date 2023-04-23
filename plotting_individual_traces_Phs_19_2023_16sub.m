function plotting_individual_traces_Phs_19_2023
data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
% data_path={[data_main_path,'2023-03-08'],...
%            [data_main_path,'2023-03-30'],...
%            [data_main_path,'2023-04-05']};

%data_path={[data_main_path,'2023-03-30']};
data_path={[data_main_path,'2023-04-05']};

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
max_y=[300,300,300,2000,4000,6000,6000,6000,6000,10000,10000,10000];
figure; 
for dp=1:length(data_path)
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
        try load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat']);
%             load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
            len=size(MY,2);
            len=randperm(len);
            if length(len)<25
                do_now=1:length(len);
            else
                do_now=len(1:25);
            end
            figure;
            ind=1;
            for i=do_now
                subplot(5,5,ind);
                plot(AYlen(:,i),'Linewidth',2);
                xlim([0,721])
                %ylim([0,max_y(cn)]);
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
            sgtitle(strrep(conditions_names{cn},'_',' '));
            
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
