% Author: Ardi Tampuu, University Of Tartu
%
% Session: Networks of Neurons
% Exerise on Integrate and Fire with synapses
% Synaptic currents adopted from http://math.bu.edu/people/mak/MA665 course materials
%
%
%

%%%%%%%%%%%%%%%%

clear all

T = 2; %duration of simulation in sec
dt=0.001;
number_of_steps = T/dt;
n_neurons = 15;

%Neuron Parameters
%----------
I_const = [25.0 25.0 25.0 50.0 50.0 50.0 50.0 50.0 50.0 50.0 50.0 50.0 25.0 25.0 25.0]*1.5; 
params.C = 0.1; % capacity
params.R = 1; % resistance
params.spike_strength = -50.0;
params.taus = ones(n_neurons,1)*20; 

Vr =  -75.0; % reset potential in mV
V0 = -70.0; % resting potential in mV



tc = -100000; 
th = -55.0; %the neuron threshold
noise = 10.0;



last_spike = ones(n_neurons,1)*(-100);

connectivity = zeros(15);
connectivity(1:14,2:15) += eye(14);
connectivity(2:15,1:14) += eye(14);
%connectivity(1:13,3:15) += eye(13);
%connectivity(3:15,1:13) += eye(13);

connectivity(1,15)=1;
connectivity(15,1)=1;
%connectivity(1,14)=1;
%connectivity(14,1)=1;
%connectivity(2,15)=1;
%connectivity(15,2)=1;

disp(connectivity) %TODO what does this connectivity mean?


spikes = zeros(T/dt,n_neurons);
Vm = zeros(T/dt,n_neurons);
Vm(1,:) = ones(n_neurons,1)*V0 + randn(n_neurons,1)*3;
disp("Initial membrane potential of neurons are..")
disp(Vm(1,:)')


for i=2:(number_of_steps-1)
   for n=1:n_neurons
        if(Vm(i-1,n) >= th)   %generate spike
          %disp("generated spike");
          last_spike(n) = i-1 ;%synaptic currents want to know the last output spike time		  
          Vm(i-1,n) = Vr;
          spikes(i-1,n) = 1;
	end
   end
   
   for n=1:n_neurons
      neighbours = find(connectivity(n,:)==1);
      incoming_spikes=[];
      for ngh=neighbours
        incoming_spikes = [incoming_spikes ; find(spikes(1:i,ngh)==1)]; #find past timepoints where there was spikes in the neighbour
      end
      
      seps = synaptic_input(n, incoming_spikes, i , last_spike(n), params);

      I_syn = params.spike_strength * 1/(1-params.taus(n)/(params.R*params.C))*seps; 
      I_noise = noise*sqrt(dt)*randn;
      I_injected = dt*I_const(n)/params.C;
      I_leak = dt*(V0 - Vm(i-1,n))/(params.R*params.C);

      Vm(i,n) = Vm(i-1,n) + I_leak + I_injected + I_syn + I_noise;
   end 	

end 

disp(sum(spikes, axis=1))

plot(sum(spikes, axis=1))
xlim([0.9,15.1])
xlabel('Number of neruon');
ylabel('Spike Count')  
