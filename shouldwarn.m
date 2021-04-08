function varargout = shouldwarn(varargin)
% shouldwarn  Throws an error if input executes without warning. Useful for test
% scripts.
% 
%   Inputs are same as for feval, unless only one char or string input is
%   provided, in which case eval is used.
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
        [varargout{1:nargout}] = eval(varargin{1});
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
    error('This should have thrown a warning.')
end


