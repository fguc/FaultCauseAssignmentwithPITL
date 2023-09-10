# FaultCauseAssignmentwithPITL
Fault Cause Assignment with Physics Informed Transfer Learning

code01_generateRandomReferences_v1.m creates the randomized step changes for process reference, alternatively user can use standard step reference within Simulink model, for more details check slx file

code02_createDataSet_v1.m generates data from the reference model

code03_CWT_Creator.m converts DMDc modes to images

code04_CWT_DCNN_v1.m trains DCNN model

runSimulation_v1.m can be modified to update simulation parameters, and the Simulink model model\_FOPTD\_DMD\_3Scenario\_v1.slx can be modified to obtain different cases.


