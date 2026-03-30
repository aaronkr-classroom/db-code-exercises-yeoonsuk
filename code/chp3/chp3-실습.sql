/* =========================================================
   주제: 온라인 쇼핑몰
   DBMS: PostgreSQL
   ========================================================= */


/* -- 1단계
[Entities / 개체]
- Customer
- Product
- Orders

[Customer Properties / 고객 속성]
- customer_id          (BIGSERIAL) -- 자동으로 증가하는 고객 번호
- customer_name        (TEXT)
- email                (TEXT)
- phone                (TEXT)
- join_date            (DATE)

[Product Properties / 상품 속성]
- product_id           (BIGSERIAL) -- 자동으로 증가하는 상품 번호
- product_name         (TEXT)
- category             (TEXT)
- price                (NUMERIC(10,2))
- stock                (INT)

[Orders Properties / 주문 속성]
- order_id             (BIGSERIAL) -- 자동으로 증가하는 주문 번호
- customer_id          (BIGINT) -- 고객 번호(FK)
- product_id           (BIGINT) -- 상품 번호(FK)
- quantity             (INT)
- order_date           (DATE)
*/


/* =========================================================
   2단계: 테이블 생성
   ========================================================= */

CREATE TABLE Customer (
    customer_id     BIGSERIAL PRIMARY KEY,
    customer_name   TEXT NOT NULL,
    email           TEXT NOT NULL UNIQUE,
    phone           TEXT NOT NULL,
    join_date       DATE NOT NULL
);

CREATE TABLE Product (
    product_id      BIGSERIAL PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL,
    price           NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock           INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE Orders (
    order_id        BIGSERIAL PRIMARY KEY,
    customer_id     BIGINT NOT NULL,
    product_id      BIGINT NOT NULL,
    quantity        INT NOT NULL CHECK (quantity > 0),
    order_date      DATE NOT NULL,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    CONSTRAINT fk_orders_product
        FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
);


/* =========================================================
   3단계: 각 테이블에 5개 이상 입력
   ========================================================= */

/* Customer 데이터 */
INSERT INTO Customer (customer_name, email, phone, join_date) VALUES
('김민수', 'minsu@example.com', '010-1111-1111', '2024-03-01'),
('이서연', 'seoyeon@example.com', '010-2222-2222', '2024-03-03'),
('박지훈', 'jihoon@example.com', '010-3333-3333', '2024-03-05'),
('최유진', 'yujin@example.com', '010-4444-4444', '2024-03-07'),
('정다은', 'daeun@example.com', '010-5555-5555', '2024-03-10');


/* Product 데이터 */
INSERT INTO Product (product_name, category, price, stock) VALUES
('무선 마우스', '전자기기', 25000.00, 30),
('기계식 키보드', '전자기기', 70000.00, 15),
('노트북 거치대', '사무용품', 32000.00, 20),
('USB 메모리 64GB', '전자기기', 18000.00, 50),
('스마트폰 케이스', '액세서리', 15000.00, 40);


/* Orders 데이터 */
INSERT INTO Orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 2, '2024-04-01'),
(2, 2, 1, '2024-04-02'),
(3, 4, 3, '2024-04-03'),
(4, 3, 1, '2024-04-04'),
(5, 5, 2, '2024-04-05');


/* =========================================================
   4단계: SQL 작성
   - 전체 조회
   - ORDER BY
   - WHERE
   ========================================================= */

/* 1. 전체 조회 */
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;


/* 2. 정렬 */
SELECT * 
FROM Product
ORDER BY price DESC;

SELECT *
FROM Customer
ORDER BY join_date ASC;


/* 3. 조건 검색 */
SELECT *
FROM Product
WHERE price >= 20000;

SELECT *
FROM Orders
WHERE quantity >= 2;


/* =========================================================
   5단계: 추가 조회 (JOIN)
   ========================================================= */

SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    o.order_date
FROM Orders o
JOIN Customer c
    ON o.customer_id = c.customer_id
JOIN Product p
    ON o.product_id = p.product_id
ORDER BY o.order_id;
