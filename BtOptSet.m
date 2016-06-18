function btOpt=btOptSet

addpath D:\Matlab\toolbox\utility
addpath D:\Matlab\toolbox\machineLearning
addpath D:\Matlab\toolbox\sap

btOpt.auDir='shortClip4bt';
btOpt.wingRatio=0.08;		% One-side tolerance for beat position identification via forward/forward search (only for constant tempo)
btOpt.bpmMax=250;
btOpt.bpmMin=50;		% 70
btOpt.trialNum=8;		% No. of trials for beat positions
btOpt.acfMethod=2;		% Method for computing OSC's ACF
btOpt.useDoubleBeatConvert=0;	% Double beat conversion: Convert to double beat if necessary
btOpt.useTripleBeatConvert=1;	% Triple beat conversion: Convert to double beat if necessary
btOpt.peakHeightTol=0.28;	% If two peaks are different by 10% with multiple BPM, small BPM is selected.
btOpt.oscOpt=wave2osc('defaultOpt');	% Options for onset strength curve

