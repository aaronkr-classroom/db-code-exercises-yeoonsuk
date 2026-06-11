-- CREATE TABLE

CREATE TABLE class_code (
    code INTEGER PRIMARY KEY,
    class VARCHAR(10),
    basis VARCHAR(20)
);

CREATE TABLE task_code (
    code INTEGER PRIMARY KEY,
    task VARCHAR(30)
);

CREATE TABLE customer (
    cus_id VARCHAR(15) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    cell VARCHAR(13) NOT NULL UNIQUE,
    addr VARCHAR(100),
    c_code INTEGER DEFAULT 3,
    FOREIGN KEY (c_code) REFERENCES class_code(code)
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    birthday INTEGER NOT NULL,
    tel VARCHAR(12),
    salary NUMERIC(9),
    t_code INTEGER NOT NULL,
    hire_date VARCHAR(8) NOT NULL,
    FOREIGN KEY (t_code) REFERENCES task_code(code)
);

ALTER TABLE staff
ALTER COLUMN tel TYPE VARCHAR(13);

CREATE TABLE tour (
    tour_num VARCHAR(8) PRIMARY KEY,
    departure VARCHAR(50) NOT NULL,
    arrival VARCHAR(50) NOT NULL,
    program VARCHAR(100),
    start_dt DATE NOT NULL,
    end_dt DATE NOT NULL,
    min_num INTEGER,
    max_num INTEGER,
    expense NUMERIC(7) NOT NULL,
    deposit NUMERIC(6),
    dept_yn VARCHAR(1) DEFAULT 'N',
    staff_id INTEGER,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE reserve (
    cus_id VARCHAR(15),
    tour_num VARCHAR(8),
    res_date DATE DEFAULT CURRENT_DATE,
    dep_yn VARCHAR(1) DEFAULT 'N',
    exp_yn VARCHAR(1) DEFAULT 'N',
    PRIMARY KEY (cus_id, tour_num),
    FOREIGN KEY (cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num)
);

CREATE TABLE tour_bus (
    bus_id INTEGER PRIMARY KEY,
    seat INTEGER,
    del_year INTEGER
);

CREATE TABLE driver (
    driver_id INTEGER PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    birthday VARCHAR(6) NOT NULL,
    cell VARCHAR(13) NOT NULL,
    pay NUMERIC(5) DEFAULT 15000,
    cont_date VARCHAR(8),
    cont_term VARCHAR(8)
);

CREATE TABLE assign_driver (
    tour_num VARCHAR(8),
    driver_id INTEGER,
    work_hour INTEGER,
    PRIMARY KEY (tour_num, driver_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);

CREATE TABLE assign_bus (
    tour_num VARCHAR(8),
    bus_id INTEGER,
    PRIMARY KEY (tour_num, bus_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num),
    FOREIGN KEY (bus_id) REFERENCES tour_bus(bus_id)
);

CREATE INDEX tour_arrival_idx ON tour(arrival ASC);

CREATE INDEX driver_name_idx ON driver(name ASC);
--INSERT INTO VALUES
-- class_code
INSERT INTO class_code VALUES (1, '최우수', '연 누적금액 500만');
INSERT INTO class_code VALUES (2, '우수', '연 누적금액 300만');
INSERT INTO class_code VALUES (3, '일반', '기본 회원');
INSERT INTO class_code VALUES (4, '골드', '연 누적금액 100만');
INSERT INTO class_code VALUES (5, '실버', '신규 가입 회원');

SELECT * FROM class_code;

-- task_code
INSERT INTO task_code VALUES (1, '여행상품관리');
INSERT INTO task_code VALUES (2, '예약관리');
INSERT INTO task_code VALUES (3, '관광버스배차관리');
INSERT INTO task_code VALUES (4, '직원관리');
INSERT INTO task_code VALUES (5, '고객관리');

SELECT * FROM task_code;

-- customer
INSERT INTO customer (cus_id, name, cell, addr, c_code) VALUES ('user01', '김철수', '010-1111-1111', '서울시 강남구', 1);
INSERT INTO customer (cus_id, name, cell, addr, c_code) VALUES ('user02', '이영희', '010-2222-2222', '서울시 서초구', 2);
INSERT INTO customer (cus_id, name, cell, addr, c_code) VALUES ('user03', '박민수', '010-3333-3333', '부산시 해운대구', 3);
INSERT INTO customer (cus_id, name, cell, addr, c_code) VALUES ('user04', '최지우', '010-4444-4444', '대구시 중구', 3);
INSERT INTO customer (cus_id, name, cell, addr, c_code) VALUES ('user05', '정동건', '010-5555-5555', '광주시 북구', 1);

SELECT * FROM customer;

-- staff
INSERT INTO staff VALUES (10001, '홍길동', 850101, '010-9999-1111', 3500000, 1, '20150301');
INSERT INTO staff VALUES (10002, '김미영', 900512, '010-8888-2222', 3200000, 2, '20180401');
INSERT INTO staff VALUES (10003, '이순신', 820815, '010-7777-3333', 4000000, 3, '20120101');
INSERT INTO staff VALUES (10004, '강감찬', 881225, '010-6666-4444', 3800000, 4, '20160901');
INSERT INTO staff VALUES (10005, '유관순', 950301, '010-5555-5555', 2900000, 5, '20200101');

SELECT * FROM staff;

-- tour
INSERT INTO tour VALUES ('T260601A', '서울', '부산', 'http://tour.com/busan', '2026-06-10', '2026-06-12', 10, 40, 250000, 50000, 'Y', 10001);
INSERT INTO tour VALUES ('T260602B', '서울', '제주', 'http://tour.com/jeju', '2026-07-01', '2026-07-03', 15, 30, 450000, 100000, 'N', 10001);
INSERT INTO tour VALUES ('T260603C', '부산', '강릉', 'http://tour.com/gang', '2026-08-15', '2026-08-17', 20, 40, 300000, 60000, 'N', 10001);
INSERT INTO tour VALUES ('T260604D', '대구', '여수', 'http://tour.com/yeosu', '2026-09-10', '2026-09-11', 10, 20, 180000, 30000, 'Y', 10001);
INSERT INTO tour VALUES ('T260605E', '서울', '경주', 'http://tour.com/kyung', '2026-10-03', '2026-10-05', 25, 45, 220000, 40000, 'Y', 10001);

SELECT * FROM tour;

-- driver
INSERT INTO driver VALUES (5001, '김운전', '750202', '010-1234-5678', 18000, '20200101', '24');
INSERT INTO driver VALUES (5002, '박베스트', '801111', '010-2345-6789', 16000, '20210301', '12');
INSERT INTO driver VALUES (5003, '이안전', '850505', '010-3456-7890', 15000, '20230501', '12');
INSERT INTO driver VALUES (5004, '최스피드', '780909', '010-4567-8901', 17000, '20191001', '36');
INSERT INTO driver VALUES (5005, '정방어', '821212', '010-5678-9012', 15500, '20220201', '24');

SELECT * FROM driver;

-- reserve
INSERT INTO reserve VALUES ('user01', 'T260601A', '2026-05-01', 'Y', 'N');
INSERT INTO reserve VALUES ('user02', 'T260601A', '2026-05-05', 'Y', 'Y');
INSERT INTO reserve VALUES ('user03', 'T260602B', '2026-05-10', 'Y', 'N');
INSERT INTO reserve VALUES ('user04', 'T260603C', '2026-05-15', 'N', 'N');
INSERT INTO reserve VALUES ('user05', 'T260604D', '2026-05-20', 'Y', 'Y');

SELECT * FROM reserve;

-- assign_driver
INSERT INTO assign_driver VALUES ('T260601A', 5001, 16);
INSERT INTO assign_driver VALUES ('T260602B', 5002, 24);
INSERT INTO assign_driver VALUES ('T260603C', 5003, 16);
INSERT INTO assign_driver VALUES ('T260604D', 5004, 10);
INSERT INTO assign_driver VALUES ('T260605E', 5005, 18);

SELECT * FROM assign_driver;

-- 필수 테스트 항목
-- 1. 고객 등급 검색
SELECT c.name AS "이름", cc.class AS "등급"
FROM customer c
JOIN class_code cc ON c.c_code = cc.code
WHERE c.cus_id = 'user01';

-- 2. 직원 담당업무 검색
SELECT s.name AS "이름", tc.task AS "담당업무"
FROM staff s
JOIN task_code tc ON s.t_code = tc.code
WHERE s.staff_id = 10001;

-- 3. 여행상품 예약 고객 검색
SELECT c.name AS "고객명", r.res_date AS "예약일자", r.dep_yn AS "예약금결제여부"
FROM reserve r
JOIN customer c ON r.cus_id = c.cus_id
WHERE r.tour_num = 'T260601A';

-- 4. 여행상품 배정 운전기사 검색
SELECT t.departure AS "출발지", d.name AS "기사이름", d.cell AS "휴대폰번호"
FROM assign_driver ad
JOIN tour t ON ad.tour_num = t.tour_num
JOIN driver d ON ad.driver_id = d.driver_id
WHERE ad.tour_num = 'T260601A';

-- 5. 신규 고객 등록
INSERT INTO customer (cus_id, name, cell, addr)
VALUES ('newuser99', '정신규', '010-9999-0000', '충청북도 충주시');

SELECT cus_id FROM customer WHERE name='정신규';

-- 6. 직원 급여 수정
UPDATE staff
SET salary = salary + 200000
WHERE staff_id = 10001;

SELECT salary FROM staff WHERE staff_id = 10001;

-- 7. 예약 정보 삭제
DELETE FROM reserve
WHERE cus_id = 'user04' AND tour_num = 'T260603C';

SELECT * FROM reserve WHERE cus_id = 'user04';