#!/bin/bash
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader)

echo "{\"tooltip\": \"GPU: ${temp}°C\nUsage: ${usage}%\", \"text\": \"GPU ${usage}%\"}"
