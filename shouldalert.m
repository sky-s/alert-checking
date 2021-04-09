function varargout = shouldalert(varargin)
% shouldalert  Throws an error if input executes successfully without warnings
% or errors. Useful for test scripts.
% 
%   Inputs are same as for feval, unless only one char or string input is
%   provided, in which case eval is used.
% 
%   See also shouldwarn, shoulderror.

% Copyright 2018 Sky Sartorius. All rights reserved.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 


% Reset warnings
lastwarn('','');

% Cache warning state before turning off.
state = warning('query').state;

% Temporarily turn off all warnings
warning off

% Run code
try
    [varargout{1:nargout}] = shoulderror(varargin{:});
catch
    % Failed to error.
    
    warning(state) % Reset warning state.
    
    [msg,warnID] = lastwarn;
    if isempty(msg) && isempty(warnID)
        % Also failed to warn.
        error('AlertChecking:ShouldAlert','This should have thrown an alert.')
    end
    
end

clear varargout

