select * from emp;

select * from dept;

select MGR,ENAME,SAL, loc from
emp inner join dept on
emp.deptno=20 and
emp.deptno = dept.deptno;

select * from(
    select ENAME,(select ename from emp where )MGR,SAL,LOC from
    emp inner join dept on
    emp.deptno=20 and
    emp.deptno = dept.deptno)
    where sal=(select max(sal) from emp where deptno = 20);


select max(sal) from emp where deptno = 20;

select ename, mgr from emp;

select ename, mgr from emp p, emp e where p.mgr = e.empno;

SELECT MGR, MGR_NAME,ENAME,SAL
FROM(SELECT E.MGR,E.ENAME,E.SAL,RANK() OVER(ORDER BY E.SAL DESC) AS RNK,E2.ENAME AS MGR_NAME
FROM EMP E INNER JOIN  DEPT D
                                        ON E.DEPTNO=D.DEPTNO
                                        AND LOC='DALLAS'
                                        INNER JOIN EMP E2
                                         ON E.MGR = E2.EMPNO)
WHERE RNK=1
;

SELECT E.MGR,E.ENAME,E.SAL,RANK() OVER(ORDER BY E.SAL DESC) AS RNK, E2.ENAME AS MGR_NAME
FROM EMP E INNER JOIN  DEPT D
                                        ON E.DEPTNO=D.DEPTNO
                                        AND LOC='DALLAS'
                                        INNER JOIN EMP E2
                                         ON E.MGR = E2.EMPNO;
                                         
select e.ename, e.mgr, e2.ename as MGR_NAME
from emp e inner join emp e2
on e.mgr = e2.empno;

select sal*10 as sal from emp;

select * from emp;

select rownum rn, ename, sal from emp;

select * from
    (select rownum rn, sal,
        case mod(rownum,2)
            when 1 then sal*1.2
            else sal
            end as newsal from emp
            order by sal)
where mod(rn,2) = 1;

select rownum, sal,
        case mod(rownum,2)
            when 1 then sal*1.2
            else sal
end as newsal from emp;

select * from SALGRADE;

select * from emp;

select sal from emp e
    inner join salgrade s on
    case e.sal
        when e.sal in (mod(s.grade,2)=1) then e.sal*1.2
        else e.sal
        end as newsal;
        
SELECT AVG(CASE WHEN MOD(SG.GRADE, 2)=1 AND E.SAL<=1500
                        THEN E.SAL*1.2
                        ELSE E.SAL
            END)AS AVG_SAL
FROM EMP E INNER JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
;

select ename, sal from emp e
inner join salgrade s on
e.sal<=1500 and e.sal between
e.sal in (mod(s.grade,2)=1);

select * from emp;

select * from grade;

select count(ename) cnt
from emp e inner join grade g
on g.grade=2 and e.sal between g.losal and g.hisal;

--급여 등급이 2등급인 사원의 사원수를 구하시오 
select count(ename) cnt
from emp e inner join grade g
on e.sal between g.losal and g.hisal
where g.grade=2
;

select * from emp;

select * from dept;


--DALLAS에 근무하는 사원들의 급여 순위 
select e.ename, e.sal, d.deptno, d.loc,
        row_number() over(order by e.sal desc) as 순서
            from emp e inner join dept d
            on e.deptno = d.deptno
            where d.deptno = 20;            
            
select e.ename, e.sal, d.deptno, d.loc,
        rank() over(order by e.sal desc) as 순서
            from emp e inner join dept d
            on e.deptno = d.deptno
            where d.deptno = 20;
            
select deptno, dname, count(

;

--짝수 급여등급이 가장 많은 부서를 구하시오 
--출력: 부서번호, 부서명, 짝수 급여등급 사원 수 

select e.deptno, e.sal,g.grade from emp e
inner join grade g
on e.sal between g.losal and g.hisal
where mod(g.grade,2)=0;

select * from(
    select count(e.deptno) cnt, g.grade, rank()over(order by count(e.deptno)) as rank from emp e
    inner join grade g
        on e.sal between g.losal and g.hisal
        group by g.grade
        having mod(g.grade,2)=0
)where cnt = 1
;

select * from(
select d.deptno, d.dname, count(e.deptno) cnt, rank()over(order by count(e.deptno) desc) as rank
            from dept d inner join emp e
                                on d.deptno = e.deptno
                        inner join grade g
                                on e.sal between g.losal and g.hisal
                                and mod(g.grade,2)=0
        group by d.deptno, d.dname 
        ) where rank = 1
;

select  count(e.deptno), g.grade, d.dname from emp e
inner join dept d
    on e.deptno = d.deptno
inner join grade g
    on e.sal between g.losal and g.hisal
    group by g.grade
    having mod(g.grade,2)=0
;
