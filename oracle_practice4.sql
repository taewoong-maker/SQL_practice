select * from salgrade;
select * from grade;
select * from dept;
select * from grade;
select * from emp;


--DALLAS에서 근무하는 사람들 중 샐러리가 가장 높은 사람의 매니저(MGR)가 누구인지 구하시오
--출력: MGR,MGR_NAME,ENAME,SAL

select dd.ename, dd.mgr, dd.mgr_name, dd.sal from
    (select e.ename, e.mgr, em.ename as mgr_name, e.sal, d.deptno, d.dname,
                                            rank() over (order by e.sal desc) as 급여순위
            from emp e inner join dept d
                            on e.deptno = d.deptno
                            and d.loc =  'DALLAS'
                        inner join emp em
                            on e.mgr = em.empno
                            ) dd where 급여순위=1
                ;   

--급여등급이 홀수인 직원들중 급여가 1500이하인 직원들의 급여를 20%인상한 다음 전체 급여 평균을 구하시오.
--평균 급여 

select sal, grade from emp e
    inner join grade g on sal<=1500
                    and e.sal between g.losal and g.hisal
                    where mod(grade,2)=1;
                    
select * from emp where sal<=1500; --일단 이렇게 먼저 뽑아봄

select ename, grade, sal, case
                            when sal<=1500 
                                then sal*1.2
                            else sal
                            end as newsal
                    from emp e left outer join grade g
                    on mod(grade,2)=1
                        and e.sal between g.losal and g.hisal; --left outer로 써야하는가 해서 써봤는데 아님
                        
select ename, grade, sal, case
                            when sal<=1500
                                and mod(g.grade,2)=1
                                and e.sal between g.losal and g.hisal
                                    then sal*1.2
                            else sal
                            end as newsal
from emp e inner join grade g
     on e.sal between g.losal and g.hisal; --이렇게하니까 급여등급이 홀수인 직원들 소트가 안됨
     
select round(avg(newsal),2) from(
    select ename, grade, sal, case
                                when sal<=1500
                                    and mod(g.grade,2)=1
                                    and e.sal between g.losal and g.hisal
                                        then sal*1.2
                                else sal
                                end as newsal
    from emp e inner join grade g
         on e.sal between g.losal and g.hisal
)
; --이게 원래 내 답

select avg( case
                when sal<=1500
                    and mod(g.grade,2)=1                    
                        then sal*1.2
                        else sal
                        end) as avg_newsal
    from emp e inner join grade g
         on e.sal between g.losal and g.hisal
;--이건 아래꺼 보고 고친 답

SELECT AVG(CASE WHEN MOD(SG.GRADE, 2)=1 AND E.SAL<=1500 --여기서 조건 설정해줘야 홀수인 지원이 아닌 경우도 남고 다같이 평균을 구할 수 있다. 
                                    THEN E.SAL*1.2
                                    ELSE E.SAL
                        END)AS AVG_SAL
FROM EMP E INNER JOIN SALGRADE SG
                                        ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
;--이건 강사님 답



--상관의 급여등급이 짝수인 사원들 중 급여가 3번째로 많은 사원을 찾으시오
--출력값 : 매니저이름, 급여

select e.empno, e.ename, e.sal, g.grade, e.mgr, em.ename as mgr_name, em.sal as mgr_sal from emp e
        inner join grade g
            on e.sal between g.losal and g.hisal
        inner join emp em
            on em.empno = e.mgr
;--일단 이거저거 뽑을수 있는거 뽑아봄(사번, 이름, 급여, 급여등급, 매니저, 매니저이름, 매니저 급여)

select DISTINCT aa.*, gr.grade as mgr_grade from(
    select e.empno, e.ename, e.sal, g.grade, e.mgr, e2.ename as mgr_name, e2.sal as mgr_sal from emp e
            inner join grade g
                on e.sal between g.losal and g.hisal
            inner join emp e2
                on e2.empno = e.mgr
) aa inner join grade gr
        on aa.mgr_sal between gr.losal and gr.hisal
;--매니저 급여등급을 나타내보려고 하니까 중복된 row가 나옴

select DISTINCT aa.*, gr.grade as mgr_grade from(
    select e.empno, e.ename, e.sal, g.grade, e.mgr, e2.ename as mgr_name, e2.sal as mgr_sal from emp e
            inner join grade g
                on e.sal between g.losal and g.hisal
            inner join emp e2
                on e2.empno = e.mgr
) aa inner join grade gr
        on aa.mgr_sal between gr.losal and gr.hisal
;--distinct 쓰면 된다 그래서 써봤는데 똑같음

select e.ename as mgr_name, e.sal as mgr_sal, g.grade as mgr_grade from emp e
        inner join grade g
            on e.sal between g.losal and g.hisal
        inner join emp em
            on e.empno = em.mgr
;--그래서 컬럼수를 줄임(답을 참고하기 시작함)`


            
SELECT ENAME, SAL
FROM(SELECT E.ENAME AS MGR_NAME,SG.GRADE,E2.ENAME,E2.SAL, RANK() OVER(ORDER BY E2.SAL DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE SG
                                        ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL 
                                        AND MOD(SG.GRADE,2)=0
                        INNER JOIN EMP E2
                                        ON E.EMPNO=E2.MGR)
WHERE RNK=3
;

SELECT E.ENAME AS MGR_NAME, SG.GRADE, E2.ENAME, E2.SAL, RANK() OVER(ORDER BY E2.SAL DESC) AS RNK
            FROM EMP E INNER JOIN SALGRADE SG
                                        ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL 
                                        AND MOD(SG.GRADE,2)=0
                        INNER JOIN EMP E2
                                        ON E.EMPNO=E2.MGR
;

            
select * from emp order by sal;








                