/* =========================================================
   과제명: 간단한 DB 설계 + 구현
   주제: 동아리 관리
   ========================================================= */


/* -- 1단계
[Entities / 개체]
- Club

[Properties / 속성]
- id                (BIGSERIAL) -- 자동으로 증가하는 동아리 번호
- name              (TEXT)
- category          (TEXT)
- president_name    (TEXT)
- member_count      (INT)
- created_date      (DATE)
*/


/* =========================================================
   2단계: 테이블 생성 (CREATE TABLE)
   ========================================================= */

CREATE TABLE Club (
    id               BIGSERIAL PRIMARY KEY,
    name             TEXT NOT NULL,
    category         TEXT NOT NULL,
    president_name   TEXT NOT NULL,
    member_count     INT NOT NULL CHECK (member_count >= 1),
    created_date     DATE NOT NULL
);


/* =========================================================
   3단계: 데이터 입력 (INSERT)
   5개 이상 입력
   ========================================================= */

INSERT INTO Club (name, category, president_name, member_count, created_date) VALUES
('코딩 동아리', '학술', '김민수', 25, '2023-03-10'),
('축구 동아리', '체육', '이서연', 30, '2022-09-01'),
('밴드 동아리', '예술', '박지훈', 18, '2021-05-15'),
('봉사 동아리', '사회', '최유진', 22, '2020-11-20'),
('사진 동아리', '취미', '정다은', 15, '2024-03-05');


/* =========================================================
   4단계: 쿼리 작성
   a. 전체 조회
   b. 정렬 (ORDER BY)
   c. 조건 검색 (WHERE)
   ========================================================= */

/* a. 전체 조회 */
SELECT *
FROM Club;


/* b. 회원 수 많은 순 정렬 */
SELECT *
FROM Club
ORDER BY member_count DESC;

/* 또는 동아리 생성일 빠른 순 정렬 */
SELECT *
FROM Club
ORDER BY created_date ASC;


/* c. 회원 수가 20명 이상인 동아리 조회 */
SELECT *
FROM Club
WHERE member_count >= 20;

/* category가 '학술'인 동아리 조회 */
SELECT *
FROM Club
WHERE category = '학술';