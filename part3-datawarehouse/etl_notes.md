## ETL Decisions

### Decision 1 — Standardize date formats
Problem:
One file, retail_transactions.csv, mixes up how dates look, like `29/08/2023`, then `12-12-2023`, or even `2023-02-05`. Because of that jumble, sorting entries by time hits a wall. The system could read certain dates as words rather than actual calendar points. Matching records for one single day gets messy when each entry writes it differently. Grouping anything by date becomes unreliable under those conditions.

Resolution:
From every incoming date string, I pulled just the day-month-year parts, reshaping each one into standard ISO layout: YYYY-MM-DD. That uniform version became the base for building a number code simply Y-M-D mashed together without separators, to act as main identifier inside dim_date. Inside that table, both polished dates and their matching number tags got stored side by side. These same markers later linked up with records in fact_sales so any look at time patterns, like sums per month or shifts across periods, stays aligned.

### Decision 2 — Normalize product categories
Problem:
Sometimes the word in the category spot shows up like electronics, sometimes Electronics, Grocery, or even Groceries, spelled different ways, mixed case. Using them straight from source means one actual group could appear as several separate ones downstream. Reports might then count the same type of item more than once, just because names look slightly off. That messes up totals without anyone noticing at first.

Resolution:
Starting fresh during ETL, each version of a category got matched to one clear label, like `Electronics`, `Clothing`, or either `Grocery` and `Groceries`. Only these tidy labels made it into `dim_product`. From there, `fact_sales` links back to that table, which means reports sort results using clean groups instead of jumbled original entries.

### Decision 3 - Handle missing or inconsistent store fields
Problem:
Some rows in the source file lack complete or correct store details, like empty entries for `store_city`. Because of that, linking data in the warehouse might fail. When facts connect to unclear store records, report accuracy drops. Mismatched locations make it hard to trust summaries based on stores. Incomplete fields create confusion later during analysis.

Resolution:
When pulling the data, I checked both store_name and store_city on every line. Where the shop name was clear, like `Bangalore MG` - I set the matching city using reliable references. If there was doubt about accuracy, those entries went into a separate error list or got tagged under a default “Unknown” location inside dim_store. The test records I added later included just those with full, matching details, meaning each store_key in fact_sales links to a proper entry in dim_store.