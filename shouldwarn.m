function varargout = shouldwarn(varargin)
% shouldwarn  Throws an error if input executes without warning (whether or not
% execution is successful). Useful for test scripts.
% 
%   Inputs and outputs are the same as for feval or, if only one char or string
%   input is provided, evalin('caller',...).
% 
%   Use caution regarding the input's expectations regarding number of outputs.
% 
%   See also shouldalert, shoulderror, runtests, feval, MException.

% Copyright 2018 Sky Sartorius. All rights reserved.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 


% Reset warnings
lastwarn('','');

% Cache warning state before turning off.
state = warning('query').state;

% Temporarily turn off all warnings
warning off

% Run code
try %#ok<TRYNC>
    if nargin == 1 && (ischar(varargin{1}) || isstring(varargin{1}))
        [varargout{1:nargout}] = evalin('caller',varargin{1});
    else
        [varargout{1:nargout}] = feval(varargin{:});
    end
end
% Reset warning state.
warning(state)

% Get last warning.
[msg,warnID] = lastwarn;
if isempty(msg) && isempty(warnID)
    % No warning was thrown.
    error('AlertChecking:ShouldWarn','This should have thrown a warning.')
end
