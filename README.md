# Brazilian E-Commerce SQL Analysis

## Overview

This project analyses the Brazilian E-Commerce Public Dataset by Olist using MySQL and SQL.

The analysis focuses on sales performance, customer behaviour, delivery performance, payment methods, seller performance and other business-related insights.

## Objectives

- Analyse e-commerce sales performance
- Explore customer purchasing behaviour
- Analyse payment methods
- Investigate delivery performance
- Examine customer review scores
- Analyse sales by customer and seller location
- Identify top-selling product categories and sellers
- Explore order composition and freight costs

## Dataset

The project uses the Brazilian E-Commerce Public Dataset by Olist.

The dataset contains anonymised e-commerce data from approximately 100,000 orders between 2016 and 2018.

Dataset source:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The raw dataset is not included in this repository.

## Database

**Database:** MySQL  
**Database name:** `ecommerce_analysis`

The analysis uses the following tables:

- customers
- orders
- order_items
- order_payments
- products
- sellers
- order_reviews
- geolocation

## SQL Analysis

The project contains 17 SQL analyses covering:

- Order status distribution
- Total product sales
- Monthly sales
- Top product categories
- Average order value
- Payment methods
- Repeat customers
- Repeat customer percentage
- Average delivery time
- Average review score
- Review score by delivery status
- Late delivery percentage
- Sales by customer state
- Top sellers by sales
- Sales by seller state
- Freight as a percentage of product sales
- Multi-item orders

## Key Findings

Some key findings from the analysis include:

- Total product sales were 13,591,643.70.
- The average product value per delivered order was 137.04.
- Repeat customers represented 3.12% of customers.
- Average delivery time for delivered orders was 12.50 days.
- The average review score was 4.09 out of 5.
- 8.11% of delivered orders were classified as late.
- Late deliveries had an average review score of 2.57, compared with 4.29 for on-time deliveries.
- Credit card payments represented 78.34% of total payment value.
- Freight value represented 16.57% of product sales.
- 9.86% of orders contained more than one item.

## Technologies

- MySQL
- SQL
- MySQL Workbench

## Author

Thushani Parasuraman
3rd-Year Applied Data Science Student
