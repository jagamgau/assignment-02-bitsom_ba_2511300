## Anomaly Analysis

**Insert Anomaly**  
In the current orders_flat.csv, information about customers is only stored when there is an order row. This means if a new customer registers (for example a future customer like C009) but has not placed any order yet, there is no way to store their name, email, or city without creating a fake order row. This is an insert anomaly because we cannot insert valid customer data unless an order also exists.

**Update Anomaly**  
Details about the same sales representative are repeated on many order rows. For example, sales rep SR01 (Deepak Joshi) appears on multiple rows, and the `office_address` field is repeated each time. In some rows it is written as "Mumbai HQ, Nariman Point, Mumbai - 400021" while in others it is slightly different like "Mumbai HQ, Nariman Pt, Mumbai - 400021". If the office address changes, we would have to update it in many rows, and if we miss one row the data for SR01 becomes inconsistent. This is an update anomaly.

**Delete Anomaly**  
All customer and sales rep details live inside the order rows. If a customer has only one order in the table and we delete that order row (for example to correct a mistake), we also lose the only copy of that customer’s name, email, city, and the related sales rep information. This is a delete anomaly because deleting a single order accidentally deletes important master data.

## Normalization Justification

At first, keeping everything in one big table like orders_flat.csv looks simpler because there is only a single file to open and no joins to think about. However, in practice this design quickly creates data quality problems and makes changes risky. In the current dataset, every row repeats customer details, product details, and sales representative details, so the same information is copied many times. For example, customer C001 “Rohan Mehta” with email “rohan@gmail.com” and city “Mumbai” appears on multiple rows, and sales rep SR01 “Deepak Joshi” with the Mumbai HQ office address is also repeated across many orders. If any value is typed differently on one row, or updated in only some rows, the data becomes inconsistent and we can no longer trust it.

Normalization fixes this by separating stable entities into their own tables. In my 3NF schema, customers, products, and sales reps each have a single source-of-truth row, while orders and order_items reference them with foreign keys. This structure eliminates the update anomaly where changing a sales rep’s office address would require editing dozens of order rows. It also removes the insert anomaly, because we can now add a new customer to the customers table even if they have not placed an order yet. Finally, it prevents the delete anomaly where deleting the last order for a customer would accidentally erase their master data. Although normalized schemas require joins in queries, the benefits in data integrity, reduced redundancy, and safer updates clearly outweigh the small added complexity. For a growing business with many orders, normalization is not over‑engineering; it is necessary engineering.
