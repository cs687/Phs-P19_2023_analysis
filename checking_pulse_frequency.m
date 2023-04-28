function [loc_all,prom_all]=checking_pulse_frequency

%figure;
%for i=2:length(to_do);
data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
data_path={[data_main_path,'2023-03-30','\subAuto\Data\'],...
           [data_main_path,'2023-04-05','\subAuto\Data\'],...
             [data_main_path,'2023-04-14','\subAuto\Data\'],...
             [data_main_path,'2023-04-21','\subAuto\Data\']};
t_name={'2023-03-30','2023-04-05','2023-04-14','2023-04-21'};


%Default parameters
% numlags=500;
% numstd=3;
% cond=1:8;
plot_now=2;
do_plot=0;
plot_color=1;
do_auto=0;
L=576;
%L=721;
% L=613;
%L=757;
lag=1;
name={'0 uM IPTG','2uM IPTG','3uM IPTG','4uM IPTG','5 uM IPTG','6 uM IPTG','7 uM IPTG','8 uM IPTG','9 uM IPTG','10 uM IPTG'};
iptg=[0,2,3,4,5,6,7,8,9,10];
on_colors_all={'w','y','g','c'};
class_cell=zeros(4,length(iptg),length(data_path));
class_cell_num={};


loc_all=cell(4,1);
prom_all=cell(4,1);
m_all=cell(4,1);

for tt=1:length(data_path)
    kk=0;
    do_now_cond=1:length(iptg);
    %for i=flip(do_now_cond);
    for i=[4,5,6];
        kk=kk+1;
        %load data
        %figure;
        D=dir([data_path{tt},'*',num2str(iptg(i)),'uM*.mat']);
        if ~isempty(D)
            load([data_path{tt},D(1).name]);

            %Filtering out traces which make it to the last frarme L
%             MY(MY==0)=nan;
%             if i==10;
%                 half_max=nanmean(nanmean(MY))/2;
%             end
            good_cand=~isnan(MY(L,:));
            MY_long=MY(1:L,good_cand);
            
            %plotting single cell traces and their classification
            if do_plot==1
                figure;
                if size(MY_long,2)<25
                    do_now=size(MY_long,2);
                else
                    do_now=25;
                end
            else
                do_now=size(MY_long,2);
                norm=do_now;
            end
            
            %Looping of good single cell traces and classifing them 
            loc_now=[];
            prom_now=[];
            m_now=[];
            for trace=1:do_now
%                 if do_plot==1
%                     subplot(5,5,trace);
%                 end
                %smoothing raw data and find peaks
                data=smoothdata(MY_long(lag:L,trace)-200,'gaussian',10);
                [m,loc,~,p]=findpeaks(data,'MinPeakProminence',200,'Annotate','extents');
                loc_now=[loc_now;loc];
                prom_now=[prom_now;m-p];
                m_now=[m_now;m];
            end
            loc_all{tt}{kk}=loc_now;
            prom_all{tt}{kk}=prom_now;
            m_all{tt}{kk}=m_now;
        end
    end
end

figure;
ind=0;
for i=1:4
    for j=1:3
        ind=ind+1;
        a=histcounts(loc_all{i}{j},[0:10:600]);
        subplot(4,3,ind);
        bar([5:10:600],a);
        title([t_name{i},' ', name{j+3}]);
        if mod(ind,3)==1
            ylabel('Counts');
        elseif ind>9
            xlabel('Frames');
        end
        
    end
end

% figure;
% ind=0;
% for i=1:4
%     for j=1:3
%         ind=ind+1;
%         a=histcounts(loc_all{i}{j}(prom_all{i}{j}<2500),[0:10:600]);
%         subplot(4,3,ind);
%         bar([5:10:600],a);
%         title([t_name{i},' ', name{j+3}]);
%         if mod(ind,3)==1
%             ylabel('Counts');
%         elseif ind>9
%             xlabel('Frames');
%         end
%         
%     end
% end

%Checking for dampening
ind=0;
figure;
for i=1:4
    for j=1:3
        ind=ind+1;
        bin_ind=0;
        for bin=[10:10:600];
            bin_ind=bin_ind+1;
            m_now=m_all{i}{j}(loc_all{i}{j}<=bin&loc_all{i}{j}>bin-10);
            m_plot(bin_ind)=mean(m_now);
        end
        subplot(4,3,ind);
        bar([5:10:600],m_plot);
        title([t_name{i},' ', name{j+3}]);
        if mod(ind,3)==1
            ylabel('Mean Pulse Mag [au]');
        elseif ind>9
            xlabel('Frames');
        end
        
    end
end


% figure;
% for i=1:size(class_cell,3)
%     subplot(2,2,i);
%     plot([iptg;iptg;iptg;iptg]',class_cell(:,:,i)');
%     xlabel('IPTG (uM)');
%     ylabel('Fraction (au)');
%     legend({'OFF','Pulsing','Oscillation','ON'});
%     t_name_pos=strfind(data_path{i},'20');
%     title(data_path{i}(t_name_pos:t_name_pos+9));
% end
% 
% 
% figure;
%  plot(mean(class_cell,3));
%  errorbar([iptg;iptg;iptg;iptg]',nanmean(class_cell,3)',nanstd(class_cell,0,3)');
%  xlabel('IPTG (uM)');
%  ylabel('Fraction (au)');
%  legend({'OFF','Pulsing','Oscillation','ON'});