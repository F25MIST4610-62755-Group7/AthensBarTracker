# The Bar

## Team Members


Elizabeth Mullinax, [ellievoir](<https://github.com/orgs/F25MIST4610-62755-Group7/people/ellievoir>)

Josie Rowe, [jlr75202](<https://github.com/orgs/F25MIST4610-62755-Group7/people/jlr75202>)

Bradford Moye, [bradfordmoye](<https://github.com/orgs/F25MIST4610-62755-Group7/people/bradfordmoye>)

Harry Tear, [harryt4](<https://github.com/orgs/F25MIST4610-62755-Group7/people/harryt4>)

Ethan Rausch, [ear35971](<https://github.com/orgs/F25MIST4610-62755-Group7/people/ear35971>)



## Scenario Description


The **`ns_F25MIST4610_62755_Group7`** database is an operational management system for a bar or restaurant that tracks daily activities such as orders, ingredient usage, staff shifts, vendor purchases, and payments. It connects all aspects of operations—from drinks served to inventory consumed—to help managers monitor performance, control costs, and make data-driven decisions for smoother, more efficient business management.

A restaurant company has asked us to create a data model to record daily activities such as orders, ingredient usage, staff shifts, vendor purchases, payments, clients, and client feedback of its bars at various locations. Every location is open from 4pm - 2am. For each bartender, the client wants to record details about who supervises who, how much tips each bartender makes, and how many drinks they’ve made. Supervisors can earn tips and make drinks. Each bartender can only work at one location. Tips are sent directly to the bartender who took and prepared the order via the payment entity. For each drink, the client wants to track how many ingredients are supposed to be used in each drink (ie. a recipe.) Each night the alcohol is weighed to understand how much alcohol was actually used that day. Customers have the option of answering a customer satisfaction survey rating the atmosphere, service, and staff on a 5-star scale and make any additional comments every time they close out their tab.

## Datamodel PNG

<img width="911" height="1140" alt="SQL_Model_v5" src="https://github.com/user-attachments/assets/c03bbaa5-24a1-4f40-8eb1-2d1dd163898d" />

## Data Dictionary

---

### Table: Clients

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| clientID | Client identifier | INT | - |  | **PK** |
| clientFName | Client first name | VARCHAR | 45 |  |  |
| ClientLName | Client last name | VARCHAR | 45 |  |  |

---

### Table: ConsumptionLog

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| consumptionID | Consumption record identifier | INT | - |  | **PK** |
| consumptionDate | Date the consumption occurred | DATE | - | MM/DD/YYYY |  |
| total_amtUsed | What amount of the product was used | DECIMAL | 10,2 |  |  |
| amtMetric | Unit of measure for amtUsed (oz or grams) | VARCHAR | 45 |  |  |
| ingredientID | Linked ingredient identifier | INT | - |  | **FK** |

---

### Table: DrinkMenu

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| drinkID | Drink identifier | INT | - |  | **PK** |
| drinkName | Name of the drink | VARCHAR | 45 |  |  |
| retailPrice | Retail price of the drink | DECIMAL | 5,2 |  |  |
| is_active | Is the item currently on the menu; 0 = FALSE, 1 = TRUE | BIT | 1 |  |  |

---

### Table: Drink_has_Ingredients

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| drinkID | Linked drink identifier | INT | - |  | **FK** |
| ingredientID | Linked ingredient identifier | INT | - |  | **FK** |
| drink_amtUsed | Amount of ingredient used per drink | DECIMAL | 10,2 |  |  |

---

### Table: Employees

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| employeeID | Employee identifier | INT | - |  | **PK** |
| employeeFName | Employee first name | VARCHAR | 45 |  |  |
| employeeLName | Employee last name | VARCHAR | 45 |  |  |
| employeePosition | Employee position or title | VARCHAR | 45 |  |  |
| supervisorID | Supervisor employee identifier | INT | - |  | **FK** |
| locationID | Location identifier where employee works | INT | - |  | **FK** |

---

### Table: Feedback

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| feedbackID | Feedback record identifier | INT | - |  | **PK** |
| atmosphereSatisfaction | Rating for atmosphere | INT | - |  |  |
| drinkSatisfaction | Rating for drinks | INT | - |  |  |
| staffSatisfaction | Rating for staff | INT | - |  |  |
| comments | Free-text comments | MEDIUMTEXT | - |  |  |
| orderID | Linked order identifier | INT | - |  | **FK** |

---

### Table: Ingredients

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| ingredientID | Ingredient identifier | INT | - |  | **PK** |
| ingredientName | Name of the ingredient | VARCHAR | 45 |  |  |
| weightPerCase | Weight per case | INT | - |  |  |
| weightMetric | Unit for weightPerCase | VARCHAR | 45 |  |  |
| casePrice | Price per case | DECIMAL | 10,2 |  |  |
| vendorID | Vendor identifier supplying ingredient | INT | - |  | **FK** |

---

### Table: LineItem

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| lineItemID | Line item identifier | INT | - |  | **PK** |
| qtyOrdered | Quantity ordered for this line item | INT | - |  |  |
| orderID | Linked order identifier | INT | - |  | **FK** |
| drinkID | Linked drink identifier from menu | INT | - |  | **FK** |

---

### Table: Locations

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| locationID | Location identifier | INT | - |  | **PK** |
| locName | Location name | VARCHAR | 45 |  |  |
| locAddress | Location address | VARCHAR | 45 |  |  |

---

### Table: Orders

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| orderID | Order identifier | INT | - |  | **PK** |
| orderTime | Date and time of order | DATETIME | - | MM/DD/YYYY HH:MM:SS |  |
| clientID | Linked client identifier | INT | - |  | **FK** |
| employeeID | Linked employee identifier (who took/served) | INT | - |  | **FK** |
| paymentID | Linked payment identifier for the order | INT | - |  | **FK** |

---

### Table: Payments

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| paymentID | Payment identifier | INT | - |  | **PK** |
| paymentTime | When the client's tab was closed out | DATETIME | - | MM/DD/YYYY HH:MM:SS |  |
| paymentMethod | Payment method used (cash or card) | VARCHAR | 45 |  |  |
| paymentBaseAmt | Cost of the drink plus taxes (excludes tip) | DECIMAL | 10,2 |  |  |
| paymentTips | Tip amount | DECIMAL | 10,2 |  |  |

---

### Table: PurchaseLog

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| purchaseID | Purchase record identifier | INT | - |  | **PK** |
| purchaseDate | Date of purchase | DATE | - | MM/DD/YYYY |  |
| purchaseType | Indicates if purchase is as-needed or recurring | VARCHAR | 45 |  |  |
| casesPurchased | How many cases of the ingredient were purchased | INT | - |  |  |
| purchaseAmt | Total amount spent on purchase | DECIMAL | 10,2 |  |  |
| ingredientID | Linked ingredient identifier | INT | - |  | **FK** |

---

### Table: ShiftLog

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| shiftID | Shift record identifier | INT | - |  | **PK** |
| startTime | Shift start date and time | DATETIME | - | MM/DD/YYYY HH:MM:SS |  |
| endTime | Shift end date and time | DATETIME | - | MM/DD/YYYY HH:MM:SS |  |
| basePay | Earnings from hourly wages | DECIMAL | 10,2 |  |  |
| tipsPay | How much was earned in tips | VARCHAR | 45 |  |  |
| employeeID | Linked employee identifier | INT | - |  | **FK** |

---

### Table: Vendors

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| vendorID | Vendor identifier | INT | - |  | **PK** |
| vendorName | Vendor name | VARCHAR | 45 |  |  |
| vendorWebsite | Vendor website | VARCHAR | 45 |  |  |

## Queries, Justifications, and Results

### Measure of Bartender Popularity

```
 SELECT 
  CONCAT(Employees.employeeFName,' ', Employees.employeeLName) AS Bartender, 
  SUM(Payments.paymentTips) / 
    (SQRT(SUM(LineItem.qtyOrdered)) * 
     SUM(TIMESTAMPDIFF(HOUR, ShiftLog.startTime, ShiftLog.endTime))) AS Popularity
FROM Employees
JOIN ShiftLog ON Employees.employeeID = ShiftLog.employeeID 
JOIN Orders ON Employees.employeeID = Orders.Employees_employeeID
JOIN LineItem ON Orders.orderID = LineItem.orderID
JOIN Payments ON Payments.paymentID = Orders.Payments_paymentID 
WHERE Employees.employeePosition = "Bartender" OR "Bar Supervisor" 
GROUP BY Employees.employeeFName, Employees.employeeLName
ORDER BY Popularity DESC;
```

To measure the popularity of each bartender, we used the amount of tips earned and then divided it by the square root of drinks served multiplied by the number of hours worked. This is because although tips show how likable a bartender is, the number of tips a bartender earns can be inflated by their working longer than other bartenders or serving more drinks overall. This shows bar managers which of their best-performing bartenders are.

### Where do we experience the most ingredient shrinkage?

```

WITH ExpectedConsumption AS (
SELECT Ingredients.ingredientID, Ingredients.ingredientName, SUM(LineItem.qtyOrdered*(Drink_has_Ingredients.drink_amtUsed*(Ingredients.casePrice/Ingredients.weightPerCase))) AS DrinksCost
FROM Drink_has_Ingredients
JOIN Ingredients ON Drink_has_Ingredients.ingredientID = Ingredients.ingredientID
JOIN LineItem ON Drink_has_Ingredients.drinkID = LineItem.DrinkMenu_drinkID
GROUP BY Ingredients.ingredientID, Ingredients.ingredientName) 
SELECT Ingredients.ingredientName, SUM(ConsumptionLog.total_amtUsed) - ExpectedConsumption.DrinksCost AS Shrinkage
FROM Ingredients
JOIN ExpectedConsumption ON Ingredients.ingredientID = ExpectedConsumption.ingredientID
JOIN ConsumptionLog ON Ingredients.ingredientID = ConsumptionLog.ingredientID
GROUP BY Ingredients.ingredientName, ExpectedConsumption.DrinksCost;

```

Ingredient shrinkage refers to the difference between how much of an ingredient we expect to use based on drinks served vs how much of each ingredient was actually used. This shows us how many unnecessary inventory losses bars are experiencing, if any. Some loss is normal, as spills or other accidents happen. However, this can also be a great indicator of theft. Other times, bartenders will intentionally pour more alcohol than they are allowed to earn more tips, a practice known as overpouring.

### Which drinks have a higher-than-average number of orders?

```

SELECT
  DrinkMenu.drinkName,
  DrinkMenu.retailPrice,
  COUNT(LineItem.orderID) AS timesOrdered
FROM DrinkMenu
JOIN LineItem
  ON LineItem.DrinkMenu_drinkID = DrinkMenu.drinkID
GROUP BY DrinkMenu.drinkID, DrinkMenu.drinkName, DrinkMenu.retailPrice
HAVING timesOrdered >
  (SELECT AVG(cnt)
   FROM (SELECT COUNT(*) AS cnt
         FROM LineItem
         GROUP BY DrinkMenu_drinkID) x)
ORDER BY timesOrdered DESC;

```

Bars often want to know their highest-performing menu items. We select the drink name, price, and the number of times it has been ordered. Then, we filter the results to only the top 50%.

### Which vendor do we do the most business with?

```

WITH vendor_totals AS (
  SELECT
    Vendors.vendorName,
    SUM(CAST(purchaseAmt AS DECIMAL(10,2))) AS total_spent
  FROM Vendors
  JOIN Ingredients ON Vendors.vendorID = Ingredients.Vendors_vendorID
  JOIN PurchaseLog ON PurchaseLog.ingredientId = Ingredients.ingredientID
  GROUP BY Vendors.vendorName
)
SELECT
  vendorName,
  total_spent
FROM vendor_totals
WHERE total_spent > 
	(SELECT AVG(total_spent)
    FROM vendor_totals)
ORDER BY total_spent DESC;

```

It's useful to know which vendors you work with the most. First we find the total spend with each vendor by summing all transactions. Next, we select vendors with a total spend higher than the average.

### Which employee worked the most shifts?

```

WITH EmployeeHours AS (
	SELECT Employees.employeeID AS empId, (endTime - startTime) AS hoursWorked
	FROM ShiftLog
	JOIN Employees ON Employees.employeeID = ShiftLog.employeeID
	GROUP BY Employees.employeeID, Employees.employeeFName, Employees.employeeLName, hoursWorked
    )
SELECT Employees.employeeID, CONCAT(Employees.employeeFName,' ', Employees.employeeLName) AS Employee, COUNT(hoursWorked) AS totalHoursWorked
FROM EmployeeHours
JOIN Employees ON EmployeeHours.empId = Employees.employeeID
GROUP BY Employees.employeeID, Employee
ORDER BY totalHoursWorked DESC;

```

### How frequently do ingredients appear in our recipes?

```

SELECT Ingredients.ingredientName, COUNT(Drink_has_Ingredients.ingredientID) AS RecipesUsing
FROM Ingredients
JOIN Drink_has_Ingredients ON Ingredients.ingredientID = Drink_has_Ingredients.ingredientID
GROUP BY Ingredients.ingredientName
ORDER BY RecipesUsing;
```

### When does the bar have the most sales?

```

SELECT 
 DAYNAME(Orders.orderTime) AS Weekday,
  CASE
    WHEN TIME(Orders.orderTime) BETWEEN '00:00:00' AND '02:00:00' THEN '12AM - 2AM'
    WHEN TIME(Orders.orderTime) BETWEEN '21:00:00' AND '23:59:59' THEN '9PM - 12AM'
    WHEN TIME(Orders.orderTime) BETWEEN '16:00:00' AND '20:59:59' THEN '4PM - 9PM'
    ELSE 'Undefined'
  END AS `Time of Day`, 
  SUM(LineItem.qtyOrdered) AS Sold
FROM LineItem
JOIN Orders ON Orders.orderID = LineItem.orderID
GROUP BY 
  DAYNAME(Orders.orderTime),
  CASE
    WHEN TIME(Orders.orderTime) BETWEEN '00:00:00' AND '02:00:00' THEN '12AM - 2AM'
    WHEN TIME(Orders.orderTime) BETWEEN '21:00:00' AND '23:59:59' THEN '9PM - 12AM'
    WHEN TIME(Orders.orderTime) BETWEEN '16:00:00' AND '20:59:59' THEN '4PM - 9PM'
    ELSE 'Undefined'
  END
ORDER BY Sold;

```

### How many people does each supervisor manage?

```

SELECT sup.employeeID AS supervisorId, sup.employeeFName, sup.employeeLName, COUNT(emp.employeeId) AS NumEmpManaged
FROM Employees emp
JOIN Employees sup ON sup.employeeID = emp.supervisorID
GROUP BY supervisorId, sup.employeeFName, sup.employeeLName
ORDER BY NumEmpManaged DESC;

```

### List the first and last name of bartenders, where they work, and the number of orders they have received from most to least.

```
SELECT CONCAT(Employees.employeeFName,' ', Employees.employeeLName) AS Employee, locName, COUNT(orderID)
FROM Employees
JOIN Locations ON Locations.locationID = Employees.Locations_locationID
JOIN Orders ON Employees.employeeID = Orders.Employees_employeeID
GROUP BY employeeFName, employeeLName, locName
ORDER BY COUNT(orderID);

```

### List the average rating of ordered items, staff, and atmosphere and the overall bar rating.

```

SELECT 
    ROUND(AVG(drinkSatisfaction), 2) AS drink_rating,
    ROUND(AVG(staffSatisfaction), 2) AS staff_rating,
    ROUND(AVG(atmosphereSatisfaction), 2) AS atmosphere_rating,
    ROUND((AVG(drinkSatisfaction) + AVG(staffSatisfaction) + AVG(atmosphereSatisfaction)) / 3.0, 2) AS overall_rating
FROM Feedback;

```

## Technology Usage Disclaimer


The [“Markdown Format report schema” MySQL Workbench plugin by tmsanchez on GitHub](<https://github.com/tmsanchez/workbenchscripts>) was used to create the initial draft of the data dictionary. Copilot AI was then used to: alter the column names to match the format seen in “**MIST 4610 DB Dictionary”** on the ELC**,** update datatypes, and fill the format column. [Claude.ai](<http://Claude.ai>) was used to generate dummy data.
