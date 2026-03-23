## EEG-Motor-Imagery-Classification-using-Mu-Rhythm-Features

This project implements a basic EEG motor imagery classification pipeline
using the BCI Competition IV-2a dataset.
The goal is to classify left-hand vs right-hand motor imagery using
physiologically meaningful features derived from the mu rhythm (8–13 Hz).

Dataset: BCI Competition IV Dataset 2a
- 22 EEG channels
- 4 classes (left hand, right hand, feet, tongue)
- Only left vs right imagery used in this project

- 1. Load EEG data
2. Extract trials using provided indices
3. Remove artifact-contaminated trials
4. Segment motor imagery window (2–6 seconds)
5. Bandpass filter in mu band (9–13 Hz)
6. Construct 3D dataset (trials × samples × channels)

# Feature Extraction
Three features are extracted per trial:
1. log(var(C3)) → left motor cortex activity
2. log(var(C4)) → right motor cortex activity
3. log(pL / pR) → hemispheric power ratio
These features are motivated by Event-Related Desynchronization (ERD), where motor imagery suppresses the mu rhythm.

# Classification and Results
Classifier: Linear Discriminant Analysis (LDA)

- Data split: 70% training / 30% testing
- Evaluation: classification accuracy

Single Subject:
Accuracy ≈ 60–70%
Multi-Subject:
Accuracy ≈ 58%
Some subjects show near-chance performance (~50%),
highlighting inter-subject variability in EEG signals.

# Key Insights
- Motor imagery reduces mu rhythm power (ERD)
- Spatial differences between hemispheres are informative
- EEG signals are noisy and subject-dependent
- Simple features can achieve above-chance classification

# Limitations
- Features are simple (no spatial filtering like CSP)
- Performance varies across subjects
- No cross-validation used (optional improvement)

# Future Scope
- Features are simple (no spatial filtering like CSP)
- Performance varies across subjects
- No cross-validation used (optional improvement)
