# minis-benchmarking-data
Intracellular membrane potential noise recordings in cortical pyramidal cells after blocking action potentials and synaptic transmission (0.5 or 1 μM TTX, 12.5 μM gabazine, 40 μM NBQX, and 50 μM CPP) and simulations of miniature excitatory postsynaptic potentials (mEPSPs) in cortical pyramidal cells. The data in this repository was used to produce the [manuscript](https://doi.org/10.1101/2022.03.20.485046) of the [minis](https://github.com/dervinism/minis) software benchmarking study.

## Repository content
### recs
```recs``` folder holds data for all individual recordings in separate folders. Folders are named according to recording IDs: ```p103a```, ```p106b```, ```p108a```, ```p108b```, ```p108c```, ```p120b```, ```p122a```, ```p124b```, ```p125a```, ```p127c```, ```p128c```, ```p129a```, ```p131a```, ```p131c```. Recording IDs are formed by appending the animal ID with the slice ID letter. Each recording ID folder has the following structure:
|**Folder name**          |**Description**   |
|-------------------------|------------------|
|abf 	                    | *This folder contains Axon Binary Format files produced by simulating excitatory postsynaptic potentials (EPSPs) and superimposing them on top of the filtered and smoothed intracellular membrane potential noise recordings. These files are produced by ```minis``` software running in the ```Simulate``` mode. ```minis``` in turn calls ```simulateDetectEvaluate``` function which performs the simulation, runs the ```minis``` detection algorithm on the noise + simulated EPSP time series data, and evaluates detection performance using signal detection measures. There are 4 simulated files per each test condition as described in the manuscript. File name parts identifying different conditions are listed below the table.*|
|abf_raw 	                | *This folder contains ABF files that correspond to files in ```abf``` folder prior to being smoothed. These files are used to detect simulated EPSPs by Clampfit. Smoothed recordings are not suitable for Clampfit detection.*|
|csv_MA 	                | *This folder contains ```Mini Analysis``` simulated EPSP detection output tables saved in the CSV format. The CSV files correspond to each ABF file in the ```abf``` folder.*|
|csv_pC_raw 	            | *This folder contains Clampfit simulated EPSP detection output tables saved in the CSV format. The CSV files correspond to each ABF file in the ```abf_raw``` folder.*|
|mat_MA 	                | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` and ```csv_MA``` folders. ```Mini Analysis``` part of the manuscript Figures 4 and 6-8 are based on the data stored in this folder. The output is saved in the MAT format and contains variables that are explained below this table. The output files are produced by the ```evaluateMiniAnalysisPostprocessing``` function.*|
|mat_MA_select            | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` and ```csv_MA``` folders. ```Mini Analysis``` part of the manuscript Figures 9-11 are based on the data stored in this folder.* |
|mat_MA2	                | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` and ```csv_MA``` folders. ```Mini Analysis``` part of the manuscript Figures 12-15 are based on the data stored in this folder.*  |
|mat_minis	              | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` folder. ```minis``` part of the manuscript Figures 4 and 6-8 are based on the data stored in this folder. The output is saved in the MAT format and contains variables that are explained below this table. The output files are produced either by ```simulateDetectEvaluate``` or by ```evaluateMinisPostprocessing``` functions.* |
|mat_minis_select         | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` folder. ```minis``` part of the manuscript Figures 9-11 are based on the data stored in this folder.* |
|mat_minis2 	            | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf``` folder. ```minis``` part of the manuscript Figures 12-15 are based on the data stored in this folder.* |
|mat_pC_raw               | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf_raw``` and ```csv_pC_raw``` folders. ```Clampfit``` part of the manuscript Figures 4 and 6-8 are based on the data stored in this folder. The output is saved in the MAT format and contains variables that are explained below this table. The output files are produced by the ```evaluatepClampPostprocessing``` function.* |
|mat_pC_raw_select        | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf_raw``` and ```csv_pC_raw``` folders. ```Clampfit``` part of the manuscript Figures 9-11 are based on the data stored in this folder.* |
|mat_pC_raw2	            | *Simulated EPSP detection performance evaluation analysis output files corresponding to individual files in the ```abf_raw``` and ```csv_pC_raw``` folders. ```Clampfit``` part of the manuscript Figures 12-15 are based on the data stored in this folder.* |
|```<filename>.abf```		  | *Recording of intracellular membrane potential noise stored in the ABF file.* |

#### Test Condition File Naming
Files stored in folders ```abf```, ```abf_raw```, ```csv_MA```, ```csv_pC_raw```, ```mat_MA```, ```mat_MA_select```, ```mat_MA2```, ```mat_minis```, ```mat_minis_select```, ```mat_minis2```, ```mat_pC_raw```, ```mat_pC_raw_select```, and ```mat_pC_raw2``` correspond to individual testing conditions when part of their name contain the following characters:
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
|sensitivity 	      | *Sensitivity (or true positive rate) for each simulation file.*|
|specificity 	      | *Specificity (or true negative rate) for each simulation file.*|
|performance 	      | *Performance indicators for each simulation file. There are 7 indicators (rows) with the same sampling rate as the original data (columns). Row 1: Simulated EPSP positions. Row 2: Positions of hits (where detected rather than simulated) and misses. Row 3: Positions of hits and false alarms. Row 4: Hit positions. Row 5: Missed event positions. Row 6: False alarm positions. Row 7: Positions of correctly rejected noise events.*|
|falseI 	          | *Indices of noise events. Also could be reprhrased as sample points corresponding to the peaks of designated noise events.*|
|falseT 	          | *Times of noise events (peaks of designated noise events).*|
|filename 	        | *Noise recording file name.*|

### temps
Clampfit EPSP templates (Axon Text File format) used to detect simulated EPSPs and described in the benchmarking [manuscript](https://doi.org/10.1101/2022.03.20.485046).