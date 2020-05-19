function main()
%a main.m wrapper for OCT data analysis on brainlife

if ~isdeployed
   addpath(genpath(pwd))
   %or an equivalent repository on brainlife should one come to exist
end

% Load the files from config.json
config = loadjson('config.json');


%these are the layers we want to analyse with the associated names
%These are specified by user
%layerIndexSequences={1:7,1:4,5,6};
layerIndexSequences=config.layerIndexSequences;
layerIndexSequences=strsplit(layerIndexSequences,',');
layerIndexSequences=cellfun(@str2num,layerIndexSequences,'UniformOutput',false);
%Is there a better way to obtain these?
%these are the given layer combination names
%perhaps we could just assign them arbitrary numerical names in order to
%reduce the number of user inputs?
%analysesNames={'TT','NL','ONL','PROS'};
analysesNames=config.analysesNames;
analysesNames=strsplit(analysesNames,',');


%check for input length agreement
if ~length(layerIndexSequences)==length(analysesNames)
    error('layerIndexSequences and analysesNames are of different lenghts')
else
    fprintf('\n %i output analsis files to create per subject')
end

%input data directory for current subject
%example input data dir

osRaw=config.os_raw;
osCentroid=config.os_centroid;
odRaw=config.od_raw;
odCentroid=config.od_centroid;

%temporary path for storage for secondary data product
secondaryOutputDir=fullfile(pwd,'secondaryData');
if ~isfolder(secondaryOutputDir)
    mkdir(secondaryOutputDir)
end

%run it twice, no need to make a loop
%this will cause a problem if there aren't two eyes worth of data
createLayerAmalgumOutputs(osRaw,secondaryOutputDir, layerIndexSequences,analysesNames)
createLayerAmalgumOutputs(odRaw,secondaryOutputDir, layerIndexSequences,analysesNames)

%% do layer based analysis
%visual field width in degrees, i.e. diameter of visual field measured
%currently specified by user, but maybe there is a better way to infer this
%from the centroid csv data?
visFieldDiam=config.visFieldDiam;

%specify how you would like the iterative mean computed, either as either "rings" or "full".  This indicates whether the
%  mean of the visual field should be computed as hollow, cocentric, 1mm
%  rings (think dart board) or as a full circle/elipsoid.

%meanShape='rings';
meanShape=config.meanShape;

%  smoothParam:  smoothing kernel to apply to <subjectLayersCSVpath> data.
%  If variable is empty, no smoothing is applied.

%gaussKernel=3
gaussKernel=config.gaussKernel;

%  threshFloor:  floor threshold value for data in <subjectLayersCSVpath>
%  data.  Values below floor are set to NaN and not computed in averages.

%theshFloor=20
theshFloor=config.theshFloor;

%final output dir
finalOutputDir=fullfile(pwd,'finalOutput');
if ~isfolder(finalOutputDir)
    mkdir(finalOutputDir)
end

%run the analysis
analyzeSubjectOCTDataWrapper(secondaryOutputDir,finalOutputDir, {osCentroid, odCentroid },visFieldDiam, meanShape,gaussKernel,theshFloor)

%end of wrapper

end