# nebular algorighm

The code contained in the two folders are implemenations of the nebular algorithm for target coverage developed by Chris Thron and Jordan Barry. The two implementations are similar except for a few key differences they are 

## chris_thron

- uses structures to organize data
- different function calls
- additional function 'mayMerge'

The MATLAB scripts 'testScriptEurope.m', 'testScriptPlot.m', 'testScriptRand.m', 'testScriptUshams.m', and 'testScriptv3.m' all contain testing and benchmarking scripts for the algorithm. The file 'sensorFunctionCTa.m' is the main function for the algorithm; the rest of the functions are subroutines and helper functions. Comments withn the code should make usage known.



## jordan_barry

- uses classes to organize data, as well as constructor 
- covered target list stored as an NxN sparse matrix

The MATLAB scripts 'testScriptComparison.m', 'testScriptEurope.m', 'testScriptPlot.m', 'testScriptRand.m', 'testScriptUshams.m', and 'testScriptv1.m' all contain testing and benchmarking scripts for the algorithm. The file 'sensorFunction.m' is the main function for the algorithm; the rest of the functions are subroutines and helper functions. Comments withn the code should make usage known.

Please submit bug reports and submit pull requests.
