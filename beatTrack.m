function [cBeat, au, bpm, beatPos]=beatTrack(au)
%beatTrack: Track beat
%
%	Usage:
%		cBeat=beatTrack(au, btOpt)
%
%	Example:
%	%	waveFile='D:\dataSet\beatTracking\mirex06train\train1.wav';
%		waveFile='song01s5.wav';
%		au=myAudioRead(waveFile);
%		btOpt=btOptSet;
%		btOpt.type='constant';		% 'constant' or 'time-varying'
%		cBeat=beatTrack(au, btOpt, showPlot);
%		tempWaveFile=[tempname, '.wav'];
%		tickAdd(au, cBeat, tempWaveFile);
%		dos(['start ', tempWaveFile]);

%	Roger Jang, 20120410

if nargin<2, btOpt=btOptSet; end

if ischar(au), au=myAudioRead(au); end
au.signal=mean(au.signal, 2);	% Stereo ==> Mono
% === Read GT beat positions (if the GT file exists)
if ~isfield(au, 'gtBeat'), au.gtBeat=btGtRead(au.file); end
% === Compute OSC (onset strength curve) 
if ~isfield(au, 'osc'),	au.osc=wave2osc(au, btOpt.oscOpt, 0); end

frame=au.osc.signal;
%frame=frame-mean(frame);
% === Create ACF
if ~isfield(au, 'acf'), au.acf=frame2acf(au.osc.signal, length(au.osc.signal), btOpt.acfMethod); end
timeStep=au.osc.time(2)-au.osc.time(1);
n1=round(60/btOpt.bpmMax/timeStep)+1;
n2=round(60/btOpt.bpmMin/timeStep)+1;
acf2=au.acf;
acf2(1:n1)=-inf;
acf2(n2:end)=-inf;
[maxFirst, bp]=max(acf2);	% First maximum
if btOpt.useDoubleBeatConvert
    factor=2;
    indexCenter=round((bp-1)/factor+1);
    sideSpread=round((indexCenter-1)*0.1);
    left=indexCenter-sideSpread; if left<1; left=1; end
    right=indexCenter+sideSpread; if right>length(au.acf), right=length(au.acf); end
    [maxInRange, bpLocal]=max(acf2(left:right));
    if (maxFirst-maxInRange)/maxFirst<btOpt.peakHeightTol
        bp=bpLocal+left-1;
    end
end
if btOpt.useTripleBeatConvert
    factor=3;
    indexCenter=round((bp-1)/factor+1);
    sideSpread=round((indexCenter-1)*0.1);
    left=indexCenter-sideSpread; if left<1; left=1; end
    right=indexCenter+sideSpread; if right>length(au.acf), right=length(au.acf); end
    [maxInRange, bpLocal]=max(acf2(left:right));
    if (maxFirst-maxInRange)/maxFirst<btOpt.peakHeightTol
        bp=bpLocal+left-1;
    end
end
bp=bp-1;	% Beat period
bpm=60/(bp*timeStep);
opt.trialNum=btOpt.trialNum;
opt.wingRatio=btOpt.wingRatio;
cBeatSet=periodicMarkId(frame, bp, opt, 0);
[~, maxIndex]=max([cBeatSet.weight]);
beatPos=cBeatSet(maxIndex).position;
cBeat=beatPos*timeStep;

fMeasure=[];
if isfield(au, 'gtBeat')
	fMeasure=zeros(length(au.gtBeat), 1);
	for i=1:length(au.gtBeat)
		fMeasure(i)=simSequence(cBeat, au.gtBeat{i}, 0.07);
    end
end

% Assign everything to au
au.cBeatSet=cBeatSet;
au.fMeasure=fMeasure;
au.cBeat=cBeat;