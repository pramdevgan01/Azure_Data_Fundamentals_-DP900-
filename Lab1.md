# Experiment No. 1
> Classify Datasets as Structured, Semi-Structured, or Unstructured with Justification

## Aim / Objective: 
To examine different sample datasets, classify each as structured, semi-structured, or unstructured data, and justify the classification based on schema, format, and storage characteristics.

## Theory / Background: 
Data is broadly categorized by how strictly it follows a schema. Structured data conforms to a fixed, predefined schema of rows and columns (e.g., relational tables, CSV files) and is easily queried with SQL. Semi-structured data does not fit a rigid tabular model but carries self-describing tags or keys that define its structure (e.g., JSON, XML, YAML); the schema can vary from record to record. Unstructured data has no predefined data model at all (e.g., images, audio, video, free-form text) and typically requires specialized processing such as AI/ML or full-text indexing to extract meaning. Correct classification determines the appropriate storage service (SQL database, document database, or blob/object storage) and the analytical approach.

## Procedure / Steps:
1.  Collect at least six sample files: [students.csv](resources/lab1/students.csv), [orders.json](resources/lab1/orders.json), [catalog.xml](resources/lab1/catalog.xml), [photo.jpg](resources/lab1/photo.jpg), [theater.mp4](resources/lab1/theater.mp4), and [notes.txt](resources/lab1/notes.txt).
2.  Open [students.csv](resources/lab1/students.csv) in Excel; observe fixed columns and consistent rows.
3.  Open [orders.json](resources/lab1/orders.json) and [catalog.xml](resources/lab1/catalog.xml) in a text editor; observe key--value pairs / tags and note that fields may differ between records.
4.  Attempt to open [photo.jpg](resources/lab1/photo.jpg) and [theater.mp4](resources/lab1/theater.mp4) in a text editor; observe that no readable schema exists.
5.  Read [notes.txt](resources/lab1/notes.txt); note that although readable, it has no formal field structure.
6.  Prepare a classification table listing each file, its category, the justification, and the most suitable Azure storage service.
7.  Record observations and conclusions in the lab record.


## Sample Code / Data Used:

### [students.csv](resources/lab1/students.csv) (Structured)
```csv  
    RollNo,Name,Branch,CGPA
    101,Aarav Sharma,AIML,8.9
    102,Diya Verma,AIML,9.1
    103,Rohan Mehta,CSE,8.4
    104,Ananya Iyer,CSE,9.3
```
### [orders.json](resources/lab1/orders.json) (Semi-structured)
```json
{
    "orderId": 5001,
    "customer": "Aarav Sharma",
    "city": "Pune",
    "items": [
      { "sku": "A10", "qty": 2 }
    ],
    "giftWrap": true
  },
  {
    "orderId": 5002,
    "customer": "Diya Verma",
    "city": "Bengaluru",
    "items": [
      { "sku": "B21", "qty": 1 },
      { "sku": "C15", "qty": 3 }
    ],
    "paymentMode": "UPI"
  },
```

### [catalog.xml](resources/lab1/catalog.xml) (Semi-structured) 
```xml
    <product id="A10">
        <name>Wireless Mouse</name>
        <price>499</price>
        <brand>Zebronics</brand>
    </product>
    <product id="B21">
        <name>Mechanical Keyboard</name>
        <price>2199</price>
        <brand>Ant Esports</brand>
        <color>Black</color>
    </product>
```

### [photo.jpg](resources/lab1/photo.jpg)(Un-structured)

![photo](resources/lab1/photo.jpg "Sunset")

### [photo.jpg](resources/lab1/theater.mp4)(Un-structured)
<video width="600" controls>
  <source src="/resources/lab1/theater.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

### [notes.txt](resources/lab1/notes.txt) (Un-structured)
```txt
Meeting notes - Orientation Week

Spoke with Aarav Sharma and Diya Verma today about the new student onboarding
process for the AIML batch. They mentioned that a few students, including
Rohan Mehta, are still waiting for their hostel allotment letters.

Ananya Iyer suggested we set up a WhatsApp group for the CSE branch so that
notices about lab schedules can be shared quickly. Kabir Singh volunteered
to be the class representative for ECE.

Reminder: Library orientation is scheduled for next Monday. Bring your ID
cards. Lab coats are mandatory for the AIML practical sessions starting
from the second week.

```


## Expected Output / Observations:
## Result / Conclusion:
## Learning Outcomes:
## Precautions / Cost Notes: