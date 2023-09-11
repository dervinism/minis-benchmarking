[![DOI](https://zenodo.org/badge/687046158.svg)](https://zenodo.org/badge/latestdoi/687046158)

# minis-benchmarking
This repository contains benchmarking analysis Matlab code for [minis](https://github.com/dervinism/minis) software. It contains all the analysis code required to reproduce Figure 2 and Figures 4-15 of the minis benchmarking [manuscript](https://doi.org/10.1101/2022.03.20.485046).

## Installation Instructions
Download the code repository and add it to the Matlab path, including its subfolders. If you are using Windows, place the code repository in your system's root folder, because ABF files have long names. Subsequently, download the minis benchmarking data [repository](https://gin.g-node.org/dervinism/minis-benchmarking-data) and place it inside the minis-benchmarking [repository](https://github.com/dervinism/minis-benchmarking).

The analysis code in this repository also depends on the minis software source code. Therefore, you also need to download and install minis [repository](https://github.com/dervinism/minis/tree/main/source_code).

## Instructions for Reproducing Manuscript Figures
Once all the required repositories are downloaded and Matlab path is set up, it is straightforward to reproduce the figures. In order to reproduce Figure 2, simply execute the script ```displayEventsProtocols.m```. When requested about data filtering, press ```OK```. Figure panels will be saved inside the folder ```minis-benchmarking/minis-benchmarking-data/recs/p108b/traces```. Panel A corresponds to the files named ```algorithm_performance_data__amp0p3_sAmp0p05_n4000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_56_48_0001_interv_12570_13350_voltage_range_-60.55_-53.45``` (in PNG, EPS, and FIG file formats). Panel B is saved in files named ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_12570_13350_voltage_range_-60.55_-53.45```.

To reproduce Figure 5, execute the script in the file named ```displayEvents.m```. When requested about data filtering, press ```OK```. The figure panels will be saved inside folders ```minis-benchmarking/minis-benchmarking-data/recs/p108b/traces``` and ```minis-benchmarking/minis-benchmarking-data/recs/p108a/traces```. Files (available in PNG, EPS, and FIG file formats) corresponding to particular figure panels are listed below:
- Panel A: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_34400_34600_volt_range_-58_-53.96```.
- Panel B: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_41300_41800_volt_range_-58_-53.96```.
- Panel C: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_23600_24000_volt_range_-58_-53.96```.
- Panel D: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_7400_7700_volt_range_-58_-53.96```.
- Panel E: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_350_500_volt_range_-58_-53.96```.
- Panel F: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_26300_26500_volt_range_-58_-53.96```.
- Panel G: ```algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001_interv_37750_37850_volt_range_-58_-53.96```.
- Panel H: ```algorithm_performance_data__amp0p3_sAmp0p05_n2000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__10_Jan_2021_23_30_07_0001_interv_38500_38700_volt_range_-62.55_-58.8```.

Finally, to reproduce Figures 4 and 6-15, run Matlab script files ```summaryMinis.m``` and ```summaryMinis2.m```. All figures produced by these analysis scripts will be saved in folders ```minis-benchmarking/minis-benchmarking-data/summary```, ```minis-benchmarking/minis-benchmarking-data/summarySelect```, and ```minis-benchmarking/minis-benchmarking-data/summary2```. All the relevant figures will be picked up and displayed in the ```figureDraft.mlx``` Matlab Live Script document. The output of the Live Script document will be saved in ```minis-benchmarking/paper-figures``` folder. Note that when executing ```summaryMinis2.m``` script for the first time, make sure that line 4 set as follows
```
fullRun = true;
```
It will take a considerable amount of time to run this script the first time. However, once finished, the results are saved in ```decayDetectionPerformance.mat``` files in all three folders. Running the script the second and subsequent times, line 4 can be set as follows
```
fullRun = false;
```
If you notice that x-axis tick marks of certain figures appear to be incorrectly labeled, rerun ```summaryMinis2.m``` script with the ```fullRun``` option set to false
```
fullRun = false;
```
and adjust lines 29-35 to get the right rate of change scaling:
```
if strcmpi(testType{iTest}, 'test1')
  adjustRates = false;
elseif strcmpi(testType{iTest}, 'testSelect')
  adjustRates = true;
elseif strcmpi(testType{iTest}, 'test2')
  adjustRates = false;
end
```
The results of statistical inference tests are saved in ```stats.mat``` file in all three folders.

## Data Preprocessing
Figures are produced by loading and analysing already processed data files within the minis benchmarking data [repository](insert the link here). Large part of data processing was carried out using scripts ```evaluateMinisPostprocessing.m```, ```evaluateMiniAnalysisPostprocessing.m```, and ```evaluatepClampPostprocessing.m``` (or ```evaluateAll.m```). Some data processing was also carried out during data simulation using minis software. If needed, all of the data processing steps can be repeated. For more detail, see the minis benchmarking data [repository](insert the link here).
