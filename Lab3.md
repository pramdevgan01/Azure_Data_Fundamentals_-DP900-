# Experiment No. 3
> Load CSV and JSON Files into a Local Environment and Analyze Structure

## Aim / Objective:
To load CSV and JSON files into a local Python environment using pandas and the built-in `json` module, and analyze their structural characteristics — columns, data types, record count, and nesting — in order to compare how structured and semi-structured data are represented in code.

## Requirements / Tools Used:
A computer with Python 3 installed, the `pandas` library (`pip install pandas`), a text editor or IDE (e.g., VS Code), and the sample `employees.csv` / `employees.json` files provided.

## Theory / Background:
**CSV (Comma-Separated Values)** is a flat, tabular, structured format — every line is a record, fields are separated by commas, and every row shares the same fixed set of columns. It maps naturally onto a relational table.

**JSON (JavaScript Object Notation)** is a semi-structured format built from key–value pairs, arrays, and nested objects. It does not require a fixed schema across records — one record may have an extra field, and values can themselves be nested objects (e.g., an `address`) or arrays (e.g., a list of `skills`) — relationships a flat CSV cannot express without flattening or repeating rows.

When loading data into a local environment for analysis, Python's `pandas` library provides `read_csv()` for tabular data, returning a DataFrame with a fixed set of columns and inferred dtypes. For hierarchical data, the built-in `json` module (`json.load()`) or `pandas.read_json()` returns nested dictionaries/lists, which can be flattened into a table using `pandas.json_normalize()` when needed. Recognizing this structural difference — fixed schema vs. self-describing/nested schema — is the first step toward choosing the right storage (relational vs. document database) or designing an ETL pipeline in Azure (e.g., Azure Data Factory copying CSV rows into Azure SQL Database vs. loading JSON documents into Azure Cosmos DB).

## Procedure / Steps:
1.  Set up a local Python environment and install pandas: `pip install pandas`.
2.  Collect the two sample files: [employees.csv](resources/lab3/employees.csv) and [employees.json](resources/lab3/employees.json).
3.  Load [employees.csv](resources/lab3/employees.csv) using `pandas.read_csv()` and inspect its shape, column names, and dtypes.
4.  Load [employees.json](resources/lab3/employees.json) using Python's `json` module and inspect the record count, the keys of each record, and any nested objects/arrays (`address`, `skills`).
5.  Run [analyze.py](resources/lab3/analyze.py) to print both structures and to flatten the JSON with `pandas.json_normalize()` for side-by-side comparison.
6.  Note differences: every CSV row shares one flat schema, while JSON records can vary in structure (e.g., record `E103` has an extra `certifications` field) and contain nested data.
7.  Document the schema of each file — columns + types for the CSV; key hierarchy for the JSON — and your observations in the lab record.

## Sample Code / Data Used:

### [employees.csv](resources/lab3/employees.csv) (Structured)
```csv
EmpID,Name,Department,Salary
E101,Aarav Sharma,Engineering,650000
E102,Diya Verma,Marketing,520000
E103,Rohan Mehta,Engineering,700000
E104,Ananya Iyer,Sales,480000
E105,Kabir Singh,HR,450000
```

### [employees.json](resources/lab3/employees.json) (Semi-structured)
```json
[
  {
    "empId": "E101",
    "name": "Aarav Sharma",
    "department": "Engineering",
    "salary": 650000,
    "address": { "city": "Pune", "state": "Maharashtra" },
    "skills": ["Python", "Azure", "SQL"]
  },
  {
    "empId": "E103",
    "name": "Rohan Mehta",
    "department": "Engineering",
    "salary": 700000,
    "address": { "city": "Hyderabad", "state": "Telangana" },
    "skills": ["Java", "Kubernetes"],
    "certifications": ["AZ-900", "AZ-104"]
  }
]
```

### [analyze.py](resources/lab3/analyze.py) (Loader / Structure Analyzer)
```python
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
```

## Expected Output / Observations:
## Result / Conclusion:
## Learning Outcomes:
## Precautions / Cost Notes:
