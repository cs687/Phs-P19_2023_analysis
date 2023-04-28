function plotting_individual_traces_Phs_19_2023
data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
% data_path={[data_main_path,'2023-03-08'],...
%            [data_main_path,'2023-03-30'],...
%            [data_main_path,'2023-04-05']};

%data_path={[data_main_path,'2023-03-08']};
%data_path={[data_main_path,'2023-04-05']};
data_path={[data_main_path,'2023-04-21']};

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
        try load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
%             load([data_path{dp},'\subAuto\Data\',conditions_names{cn},'.mat'],'MY');
            len=size(MY,2);
            len=randperm(len);
            if length(len)<64
                do_now=1:length(len);
            else
                do_now=len(1:64);
            end
            figure;
            ind=1;
            for i=do_now
                subplot(8,8,ind);
                plot(MY(:,i));
                xlim([0,721])
                ylim([0,max_y(cn)]);
                if mod(ind,8)==1
                    ylabel('MY');
                end
                if ind>56
                    xlabel('Frame');
                end
                ind=ind+1;
            end
            sgtitle(strrep(conditions_names{cn},'_',' '));
            import mlreportgen.ppt.*
            in_path='C:\Users\christian.schwall\OneDrive - University Of Cambridge\Labmeeting\Update';
            
            slidesFile = [in_path,'\test.pptx'];
            slides = Presentation(slidesFile);
            contentSlide = add(slides,'Title and Content');
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            saveas(gcf,[in_path,'\test.png']);
            Picture([in_path,'\test.png']);
            pic=Picture([in_path,'\test.png']);
            pic.X='0';
            pic.Y='0';
            %pic.Width='80cm';
            %pic.Height='60cm';
            replace(slides,'Content',pic);

            
        catch
         end 
    end
end

close(slides);
if ispc
    winopen(slidesFile);
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
