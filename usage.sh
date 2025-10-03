#!/bin/bash

# --- CONFIG ---
MONTHLY_BUDGET=50  # Monthly dev/free subscription budget in USD

# --- Dates ---
START_DATE=$(date -d "$(date +%Y-%m-01)" +%Y-%m-%d)
END_DATE=$(date +%Y-%m-%d)
BILLING_PERIOD_END=$(date -d "$(date +%Y-%m-01) +1 month -1 day" +%Y-%m-%d)
DAYS_REMAINING=$(( ( $(date -d "$BILLING_PERIOD_END" +%s) - $(date +%s) ) / 86400 ))

# --- Get usage for current month ---
USAGE_JSON=$(az consumption usage list \
    --start-date "$START_DATE" \
    --end-date "$END_DATE" \
    --query "[].{category: meterCategory, cost: pretaxCost}" \
    -o json)

# --- Handle empty or null usage ---
TOTAL_SPENT=$(echo "$USAGE_JSON" | jq '[.[] | .cost // 0] | add')
TOTAL_SPENT=${TOTAL_SPENT:-0}

# --- Remaining budget ---
REMAINING=$(echo "$MONTHLY_BUDGET - $TOTAL_SPENT" | bc)

# --- Usage breakout by category ---
echo "Usage breakout by category:"
echo "$USAGE_JSON" | jq -r '.[] | "\(.category // "Unknown"): $ \(.cost // 0)"' | sort | uniq -c

# --- Summary ---
echo
echo "Total spent: \$${TOTAL_SPENT}"
echo "Remaining budget: \$${REMAINING}"
echo "Days remaining: $DAYS_REMAINING"
