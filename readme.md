##
## app-voxelronOCT

**Authors**

- Daniel Bullock ([dnbulloc@iu.edu](mailto:dnbulloc@iu.edu))
- Jasleen Jolly ([jolly@eye.ox.ac.uk](mailto:jasleen.jolly@eye.ox.ac.uk))

**Lab Directors**

- Franco Pestilli ([franpest@indiana.edu](mailto:franpest@indiana.edu)) - Indiana University Bloomington
- Holly Bridge (holly.bridge@ndcn.ox.ac.uk)  -  University of Oxford


**Running this app**

This code is written in Matlab and subsequently compiled.  It makes use of the _imresize_ function and thus requires Matlab&#39;s image processing toolkit as well the source repository for this codebase (https://github.com/DanNBullock/OCT_scripts/).

The only input for this application is an appropriately structured OCT data object (see https://brainlife.io/datatype/5ebe0bbbb969982124072325) for the given subject.  

Parameter inputs are as follows:

| **Parameter variable name** | **Purpose** | **Specifications** |
| --- | --- | --- |
| layerIndexSequences | Indicates which layers are to be summed in createCSVsumOutputFiles to generate the layer amalgams that will be processed later. | Sequence[1] of sequence[2] of integers.  Sequence[1] must be equal to the number of inputs in analysesNames.  sequence[2] must be unique integers which do not exceed the total number of layers obtained from Voxeleron&#39;s [deviceName] |
| analysesNames | Indicates the abbreviation for the layer amalgam, corresponds to [specify standard]. | Set of strings, equal in length to sequence[1] of layerIndexSequences |
| visFieldDiam | Indicates the total _diameter_ of the visual field measured by the experimenter.  Assumed to be consistent across subjects.  The user/experimenter should know this about their data.The code must be amended if this is not the case, e.g. retrospective analysis of clinical data. | Numerical value |
| theshFloor | Specifies the desired threshold to be applied to input data obtained from createCSVsumOutputFiles.   Applied across subjects (prior to computation of means).  Values below this are set to NaN and are not featured in computation of mean.  If no threshold is desired, enter a value of []. | Numerical value |
| gaussKernel | Specifies the desired smoothing kernel to be applied to input data obtained from createCSVsumOutputFiles.   Applied across subjects (prior to computation of means).  Pixel values are thus the result of a gaussian smoothing process.  If no threshold is desired, enter a value of [] or 1. | Odd integer value |
| meanShape | Specifies the desired method for computing the mean.  &quot;rings&quot; will generate averages for concentric, degree-specific rings (like a bullseye), while &quot;full&quot; will compute the mean for the entire visual field (to the specified current, iterated degree). | Either &quot;rings&quot; or &quot;full&quot; |

The output is as follows:

Two tables, meanTable.csv and stdTable.csv.
In both tables, each row (aside from the header row) corresponds to each combination of eye and layer amalgum analysis (i.e. layer sequence input in layerIndexSequences) that was performed.  Each column (other than the LayerNames column, which lists the combination of eye and layer amalgum analysis) corresponds to the measurement for one degree of visual angle, up to the maximum specified by the visFieldDiam variable.  The mean and standrard deviations for each of these degrees of visual angle are computed in accordance with the meanShape input variable.

**Code details (OCT)**

Source repo can be found here: https://github.com/DanNBullock/OCT_scripts/

The main.m function is the primary function for this app, and calls the relevant subfunctions of the OCT_scripts respository.  Please see the main.m of this repo for those top level functions and their usage, and see OCT_scripts for those functions's documentation and subfucntions.
