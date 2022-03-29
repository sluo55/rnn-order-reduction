% Generate data from eady matrices (B'=C) with system 
% [z;x]'=[A, BT;B' 0][z;x], z(0)=0, x(0)=x0. T=-I.
function gen_feedback_data_eady(N, SISO)
% N: positive integer, number of samples
% mx: positive float, max magnitude of initial value
% SISO: boolean, whether siso or mimo
    if SISO
        load eady.mat
        %load eady_siso_sym.mat
    else
        %load eady_mimo.mat
        load eady_mimo_sym.mat
    end

    dz = size(A, 1);
    z0 = zeros(dz,1);

    dx = size(B, 2);
    T = -eye(dx);
    M = [A, B*T;C, zeros(dx)];
    odefcn = @(t,y) M*y;
    tspan = 0:0.01:.8;

    fs = cell(1,N);
    xs = cell(1,N);
    for v = 1:N
        cx0 = 2*(rand(dx,1)-0.5);
        [~,y] = ode45(odefcn, tspan, [z0;cx0]);
        fs{v} = y(:,dz+1:end)*T';
        xs{v} = y(:,dz+1:end);
    end
    
    if SISO
        save eady_fb_siso.mat fs xs
    else
        save eady_fb_mimo.mat fs xs
    end
end
