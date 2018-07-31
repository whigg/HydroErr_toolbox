function ret_value = mean_var( sim, obs, remove_zero, remove_neg )
% Calculates the Mean Variance (MV) for simulated and 
% observed data.
%   metric = mean_var(sim, obs) Calculates the MV error metric between the
%   simulated and observed data.
%
%   metric = mean_var(sim, obs, remove_zero, remove_neg) Calculates the MV 
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
        
        % Computing the MV
        ret_value = var(log1p(obs) - log1p(sim));
    
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
        
        % Computing the MV
        ret_value = var(log1p(obs) - log1p(sim));
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end