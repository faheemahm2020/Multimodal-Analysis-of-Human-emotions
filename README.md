# Multimodal Analysis of Human emotions
### EEG Signal Processing, Brainwave Analysis, and Mental State Estimation

##  Project Overview

This project implements an EEG (Electroencephalography) signal analysis system using MATLAB to study brainwave activity and estimate mental states based on frequency-band power distribution.

The system processes EEG signals using digital filtering techniques, calculates Power Spectral Density (PSD), extracts the power of different brainwave frequency bands, and estimates a mental state using a dominant-band-based heuristic. The results are presented through graphical visualizations and a feedback display.

The project demonstrates the application of biomedical signal processing techniques to EEG data analysis.

## Objectives

- Process EEG signals using digital signal filtering.
- Reduce unwanted frequency components in the input signal.
- Analyze the frequency characteristics of EEG signals.
- Calculate Power Spectral Density using Welch's method.
- Extract Delta, Theta, Alpha, Beta, and Gamma band power.
- Estimate a mental state based on the dominant frequency band.
- Visualize raw signals, filtered signals, and frequency-domain characteristics.
- Display feedback corresponding to the estimated state.

##  Key Features

### 1. EEG Signal Acquisition or Loading
The MATLAB script loads the EEG signal data associated with the `high_alert.fig` figure file.

### 2. Signal Preprocessing
A bandpass filter with a frequency range of 0.5–50 Hz is applied to retain the frequency components of interest and attenuate unwanted components.

### 3. Power Spectral Density Analysis
Welch's method, implemented using MATLAB's `pwelch` function, is used to estimate the Power Spectral Density of the filtered EEG signal.

### 4. Brainwave Band-Power Extraction
The signal's power is analyzed across five frequency bands:

| Brainwave Band | Frequency Range | General Association |
|---|---:|---|
| Delta | 0.5–4 Hz | Slow-wave activity |
| Theta | 4–8 Hz | Drowsiness and certain cognitive processes |
| Alpha | 8–13 Hz | Relaxed wakefulness |
| Beta | 13–30 Hz | Active thinking and alertness |
| Gamma | 30–50 Hz | Higher-frequency neural activity |

*These associations are general and are not sufficient on their own to determine a person's mental state.*

### 5. Mental State Estimation
The dominant frequency band is identified from the calculated band powers. A rule-based heuristic uses this information to assign a state label and corresponding feedback.

This is an experimental estimation method rather than a trained machine learning classifier.

### 6. EEG Visualization
The script generates graphical representations to help examine EEG activity, including:
- Raw EEG signal
- Filtered EEG signal
- Power Spectral Density plot
- Pie chart representing brainwave band-power distribution
- Feedback window displaying the estimated state

### 7. Feedback Display
A MATLAB window displays the feedback associated with the estimated mental state, making the analysis easier to interpret.

## ⚙️ System Workflow

```text
        EEG Signal / Figure Data
                  |
                  v
          Signal Loading
                  |
                  v
          Signal Preprocessing
           (0.5–50 Hz Filter)
                  |
                  v
         Filtered EEG Signal
                  |
                  v
      Power Spectral Density (PSD)
          (Welch's Method)
                  |
                  v
        Frequency Band Analysis
                  |
                  v
     Delta | Theta | Alpha | Beta | Gamma
                  |
                  v
        Dominant Band Detection
                  |
                  v
        Mental State Estimation
                  |
                  v
       Feedback and Visualization
```

##  Methodology

### Step 1: Signal Loading
The script loads the EEG data required for processing using the provided MATLAB figure file.

### Step 2: Sampling Frequency Configuration
The sampling frequency is configured as:

- **Sampling frequency:** 256 Hz

This value is used in the frequency analysis and PSD calculations. It should match the actual sampling rate of the EEG data.

### Step 3: Bandpass Filtering
The EEG signal is filtered between 0.5 Hz and 50 Hz to focus on the frequency range used in the analysis.

### Step 4: PSD Computation
Welch's method divides the signal into segments and estimates its power spectral density. This provides a frequency-domain representation of the signal.

### Step 5: Band-Power Calculation
The PSD is used to calculate the power associated with each of the five defined frequency bands.

### Step 6: State Classification
The calculated band powers are compared to identify the dominant band. The script applies a predefined rule-based mapping to determine the output label.

### Step 7: Results Display
The final output includes EEG plots, band-power visualization, and the feedback associated with the estimated state.

## 🛠️ Technologies and Tools

- **MATLAB** — Signal processing, computation, and visualization
- **Signal Processing Toolbox** — Filtering and spectral analysis functions
- **`pwelch`** — Power Spectral Density estimation
- **MATLAB plotting functions** — EEG and frequency-band visualization
- **MATLAB GUI components** — Feedback display

##  Project Structure

```text
EEG-Mental-State-Analysis/
│
├── EEG_Mental_State_Analysis.m
├── high_alert.fig
└── README.md
```

- `EEG_Mental_State_Analysis.m` — Main MATLAB implementation.
- `high_alert.fig` — Figure file required by the script.
- `README.md` — Project documentation.

##  Installation and Setup
### Prerequisites

Ensure that you have:
- MATLAB installed on your computer.
- Signal Processing Toolbox available.
- The MATLAB script and required `high_alert.fig` file.

### Running the Project

1. Clone or download this repository.
2. Open MATLAB.
3. Set the Current Folder to the project directory.
4. Ensure that `high_alert.fig` is available at the path expected by the script.
5. Open `EEG_Mental_State_Analysis.m`.
6. Run the script.
7. Observe the generated plots and feedback window.

## Expected Outputs

When the script runs successfully, it is designed to display:

- The original EEG signal.
- The filtered EEG signal.
- The Power Spectral Density of the processed signal.
- A pie chart showing the distribution of power across the five EEG frequency bands.
- A mental-state label based on the dominant-band heuristic.
- Feedback associated with the estimated state.

Actual outputs depend on the input data and the script's classification rules.

##  Applications

- Biomedical signal processing education
- EEG frequency-domain analysis
- Brainwave visualization
- Experimental cognitive-state analysis
- MATLAB-based neuroscience projects
- Learning digital filtering and spectral analysis

##  Limitations

- The system uses a rule-based heuristic rather than a validated machine learning model.
- A dominant frequency band alone cannot reliably determine a person's mental state.
- EEG signals can be affected by eye movements, muscle activity, electrode contact, and environmental noise.
- The analysis depends on the quality and sampling rate of the input data.
- The project is intended for educational and experimental use, not medical diagnosis or clinical assessment.

##  Future Improvements

Potential extensions include:

- Implementing artifact removal techniques such as Independent Component Analysis (ICA).
- Comparing multiple EEG preprocessing methods.
- Adding additional EEG features, such as statistical and time-frequency features.
- Developing a machine learning classifier trained on labeled EEG data.
- Evaluating classification performance using appropriate validation metrics.
- Supporting real-time EEG acquisition from compatible hardware.
- Building an interactive dashboard for monitoring EEG signals and analysis results.
- Improving feedback generation using validated, subject-specific models.
