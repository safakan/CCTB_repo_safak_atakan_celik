Explanatory Document url: https://docs.google.com/document/d/1pacUTQM3uV27mq45Sx3ukP2tUg4tpMLzl_D-47k5xtY/edit?tab=t.0



msc notes
- To constraint or not to contsraint: PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL
- The composite key makes sure unique pairs within junction tables
- Invoice ids are identical to the order ids -- this is how 1:1 rels formed here
- there's too much manual parsing when documenting cardinalities
- how to zip via powershell:
    - Compress-Archive -Path '.\Assignment2' -DestinationPath '.\Assignment2.zip'



Improve points:
- Addresses, different users can share the same address in time, redundancy with current design.
- Loosing data if users delete CASCADE
- Instead of orders_and_books, we can use orders_and_products, and keep the orders table agnostic of the type of the product.
- No historical records for status changes
- Predefined values are not enforced for the status fields
- Should change some of the TEXT types to VARCHAR with an educated guess. Precision for NUMERIC types?
- auth
- Payment strategy
- Delivery strategy
