# Azure Data Fundamentals (DP-900) — Lab Manual

A hands-on lab manual for the **Microsoft Certified: Azure Data Fundamentals (DP-900)** course. Each experiment pairs a short theory recap with a practical exercise using sample data, so concepts like structured vs. semi-structured vs. unstructured data, relational vs. non-relational storage, and Azure data services can be explored directly rather than just read about.

## Repository Structure

```
DP_900/
├── Lab1.md              # Experiment 1
├── Lab2.md              # Experiment 2
├── Lab3.md              # Experiment 3
├── Lab4.md              # Experiment 4 (WIP)
├── resources/
│   ├── lab1/            # Sample data files used in Experiment 1
│   ├── lab2/            # Sample data files used in Experiment 2
│   └── lab3/            # Sample data files used in Experiment 3
├── images/              # Diagrams / screenshots referenced by labs
│   ├── lab2/            # Supporting diagram used in Experiment 2
│   └── lab4/            # Step-by-step Azure Portal screenshots for Experiment 4
└── README.md
```

Each `LabN.md` follows a consistent format:

- **Aim / Objective**
- **Theory / Background**
- **Procedure / Steps**
- **Sample Code / Data Used** — linked directly to files in `resources/labN/`
- **Expected Output / Observations**
- **Result / Conclusion**
- **Learning Outcomes**
- **Precautions / Cost Notes**

## Experiments

| # | Experiment | Status |
|---|------------|--------|
| 1 | [Classify Datasets as Structured, Semi-Structured, or Unstructured](Lab1.md) | ✅ Complete |
| 2 | [Compare Transactional vs Analytical Workloads Using Sample Scenarios](Lab2.md) | ✅ Complete |
| 3 | [Load CSV and JSON Files into a Local Environment and Analyze Structure](Lab3.md) | ✅ Complete |
| 4 | Create Tables and Perform Basic SQL Queries in Azure SQL Database | 🚧 In progress |
| 5–10 | Experiments 5–10 | 🚧 Planned |

> **Note:** `Lab4.md`–`Lab10.md` are currently listed in [`.gitignore`](.gitignore) while under development and are not yet tracked in this repository.

## How to Use

1. Open a `LabN.md` file to read the objective, theory, and procedure.
2. Follow the linked sample files under `resources/` to reproduce the exercise locally (e.g., open `students.csv` in Excel, inspect `orders.json` / `catalog.xml` in a text editor).
3. Fill in the **Expected Output / Observations**, **Result / Conclusion**, and **Learning Outcomes** sections in your own copy as you complete each lab.

## Course Reference

Based on the [Microsoft Azure Data Fundamentals (DP-900)](https://learn.microsoft.com/en-us/credentials/certifications/azure-data-fundamentals/) certification syllabus.
