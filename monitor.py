import json
import sys
from datetime import datetime
from sklearn.ensemble import IsolationForest
import os

METRICS_FILE = "build_metrics.json"

# Load existing metrics
if os.path.exists(METRICS_FILE):
    with open(METRICS_FILE) as f:
        metrics = json.load(f)
else:
    metrics = []

# Add current build metrics
build_status = "failure" if "--failure" in sys.argv else "success"
metrics.append({
    "timestamp": str(datetime.now()),
    "status": build_status
})

# Save metrics
with open(METRICS_FILE, "w") as f:
    json.dump(metrics, f, indent=2)

# Prepare data for ML model
X = [[1 if m["status"]=="failure" else 0] for m in metrics]

# Train Isolation Forest
if len(X) > 5:  # need minimum samples
    clf = IsolationForest(contamination=0.2, random_state=42)
    clf.fit(X)
    pred = clf.predict(X)
    print("Anomaly predictions:", pred)
    if pred[-1] == -1:
        print("⚠️ Anomaly detected in latest build!")
else:
    print("Not enough data for anomaly detection yet.")
