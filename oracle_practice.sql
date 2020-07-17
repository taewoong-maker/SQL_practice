select 'hello' ||' world' from dual;

SELECT CONCAT(CONCAT('HELLO', ' WORLD!!'), '!!')
FROM DUAL;

SELECT 'HELLO' || ' WORLD' || '!!'
FROM DUAL
;

SELECT SUBSTR('HELLO WORLD!!', 3, 1) --�ڹٿ� �޸� �Ǿտ� 0�� �ƴ϶� 1�� �νĵ� 
FROM DUAL--LL (3��°���� ���� 2��ŭ)
;

SELECT INSTR ('HELLO WORLD!!', 'L', -4) 
FROM DUAL
;

SELECT REPLACE ('HELLO WORLD!!', 'L', 'K') FROM DUAL;

SELECT LENGTH('HELLO WORLD!!') 
FROM DUAL
;

SELECT SYSDATE 
FROM DUAL 
;

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DAY AM HH24:MI:SS')
FROM DUAL
;

SELECT TO_DATE('2020-05-05')
FROM DUAL
;
SELECT TO_CHAR (SYSDATE, 'YYYY')||'�� '||TO_CHAR (SYSDATE, 'IW')||'���� '
||TO_CHAR (SYSDATE, 'MM')||'�� 
'||TO_CHAR (SYSDATE, 'W')||'���� '
||TO_CHAR (SYSDATE, 'Q')||'��б�'
FROM DUAL
;
SELECT TO_CHAR(1234567.891234, '999,999,999,999,999,999.99')
FROM DUAL
;
-- 1,234,567.89

SELECT TO_CHAR(1234567, '$999,999,999,999,999.99')
FROM DUAL
;-- $1,234,567.00 (�� ��ȭ��ȣ�� ���ڴ� �� �پ��־�� �Ѵ�)

SELECT REGEXP_REPLACE(ENAME, '[a-z[:space:]]', '') -- �̷��� ���ĵ� �Ǵµ� ����Ŭ �����̳� ���α׷� ���� �ȸ��� ���� �ִ�. 
FROM EMP
;

SELECT REGEXP_REPLACE(ENAME, '[A-Z[:space:]]', '') -- �̷��� ���ĵ� �Ǵµ� ����Ŭ �����̳� ���α׷� ���� �ȸ��� ���� �ִ�. 
FROM EMP
;

SELECT ENAME, JOB, SAL, 
    CASE WHEN SAL<=1500
    THEN SAL*1.2
    ELSE SAL*0.8
    END AS RSAL
    FROM EMP;

SELECT * FROM EMP;

SELECT ENAME, JOB, SAL,
    CASE WHEN JOB='CLERK'
        THEN SAL*1.2
         WHEN JOB='SALESMAN'
        THEN SAL*1.1
    ELSE SAL*0.9
    end
    FROM EMP;
    



