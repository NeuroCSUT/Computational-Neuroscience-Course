% Author: Ardi Tampuu, University Of Tartu
%
% Session: Single Neuron Models
% Leaky Integrate and Fire 
%
%



%%%%%%%%%%%%%%%%

clear all
clf

T = 4; % duration of the whole simulation in sec
dt=0.001;
number_of_steps = T/dt


%Neuron Parameters
%----------
I_const = 3.0; % the strength current we inject to the cell, only lasts 3 seconds of 4 (if clause inside the loop below)
               %%% TODO %%% Find the lowest possible current that would lead to at east one spike
C = 0.1; % capacity
R = 5; % resistance

Vr =  -75.0; % reset potential in mV - after a spike the neuron resets below its resting potential - its called hyperpolarization
V0 = -70.0; % resting potential in mV
th = -55.0; %the neuron threshold
Vm(1) = V0;

number_of_spikes = 0; 

for i=1:(number_of_steps-1)	
        if(Vm(i) >= th)   %generate spike
          Vm(i) = Vr;
          number_of_spikes += 1; %%% TODO 5 %%% (replace the 0) add 1 to number_of_spikes every
	end
        %c_leak = dt*(V0-Vm(i))/(R*C); % the current that results from ion pumps trying to take the neuron back to normal 
        %c_injected = dt*I_const/C;
        if i<3000
          Vm(i+1) = Vm(i) + dt*(V0 - Vm(i))/(R*C) + (dt*I_const/C);
        else % the input stops at t=3000ms
          Vm(i+1) = Vm(i) + dt*(V0 - Vm(i))/(R*C);
        end
end 

disp(sprintf("Number of spikes is %d",number_of_spikes))

%plot membrane potential vs time
t = (1:length(Vm))*dt;
plot(t, Vm);
ylim([-80.0,-50.0])

xlabel('time [ms]');
ylabel('Vm(t)  [mV]')   

