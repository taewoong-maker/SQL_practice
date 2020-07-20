select  * FROM EMP;

select empno, ename, hiredate, SAL, TO_CHAR(HIREDATE,'Q') AS QUARTER, 
    CASE WHEN TO_CHAR(HIREDATE,'Q')=1
    THEN SAL*1.15
    WHEN TO_CHAR(HIREDATE,'Q')=2
    THEN SAL*0.7
    ELSE SAL*1.05
    END AS RSAL,
    DECODE(TO_CHAR(HIREDATE,'Q'),1,SAL*1.15,2,SAL*0.7,SAL*1.05) AS RSAL2
    FROM EMP;
    

SELECT ENAME, SAL,
                CASE WHEN SAL <= 1500
                            THEN SAL*1.2
                            ELSE SAL*0.8
                END AS RSAL
FROM EMP
;

SELECT ENAME, JOB, SAL,
    DECODE(JOB,'CLERK',SAL*1.2,'SALESMAN',SAL*1.1,SAL*0.9) AS RSAL
    FROM EMP
    ORDER BY SAL;
    
SELECT ENAME, JOB, SAL,
    CASE WHEN JOB='CLERK'
    THEN SAL*1.2
    WHEN JOB='SALESMAN'
    THEN SAL*1.1
    ELSE SAL*0.9
    END AS RSAL
    FROM EMP
    ORDER BY SAL;
    
SELECT ENAME, REGEXP_REPLACE(ENAME, '[A-z[:space:]]','') AS NULLLY
FROM EMP;

SELECT round(AVG(SAL),2), MIN(SAL)
FROM EMP
;

SELECT SUM(SAL) AS 합, TO_CHAR(HIREDATE,'MM') AS MONTH
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'MM')
ORDER BY MONTH;

SELECT SUM(SAL) 합 , TO_CHAR(HIREDATE,'MM') MONTH
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'MM')
HAVING SUM(SAL)<=3000
ORDER BY MONTH;

SELECT MAX(SUM(SAL)) AS MSS
FROM emp
GROUP BY TO_CHAR(HIREDATE,'YYYY')
;

SELECT round(AVG(SAL),2) AS 평균, mod(to_char(hiredate,'mm'),2)
FROM EMP
GROUP BY mod(to_char(hiredate,'mm'),2);

SELECT ROUND(MAX(AVG(SAL))-MIN(AVG(SAL)),2) AS 급여차
FROM EMP
GROUP BY mod(to_char(hiredate,'mm'),2);

SELECT  AVG(DECODE(MOD(TO_CHAR(HIREDATE,'MM'),2),1,SAL,NULL))
                    -AVG(DECODE(MOD(TO_CHAR(HIREDATE,'MM'),2),0,SAL,NULL)) AS CHA
FROM EMP
;

SELECT ENAME, JOB, SAL, 
         ROW_NUMBER () OVER (ORDER BY SAL DESC) 
             AS RNUM,
          RANK () OVER (ORDER BY SAL DESC) AS RNK, 
          DENSE_RANK () OVER (ORDER BY SAL DESC) 
             AS DRNK 
FROM EMP
;

SELECT ROWNUM RN, ENAME, JOB, SAL
    FROM(SELECT ENAME, JOB, SAL  FROM EMP E  ORDER BY SAL DESC)
    E
;

SELECT ENAME, JOB, SAL, 
         ROW_NUMBER () OVER (ORDER BY SAL DESC) 
             AS RNUM FROM EMP;
             
SELECT * FROM EMP;

SELECT ENAME, SAL,
                (SELECT AVG(SAL)
                FROM EMP) AS ASAL, 
                (SELECT MAX(SAL)
                FROM EMP) AS AMAX
FROM EMP
;

SELECT ENAME, SAL, ROUND(SAL-ASAL,2) CHA, ROUND(AMAX-ASAL,2) CHA2
    FROM (SELECT ENAME, SAL,
                (SELECT AVG(SAL)
                FROM EMP) AS ASAL, 
                (SELECT MAX(SAL)
                FROM EMP) AS AMAX
          FROM EMP)
;

