function varargout = shoulderror(varargin)
% shoulderror  Throws an error if input executes successfully. Useful for test
% scripts.
% 
%   Inputs and outputs are the same as for feval or, if only one char or string
%   input is provided, evalin('caller',...).
% 
%   shoulderror returns the MException object if the error is thrown, though use
%   caution regarding the input's expectations regarding number of outputs.
% 
%   shoulderror(ID,...), where the first argument is any character vector or
%   string scalar containing a colon character, also verifies that the
%   MException identifier of the error thrown matches ID.
% 
%   Examples:
%     shoulderror(@cos,"pi") % Executes without error, returning MException.
%     shoulderror('MATLAB:UndefinedFunction',@cos,"pi") % Checks error ID.
%     shoulderror('mrdivide',1,3) % Errors.
%     a = shoulderror('1 + 1') % Errors; a is not assigned.
%     
%     Be careful with number of expected outputs. These yield different results:
%               shoulderror('MATLAB:deal:narginNargoutMismatch',@deal,1,2) 
%       [~,~] = shoulderror('MATLAB:deal:narginNargoutMismatch',@deal,1,2)
% 
%   See also shouldalert, shouldwarn, runtests, feval, MException.

% Copyright 2018 Sky Sartorius. All rights reserved.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 

ID = varargin{1};
testID = false;
if nargin > 1 ...
        && (ischar(ID) || isStringScalar(ID)) ...
        && ~isempty(regexp(ID,'\w+:\w+','once'))
    varargin = varargin(2:end);
    testID = true;
end
nArgs = numel(varargin);

errored = false;
try 
    if nArgs == 1 && (ischar(varargin{1}) || isstring(varargin{1}))
        [varargout{1:nargout}] = evalin('caller',varargin{1}); %#ok<*NASGU>
    else
        [varargout{1:nargout}] = feval(varargin{:});
    end
catch ME
    % Good, it should have thrown an error.
    varargout = [{ME} cell(1,nargout-1)];
    errored = true;
    if testID && ~strcmp(ME.identifier,ID)
        error('AlertChecking:ShouldError:IncorrectIdentifier',...
            'This should have thrown an error with identifier:\n%s',ID);
    end
end

if ~errored
    error('AlertChecking:ShouldError','This should have thrown an error.')
end

end
