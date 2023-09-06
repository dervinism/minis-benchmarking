# minis-benchmarking
This repository contains benchamarking analysis Matlab code for [minis](insert the link here) software. It contains all the analysis code required to reproduce Figure 2 and Figures 4-15 of the minis benchmarking [manuscript](insert the link here).

## Installation Instructions
Download the code repository and add it to the Matlab path, including its subfolders. Subsequently, download the minis benchmarking data [repository](insert the link here) and place it inside the minis-benchamarking [repository](insert the link here).

The analysis code in this repository also depends on the minis software source code. Therefore, you also need to download and install minis [repository](insert the link here).

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










# minis-benchmarking-data
Intracellular noise recordings and simulations of miniature excitatory postsynaptic potentials in cortical pyramidal cells. The data in this repository was used to produce the [manuscript](insert the link here) of the [minis](insert the link here) software benchamarking study.

## Repository content
### recs
```recs``` folder holds data for all individual recordings in separate folders. Folders are named according to recording IDs: ```p103a```, ```p106b```, ```p108a```, ```p108b```, ```p108c```, ```p120b```, ```p122a```, ```p124b```, ```p125a```, ```p127c```, ```p128c```, ```p129a```, ```p131a```, ```p131c```. Each recording ID folder has the following structure:
|**Folder name**          |**Description**   |
|-------------------------|------------------|
|abf 	                    | *This folder contains Axon Binary Format files produced by simulating excitatory postsynaptic potentials (EPSPs) and superimposing them on top of the filtered and smoothed intracellular membrane potential noise recordings. These files are produced by ```minis``` software running in the ```Simulate``` mode. ```minis``` in turn calls ```simulateDetectEvaluate``` function which performs the simulation, runs the ```minis``` detection algorithm on the noise + simulated EPSP time series data, and evaluates detection performance using signal detection measures. There are 4 simulated files per each test condition as described in the manuscript. File name parts identifying different conditions are listed below the table.*|
|abf_raw 	                | *This folder contains ABF files that correspond to files in ```abf`` folder prior to being smoothed. These files are used to detect simulated EPSPs by Clampfit. Smoothed recordings are not suitable for Clampfit detection.*|
|csv_MiniAnalysis 	      | *This folder contains ```Mini Analysis``` simulated EPSP detection output tables saved in the CSV format. The CSV files correspond each ABF file in the ```abf``` folder.*|
|csv_pClamp_raw 	        | *This folder contains Clampfit simulated EPSP detection output tables saved in the CSV format. The CSV files correspond each ABF file in the ```abf_raw``` folder.*|
|mat_MiniAnalysis 	      | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` and ```csv_MiniAnalysis``` folders. ```Mini Analysis``` part of the manuscript Figures 4 and 6-8 are based on the data stored in this folder. The output is saved in the MAT format and contains variables that are explained below this table. The output files are produced by the ```evaluateMiniAnalysisPostprocessing``` function.*|
|mat_MiniAnalysis_select  | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` and ```csv_MiniAnalysis``` folders. ```Mini Analysis``` part of the manuscript Figures 9-11 are based on the data stored in this folder.* |
|mat_MiniAnalysis2	      | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` and ```csv_MiniAnalysis``` folders. ```Mini Analysis``` part of the manuscript Figures 12-15 are based on the data stored in this folder.*  |
|mat_minis	              | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` folder. ```minis``` part of the manuscript Figures 4 and 6-8 are based on the data stored in this folder. The output is saved in the MAT format and contains variables that are explained below this table. The output files are produced either by ```simulateDetectEvaluate``` or by ```evaluateMinisPostprocessing``` functions.* |
|mat_minis_select         | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` folder. ```minis``` part of the manuscript Figures 9-11 are based on the data stored in this folder.* |
|mat_minis2 	            | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` folder. ```minis``` part of the manuscript Figures 12-15 are based on the data stored in this folder.* |
|mat_pClamp_raw           | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf_raw``` and ```csv_pClamp_raw``` folders. ```Clampfit``` part of the manuscript Figures 4 and 6-8 are based on the data stored in this folder. The output is saved in the MAT format and contains variables that are explained below this table. The output files are produced by the ```evaluatepClampPostprocessing``` function.* |
|mat_pClamp_raw_select    | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf_raw``` and ```csv_pClamp_raw``` folders. ```Clampfit``` part of the manuscript Figures 9-11 are based on the data stored in this folder.* |
|mat_pClamp_raw2	        | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf_raw``` and ```csv_pClamp_raw``` folders. ```Clampfit``` part of the manuscript Figures 12-15 are based on the data stored in this folder.* |
|```<filename>.abf```		  | *Recording of intracellular membrane potential noise stored in the ABF file.* |

