[![View Alert Checking on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/90022-alert-checking)

# Alert Checking

Check Matlab code that is supposed to throw errors or warnings.


Sometimes when testing code, it is desirable to not only make sure that the code executes correctly when it should, but also to check that it throws errors or warning when expected. These simple utilities make it easy to test if the expected alerting behavior takes place. 

## Contents
-	`shoulderror` throws an error if the code executes successfully _without_ error.
-	`shouldwarn` throws an error if the code executes _without_ warning.
-	`shouldalert` throws an error if the code executes without either an error or warning.
