function varargout = shoulderror(varargin)
% shoulderror  Throws an error if input executes successfully. Useful for test
% scripts.
% 
%   Inputs are same as for feval, unless only one char or string input is
%   provided, in which case eval is used.
% 
%   shoulderror returns the MException object if the error is thrown, otherwise
%   function outputs are returned.
% 
%   See also shouldalert, shouldwarn, runtests, feval, MException.

% Copyright 2018 Sky Sartorius. All rights reserved.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 

try 
    if nargin == 1 && (ischar(varargin{1}) || isstring(varargin{1}))
        [varargout{1:nargout}] = eval(varargin{1}); %#ok<*NASGU>
    else
        [varargout{1:nargout}] = feval(varargin{:});
    end
catch ME
    % Good, it should have thrown an error.
    varargout = [{ME} cell(1,nargout-1)];
    return
end
error('AlertChecking:ShouldError','This should have thrown an error.')

end
