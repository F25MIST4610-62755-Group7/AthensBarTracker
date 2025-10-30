# MIST4610 62755 Group 7 Project

## Team Members


1. Elizabeth Mullinax, [ellievoir](<https://github.com/orgs/F25MIST4610-62755-Group7/people/ellievoir>)
2. Josie Rowe, [jlr75202](<https://github.com/orgs/F25MIST4610-62755-Group7/people/jlr75202>)
3. Bradford Moye, [bradfordmoye](<https://github.com/orgs/F25MIST4610-62755-Group7/people/bradfordmoye>)
4. Harry Tear, [harryt4](<https://github.com/orgs/F25MIST4610-62755-Group7/people/harryt4>)
5. Ethan Rausch, [ear35971](<https://github.com/orgs/F25MIST4610-62755-Group7/people/ear35971>)



## Scenario Description

The **`ns_F25MIST4610_62755_Group7`** database is an operational management system for a bar that tracks daily activities such as orders, ingredient usage, staff shifts, vendor purchases, and payments. It connects all aspects of operations—from drinks served to inventory consumed—to help managers monitor performance, control costs, and make data-driven decisions for smoother, more efficient business management.

We aim to analyze the operations of a single bar company across multiple locations to identify what drives profits and losses. By tracking drink orders, ingredient usage vs purchasing, and vendor behavior, we can assess cost efficiency, recipe profitability, and inventory strategy. Linking this to employee shifts, tips, and customer feedback allows us to evaluate staff performance and bar popularity. This integrated model supports data-driven improvements in profitability and customer experience. 

## Data Model

<img width="911" height="1140" alt="SQL_Model_v5" src="https://github.com/user-attachments/assets/c03bbaa5-24a1-4f40-8eb1-2d1dd163898d" />

Our model is based on the structure of a bar company with various locations. The primary focuses of the data model are the drinks costs and profits, employee performance, and overall bar popularity. 

To understand the drink costs and profits each ingredient purchase is recorded into a log at the time of purchase. Some purchases are made on a recurring bases, while others are made as-needed (ie. when they notice the stock is getting low) or bought in a rush (ie. when stock gets lower much faster than expected and more of an ingredient is needed before the vendor shipment can arrive.) Rush purchases are often much smaller, more expensive, and bought locally. Ingredients come in cases (also known as boxes) and can vary from alcohol to non-liquid items (ie. fruit, herbs, etc) that are mixed into drinks. Each ingredient ever purchased is stored in the ingredients table, alongside how much each case of the ingredient weighs, and the price of each case. 

Each night the alcohol is weighed to understand how much alcohol was actually used that day which is marked in the ConsumptionLog. The metric used to weigh the ingredient varies where liquid ingredients come in ml and non-liquids come in grams is stored in the amtMetric attribute, again in the weightMetric attribute of the Ingredients entity, and again in the drink_amtUsed attribute of the Drink_has_Ingredients entity. The Drink_has_ingredients entity which essentially stores how much of each ingredient is used for various drinks, a sort of recipe holder. This then goes onto the DrinkMenu entity where all drinks that could have been purchased at the bar are listed, some drinks are not currently on the menu hence returning a “FALSE” value in the is_active attribute. It’s important to store inactive drinks as some become active again during seasons, holidays, game days, etc.

The LineItem entity features how many of each drink is ordered per order. While the Orders entity recounts every order that is made and the time that it is ordered. At the end of the night, clients can close out their tab covering multiple orders with only one payment. The time of payment is recorded separately from the time the order is made. Clients also have the option of leaving feedback as they take their orders, rating their satisfaction with the atmosphere, drinks, and staff on a 1-5 scale as well as leaving any additional comments. 

With each order, the bartender (or bar supervisor) who takes the order from the client is also the one who mixes the drink and receives any tips that the client gives via the payment entity. Each employee can only work at one location hence the identifying relationship. There is one supervisor per location with multiple people under them as represented by the one-many relationship to and from the Employees entity. For each shift, the total amount that the employee made from their hourly wage is calculated as basePay while any tips earned (tipsPay) are calculated separately. Shifts are flexible and vary based on employee availability. Unlike some bars there is not a set time for 1st, 2nd, and 3rd shift.

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
| Locations_locationID | Location identifier where employee works | INT | - |  | **FK** |

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
| Vendors_vendorID | Vendor identifier supplying ingredient | INT | - |  | **FK** |

---

### Table: LineItem

| Column Name | Description | Data Type | Column Size | Format | Key |
| --- | --- | --- | --- | --- | --- |
| lineItemID | Line item identifier | INT | - |  | **PK** |
| qtyOrdered | Quantity ordered for this line item | INT | - |  |  |
| orderID | Linked order identifier | INT | - |  | **FK** |
| DrinkMenu_drinkID | Linked drink identifier from menu | INT | - |  | **FK** |

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
| Clients_clientID | Linked client identifier | INT | - |  | **FK** |
| Employees_employeeID | Linked employee identifier (who took/served) | INT | - |  | **FK** |
| Payments_paymentID | Linked payment identifier for the order | INT | - |  | **FK** |

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

## Queries and Justifications

*Complex*

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

*Simple*

### How frequently do ingredients appear in our recipes?

```

SELECT Ingredients.ingredientName, COUNT(Drink_has_Ingredients.ingredientID) AS RecipesUsing
FROM Ingredients
JOIN Drink_has_Ingredients ON Ingredients.ingredientID = Drink_has_Ingredients.ingredientID
GROUP BY Ingredients.ingredientName
ORDER BY RecipesUsing;
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


The [“Markdown Format report schema” MySQL Workbench plugin by tmsanchez on GitHub](<https://github.com/tmsanchez/workbenchscripts>) was used to create the initial draft of the data dictionary. Copilot AI was then used to: alter the column names to match the format seen in “**MIST 4610 DB Dictionary”** on the ELC, update datatypes, and fill the format column. [Claude.ai](<http://Claude.ai>) was used to generate dummy data and assisted in writing the scenario description. 
