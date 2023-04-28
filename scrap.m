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