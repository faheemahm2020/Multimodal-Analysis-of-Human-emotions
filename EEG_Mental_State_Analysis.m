%% EEG Mental State Analysis - Complete Code with Wrapped Feedback Display

clc; clear; close all;

% 1. Load EEG Data from .fig File
figureHandle = openfig('high_alert.fig', 'reuse');
h = findobj(figureHandle, 'Type', 'line');
eeg_signal = h.YData;
t = h.XData;
fs = 256; % Sampling frequency in Hz

% Plot raw EEG signal
subplot(2,2,1);
plot(t, eeg_signal);
title('Raw EEG Signal');
xlabel('Time (s)');
ylabel('Amplitude (\muV)');

% 2. Preprocessing - Bandpass Filter (0.5–50 Hz)
d = designfilt('bandpassiir', 'FilterOrder', 8, ...
    'HalfPowerFrequency1', 0.5, 'HalfPowerFrequency2', 50, ...
    'SampleRate', fs);
filtered_signal = filtfilt(d, eeg_signal);

% Plot filtered EEG signal
subplot(2,2,2);
plot(t, filtered_signal);
title('Filtered EEG Signal (0.5–50 Hz)');
xlabel('Time (s)');
ylabel('Amplitude (\muV)');

% 3. Feature Extraction - Power Spectral Density and Band Powers
[pxx, f] = pwelch(filtered_signal, hamming(512), 256, 512, fs);

% Plot PSD
subplot(2,2,3);
plot(f, 10*log10(pxx));
title('Power Spectral Density');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');

% Band Powers
delta_power = bandpower(pxx, f, [0.5 4], 'psd');
theta_power = bandpower(pxx, f, [4 8], 'psd');
alpha_power = bandpower(pxx, f, [8 13], 'psd');
beta_power  = bandpower(pxx, f, [13 30], 'psd');
gamma_power = bandpower(pxx, f, [30 50], 'psd');

features = [delta_power, theta_power, alpha_power, beta_power, gamma_power];

fprintf('\nExtracted Features (Band Powers):\n');
fprintf('Delta: %.4f, Theta: %.4f, Alpha: %.4f, Beta: %.4f, Gamma: %.4f\n', features);

% 4. Enhanced Mental State Classification with Feedback
[~, dominant_band_idx] = max(features);

switch dominant_band_idx
    case 1
        mental_state = 'Deep Sleep 😴 (Delta)';
        feedback_color = 'blue';
        feedback_text = 'Your brain shows dominant delta waves, indicating deep sleep or intense relaxation. This is vital for healing, memory consolidation, and restoring energy. Maintain consistent sleep habits to support mental and physical health.';
        
    case 2
        if alpha_power > beta_power
            mental_state = 'Creative 🧠 (Theta + Alpha)';
            feedback_color = 'purple';
            feedback_text = 'Your brain is in a creative rhythm, combining theta and alpha waves. You''re in a daydream-like state where ideas flow easily. Harness this moment for brainstorming, sketching, journaling, or solving open-ended problems.';
        else
            mental_state = 'Drowsy 💤 (Theta)';
            feedback_color = 'cyan';
            feedback_text = 'Your EEG suggests a drowsy state with dominant theta activity. You may be losing alertness—consider a short break, light movement, or hydration to refresh yourself.';
        end

    case 3
        mental_state = 'Relaxed 🧘‍♂ (Alpha)';
        feedback_color = 'green';
        feedback_text = 'You are calm and relaxed, with dominant alpha waves. This state is associated with meditative awareness and inner peace. It’s a good time for reflective thinking, listening to calming music, or taking mindful pauses.';
        
    case 4
        if gamma_power > 0.5 * beta_power && alpha_power < 0.5 * beta_power
            mental_state = 'Stressed 😣 (High Beta + Gamma)';
            feedback_color = 'red';
            feedback_text = 'High beta and gamma waves suggest mental strain or anxiety. You might be overthinking or under pressure. Practice deep breathing, step away briefly, or listen to calming audio to rebalance your mental state.';
        else
            mental_state = 'Focused 🎯 (Beta)';
            feedback_color = 'green';
            feedback_text = 'Beta activity is prominent, indicating sharp mental focus and alertness. You are cognitively engaged—perfect for reading, analysis, or learning. Stay hydrated and minimize distractions to make the most of this productive state.';
        end
        
    case 5
        mental_state = 'Highly Alert 🤓 (Gamma)';
        feedback_color = 'magenta';
        feedback_text = 'Your brain is highly alert, processing information rapidly with dominant gamma waves. This state supports memory formation and peak cognition. It’s a great time for advanced problem-solving—but remember to rest your mind periodically.';
        
    otherwise
        mental_state = 'Unknown ❓';
        feedback_color = 'black';
        feedback_text = 'The system couldn’t confidently identify your mental state. Ensure clean electrode contact, minimize motion, and try again for more accurate results.';
end

% 5. Band Power Pie Chart
subplot(2,2,4);
labels = {'Delta (0.5–4 Hz)', 'Theta (4–8 Hz)', 'Alpha (8–13 Hz)', 'Beta (13–30 Hz)', 'Gamma (30–50 Hz)'};
pie(features, labels);
title('EEG Band Power Distribution');

% 6. Feedback Display Window with Wrapped Text
disp(['Predicted Mental State: ' mental_state]);
disp(['Feedback: ' feedback_text]);

fig = figure('Name', 'Mental State Feedback', 'Position', [100, 100, 600, 300]);
axis off;

% Display the mental state label
text(0.5, 0.85, mental_state, 'HorizontalAlignment', 'center', ...
     'FontSize', 24, 'Color', feedback_color, 'Units', 'normalized');

% Display wrapped feedback text in a uicontrol box
uicontrol('Style', 'text', ...
          'String', feedback_text, ...
          'Units', 'normalized', ...
          'Position', [0.05 0.05 0.9 0.6], ...
          'FontSize', 12, ...
          'HorizontalAlignment', 'left', ...
          'BackgroundColor', get(fig, 'Color'));
