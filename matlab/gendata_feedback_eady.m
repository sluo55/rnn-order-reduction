clear;

% generate SISO
gen_feedback_data_eady(100, true);
seq_id = randi(100);
load eady_fb_siso
x = xs{seq_id}; 
comp_id = randi(size(x,2));
plot(x(:,comp_id))

% generate MIMO
gen_feedback_data_eady(100, false);
figure(2)
load eady_fb_mimo
x = xs{seq_id}; 
comp_id = randi(size(x,2));
plot(x(:,comp_id))

