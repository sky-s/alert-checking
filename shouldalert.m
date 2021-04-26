function varargout = shouldalert(varargin)
% shouldalert  Throws an error if input executes successfully without warnings
% or errors. Useful for test scripts.
% 
%   Inputs and outputs are the same as for feval or, if only one char or string
%   input is provided, evalin('caller',...).
% 
%   Use caution regarding the input's expectations regarding number of outputs.
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
warned = false;
errored = false;

try
    if nargin == 1 && (ischar(varargin{1}) || isstring(varargin{1}))
        [varargout{1:nargout}] = evalin('caller',varargin{1}); %#ok<*NASGU>
    else
        [varargout{1:nargout}] = feval(varargin{:});
    end
    
catch ME
    errored = true;
end

warning(state) % Reset warning state.

[msg,warnID] = lastwarn;
if ~(isempty(msg) && isempty(warnID))
    % Warning was issued.
    warned = true;
end

if ~warned && ~errored
    error('AlertChecking:ShouldAlert','This should have thrown an alert.')
end