SELECT  A.*
FROM (SELECT * FROM EMP
ORDER BY SAL DESC)
A
WHERE ROWNUM = 1
;

SELECT ENAME, JOB, SAL
FROM (SELECT ENAME, JOB, SAL,
                ROW_NUMBER() OVER(ORDER BY SAL DESC) AS RNK   --별칭이 갖춰있어야 가공할 때 쓸 수 있다
            FROM EMP) -- 
WHERE RNK =1
;

SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL=(SELECT MAX(SAL) FROM EMP)
;

SELECT ENAME, JOB, SAL
FROM EMP
WHERE JOB='CLERK'
;

SELECT ENAME, JOB, SAL
FROM EMP
WHERE ENAME IN (
    SELECT ENAME
    FROM EMP WHERE JOB='CLERK')
;

SELECT ENAME, JOB, SAL
FROM (SELECT ENAME, JOB, SAL
    FROM EMP WHERE JOB='CLERK')
;

SELECT ENAME, JOB, SAL, USAL, RNK
FROM (
    SELECT ENAME, JOB, SAL,
        CASE WHEN SAL<=1500
        THEN SAL*1.2
        ELSE SAL
        END AS USAL,
    RANK()OVER(
        PARTITION BY JOB
        ORDER BY CASE WHEN SAL<=1500
                THEN SAL*1.2
                ELSE SAL
                END DESC) AS RNK
        FROM EMP
        )
        WHERE RNK=1        
;     

SELECT ENAME, JOB, SAL, USAL, RNK
            FROM(SELECT ENAME, JOB, SAL, USAL,RANK()OVER(
                                        PARTITION BY JOB
                                        ORDER BY CASE WHEN SAL<=1500
                                        THEN SAL*1.2
                                        ELSE SAL
                                        END) RNK
                FROM(SELECT ENAME, JOB, SAL,
                    CASE WHEN SAL<=1500
                    THEN SAL*1.2
                    ELSE SAL
                    END AS USAL
                    FROM EMP
                    )
                )
                WHERE RNK=1
;

select DEPTNO FROM DEPT;

select DEPTNO FROM EMP;

SELECT DEPTNO, COUNT(*) AS 인원수
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

SELECT DEPTNO, 인원수
FROM (
   SELECT DEPTNO, COUNT(*) 인원수, RANK() OVER(
                                        ORDER BY COUNT(*) DESC) AS RNK 
                                        FROM EMP
                                        GROUP BY DEPTNO
) WHERE RNK=1
;

SELECT DEPTNO, COUNT(*) 인원수, RANK() OVER(
                                        ORDER BY COUNT(*) DESC) AS RNK 
                                        FROM EMP
                                        GROUP BY DEPTNO;
                                        
SELECT DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                                        FROM EMP
                                        GROUP BY DEPTNO)
;

SELECT DEPTNO, COUNT(*) AS 직원수
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)=(SELECT MAX(COUNT(*))
                        FROM EMP
                        GROUP BY DEPTNO);
select avg(sal) as 평균 from(                     
SELECT ENAME, SAL, DEPTNO, RANK()OVER(
                    PARTITION BY DEPTNO
                    ORDER BY SAL) AS RNK
                    FROM EMP
                )
where rnk=2;

select * from(                     
SELECT ENAME, SAL, DEPTNO, RANK()OVER(
                    PARTITION BY DEPTNO
                    ORDER BY SAL) AS RNK
                    FROM EMP
                )
where rnk=2;
                    
SELECT * FROM EMP;

SELECT * FROM(
SELECT TO_CHAR(HIREDATE,'MM') AS 월, COUNT(*) 입사자수, SUM(SAL) 급여총합, RANK()OVER(
                                                        ORDER BY COUNT(*) DESC
                                                        ) AS RNK
                        FROM EMP
                        GROUP BY TO_CHAR(HIREDATE,'MM')
                        ORDER BY RNK
)
WHERE RNK=1
;

SELECT * FROM EMP;

SELECT * FROM DEPT;

SELECT ENAME, SAL, LOC
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT ENAME, SAL, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E LEFT OUTER JOIN DEPT D
                ON E.DEPTNO=D.DEPTNO
--                AND E.DEPTNO!=30
                ;