#### Test Condition File Naming
Files stored in folders ```abf```, ```abf_raw```, ```csv_MiniAnalysis```, ```csv_pClamp_raw```, ```mat_MiniAnalysis```, ```mat_MiniAnalysis_select```, ```mat_MiniAnalysis2```, ```mat_minis```, ```mat_minis_select```, ```mat_minis2```, ```mat_pClamp_raw```, ```mat_pClamp_raw_select```, and ```mat_pClamp_raw2``` correspond to individual testing conditions when part of their name contain the following characters:
- ```amp0p3_sAmp0p05_n500_<...>_noiseScaleFactor4p2```: 0.3 mV simulated EPSPs at 2.5 events/second with the noise scaling factor of 4.2.
- ```amp0p3_sAmp0p05_n500_<...>_noiseScaleFactor2p6```: 0.3 mV simulated EPSPs at 2.5 events/second with the noise scaling factor of 2.6.
- ```amp0p3_sAmp0p05_n500_<...>_noiseScaleFactor1p8```: 0.3 mV simulated EPSPs at 2.5 events/second with the noise scaling factor of 1.8.
- ```amp0p3_sAmp0p05_n500_<...>_noiseScaleFactor1p4```: 0.3 mV simulated EPSPs at 2.5 events/second with the noise scaling factor of 1.4.
- ```amp0p3_sAmp0p05_n500_<...>_noiseScaleFactor1p2```: 0.3 mV simulated EPSPs at 2.5 events/second with the noise scaling factor of 1.2.
- ```amp0p3_sAmp0p05_n500_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 2.5 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n1000_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 5 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n2000_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 10 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n4000_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 20 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n8000_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 40 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n1600_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 80 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n3200_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 160 events/second with the noise scaling factor of.
- ```amp0p3_sAmp0p05_n6400_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 320 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp0p05_n12800_<...>_noiseScaleFactor1```: 0.3 mV simulated EPSPs at 640 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp1e_09_n500_<...>_noiseScaleFactor1```: Varying amplitude simulated EPSPs at 13 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp1e_09_n625_<...>_noiseScaleFactor1``` or ```amp0p3_sAmp1e_09_n1250_<...>_noiseScaleFactor1```: Varying amplitude simulated EPSPs at 33 events/second with the noise scaling factor of 1.
- ```amp0p3_sAmp1e_09_n1000_<...>_noiseScaleFactor1``` or ```amp0p3_sAmp1e_09_n2000_<...>_noiseScaleFactor1```: Varying amplitude simulated EPSPs at 53 events/second with the noise scaling factor of 1.

#### Detection Performance Evaluation Analysis Output
Detection performance evaluation analysis output is produced separately for each testing condition and is saved in Matlab data files (MAT format) containing the following variables:
|**Variable name**  |**Description**   |
|-------------------|------------------|
|dPrime 	          | *d' sensitivity index for each simulation file.*|
|FPR 	              | *False positive rate for each simulation file.*|
|sensitivity 	      | *sensitivity (or true positive rate) for each simulation file.*|
|specificity 	      | *specificity (or true negative rate) for each simulation file.*|
|performance 	      | *performance indicators for each simulation file. There are 7 indicators (rows) with the same sampling rate as the original data (columns). Row 1: Simulated EPSP positions. Row 2: Positions of hits (where detected rather than simulated) and misses. Row 3: Positions of hits and false alarms. Row 4: Hit positions. Row 5: Missed event positions. Row 6: False alarm positions. Row 7: Positions of correctly rejected noise events.*|
|falseI 	          | *Indices of noise events. Also could be reprhrased as sample points corresponding to the peaks of designated noise events.*|
|falseT 	          | *Times of noise events (peaks of designated noise events).*|
|filename 	        | *Noise recording file name.*|

### temps
Clampfit EPSP templates (Axon Text File format) used to detect simulated EPSPs and described in the benchamarking manuscript.