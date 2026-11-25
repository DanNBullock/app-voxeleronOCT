<h1 align="center">Voxeleron OCT data Processing</h1>

<p align="center">
  Computes the mean and standard deviation of Voxeleron retinal OCT layer thickness data per degree of visual angle (rings or other shapes), within or across layers, and outputs CSV tables.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.346"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.346-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-see_LICENSE-lightgrey.svg" alt="License"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Computes the mean and standard deviation of Voxeleron retinal OCT layer thickness data per degree of visual angle (rings or other shapes), within or across layers, and outputs CSV tables.**

A compiled MATLAB App (OCT_scripts) that reads the left and right eye raw OCT data and centroids, sums the layers listed in layerIndexSequences into named layer amalgams, optionally thresholds and Gaussian-smooths the maps, and averages them per degree of visual angle out to visFieldDiam. Use it to summarise Voxeleron/MAIA OCT data by eccentricity. layerIndexSequences and analysesNames must have the same number of entries.

| | |
|---|---|
| **Inputs** | `optometry/oct` |
| **Outputs** | `raw` |
| **Container** | `brainlife/mcr:r2019a` |
| **Resources** | 4 CPUs · 28 GB memory · 0.33 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.346](https://doi.org/10.25663/brainlife.app.346) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `input OCT` | `optometry/oct` | yes | Voxeleron OCT data object for one subject: raw data and centroid files for the left (os) and right (od) eye. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `finalOutput` | `raw` | Two CSV files showing the mean and standard deviation for each degree of the visual field, across the analyses requested. |

<details>
<summary><b>Parameters</b> (6)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `layerIndexSequences` | string | `1:7,1:4,5,6` | Indicates which layers are to be summed in order to generate the layer amalgams that will be processed later. |
| `analysesNames` | string | `TT, NL, ONL, PROS` | Indicates the abbreviation for the layer amalgam, will label the output analyses. Must be of equal length as the layerIndexSequences input. |
| `visFieldDiam` | number | `20` | Indicates the total *diameter* of the visual field measured by the experimenter. Assumed to be consistent across subjects. The user/experimenter should know this about their data. |
| `theshFloor` | number | `0` | Specifies the desired threshold to be applied. Applied prior to computation of means. Values below this are set to NaN and are not featured in computation of mean. If no threshold is desired, enter a value of 0. |
| `gaussKernel` | number | `1` | Specifies the desired smoothing kernel to be applied. Applied prior to computation of means). Pixel values are thus the result of a gaussian smoothing process. If no threshold is desired, enter a value of 1. MUST BE AN ODD NUMBER |
| `meanShape` | enum | `rings` | Specifies the desired method for computing the mean. "rings" will generate averages for concentric, degree-specific rings (like a bullseye), while "full" will compute the mean for the entire visual field (to the specified current, iterated degree). Options: `rings`, `full`. |

</details>

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.346](https://doi.org/10.25663/brainlife.app.346), choose `optometry/oct` from your project, set the parameters and press **Execute**. The results are saved to your project as `raw`.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) (the App runs in `brainlife/mcr:r2019a`), [`jq`](https://jqlang.github.io/jq/).

1. Clone this repository.
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "os_raw": "/path/to/input OCT/os_raw",
       "os_centroid": "/path/to/input OCT/os_centroid",
       "od_raw": "/path/to/input OCT/od_raw",
       "od_centroid": "/path/to/input OCT/od_centroid",
       "layerIndexSequences": "1:7,1:4,5,6",
       "analysesNames": "TT, NL, ONL, PROS",
       "visFieldDiam": 20,
       "theshFloor": 0,
       "gaussKernel": 1,
       "meanShape": "rings"
   }
   ```

3. Run `./main`.

## Troubleshooting

- **layerIndexSequences and analysesNames are of different lengths**: Give the same number of comma-separated entries in layerIndexSequences and analysesNames.

## app-voxeleronOCT

**Authors**

- Daniel Bullock ([dnbulloc@iu.edu](mailto:dnbulloc@iu.edu))
- Jasleen Jolly ([jasleen.jolly@eye.ox.ac.uk](mailto:jasleen.jolly@eye.ox.ac.uk))

**Lab Directors**

- Franco Pestilli ([frakkopesto@gmail.com](mailto:frakkopesto@gmail.com)) - University of Texas at Austin / Indiana University
- Holly Bridge ([holly.bridge@ndcn.ox.ac.uk](mailto:holly.bridge@ndcn.ox.ac.uk))  -  University of Oxford

## Code details

**Code details (OCT)**

Source repo can be found here: https://github.com/DanNBullock/OCT_scripts/

The main.m function is the primary function for this app, and calls the relevant subfunctions of the OCT_scripts respository.  Please see the main.m of this repo for those top level functions and their usage, and see OCT_scripts for those functions's documentation and subfucntions.

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- Voxeleron OCT data Processing. brainlife.io App. [doi:10.25663/brainlife.app.346](https://doi.org/10.25663/brainlife.app.346)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

Maintained by [@DanNBullock](https://github.com/DanNBullock).

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io, which runs this App, is publicly funded by Wellcome, the U.S. National Institutes of Health and the U.S. National Science Foundation; acknowledging that support helps keep it running.</sub>

## License

See [LICENSE](LICENSE).
