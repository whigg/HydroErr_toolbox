function ret_value = mb_r( sim, obs, remove_zero, remove_neg )
% Calculates the Mielke-Berry R ((MB) R) for simulated and 
% observed data.
%   metric = mb_r(sim, obs) Calculates the (MB) R error metric between the
%   simulated and observed data.
%
%   metric = mb_r(sim, obs, remove_zero, remove_neg) Calculates the (MB) R 
%   error metric between the simulated and observed data. The remove_zero
%   and remove_neg values are booleans and will remove zero and negative
%   values from the the i-th position in both the simulated and observed
%   array if found.
% 
%   See https://waderoberts123.github.io/Hydrostats/ for a more complete
%   description of this metric.
% 
%   Brigham Young University Civil & Environmental Engineering

switch nargin
    case 2
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the (MB) R
        [m, n] = size(obs);
        z = max(m, n);
        total = 0;
        
        for i =1:1:z
            for j = 1:1:z
               total = total + abs(sim(j)-obs(i));
            end
        end
        
        MAE = mean(abs(sim - obs));

        ret_value = 1-MAE*z^2/total;
    
    case 4
        % Check if remove_nan and remove_zero are booleans
        if (remove_zero ~= 0) && (remove_zero ~= 1)
            error('The remove_zero variable is a boolean.')
        end
        
        if (remove_neg ~= 0) && (remove_neg ~= 1)
            error('The remove_neg variable is a boolean.')
        end
        
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        [sim, obs] = remove_zero_neg(sim, obs, remove_zero, remove_neg);
        
        % Computing the (MB) R
        [m, n] = size(obs);
        z = max(m, n);
        total = 0;
        
        for i =1:1:z
            for j = 1:1:z
               total = total + abs(sim(j)-obs(i));
            end
        end
        
        MAE = mean(abs(sim - obs));

        ret_value = 1-MAE*z^2/total;
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end