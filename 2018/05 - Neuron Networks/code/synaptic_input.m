function [seps] = synaptic_input(n,input_spikes,t, last_spike, params)
  seps = 0;
  for j=1:length(input_spikes);
      eps = 0;
      if (last_spike <= input_spikes(j) && input_spikes(j) <= t) % if time > this spike => last_output %%the last output was long time ago
        eps = exp(-(t -input_spikes(j))/(params.R*params.C)) - exp(-(t-input_spikes(j))/params.taus(n));
      end
	
      if (input_spikes(j) < last_spike && last_spike <= t) %if time > last_output > this_spike %%%there has been an output after our input%%% 
          eps = exp(-(last_spike-input_spikes(j))/params.taus(n))*(exp(-(t-last_spike)/(params.R*params.C)) - exp(-(t-last_spike)/params.taus(n)));
      end
      seps = seps + eps; %current from spikes
  end
end
