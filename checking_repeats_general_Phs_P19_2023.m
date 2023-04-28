function checking_repeats_general_Phs_P19_2023(what);
%Function to compare the mean expression of the repeats
repeat_name={'2023-03-08','2023-03-30','2023-04-05','2023-04-14','2023-04-21'};

data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';

%making path
for i=1:length(repeat_name)
    data_path{i}=[data_main_path,repeat_name{i}];
end

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
 color_cond={'r','b','k','m','g','c'};
figure;  
good_one=zeros(length(conditions_names),1);
for dp=1:length(data_path)
%for dp=4;
    for cn=1:length(conditions_names)
% for dp=1
%     for cn=5:12
         if exist([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat']);
             load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat']);
             eval(['do_now=',what,';']);
             if strcmp(what,'elong_rate');
                 do_now(do_now>1|do_now<0)=nan;
             end
             subplot(6,2,cn);
             hold on;
             plot(nanmean(do_now,2),color_cond{dp},'Linewidth',2);
             good_one(cn)=good_one(cn)+1;
         else
             disp(['Does not exist: ', data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat']);
         end
           
    end
end

f=find(good_one==length(data_path));
%Making figure pretty
for cn=1:length(conditions_names)
    %plotting legend for last subplot
    subplot(6,2,cn);
    if cn==f(1)
        legend(repeat_name);
    end
    hold on;
    title(conditions_names{cn}(8:end));
    box on;
    xlabel('Frames');
    ylabel(what);
    set(gca, 'Linewidth',2,'FontWeight','bold')
end
screensize = get( groot, 'Screensize' );
set(gcf,'position',screensize);
saveas(gcf,[data_main_path,'Figures\',what,'.png']);