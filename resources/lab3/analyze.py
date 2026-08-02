import json
import pandas as pd

# --- Load and analyze CSV (structured) ---
df = pd.read_csv("employees.csv")
print("=== CSV Structure (employees.csv) ===")
print("Shape (rows, cols):", df.shape)
print("Columns:", list(df.columns))
print("Dtypes:\n", df.dtypes)
print("\nFirst rows:\n", df.head())

# --- Load and analyze JSON (semi-structured) ---
with open("employees.json") as f:
    data = json.load(f)

print("\n=== JSON Structure (employees.json) ===")
print("Record count:", len(data))
print("Keys in record 0:", list(data[0].keys()))
print("Keys in record 2 (extra 'certifications' field):", list(data[2].keys()))
print("Nested keys under 'address':", list(data[0]["address"].keys()))
print("Sample 'skills' array (record 0):", data[0]["skills"])

# Flatten nested JSON into a DataFrame for comparison
flat = pd.json_normalize(data)
print("\nFlattened JSON columns:", list(flat.columns))
