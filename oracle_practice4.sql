select * from salgrade;
select * from grade;
select * from dept;
select * from grade;
select * from emp;


--DALLAS에서 근무하는 사람들 중 샐러리가 가장 높은 사람의 매니저(MGR)가 누구인지 구하시오
--출력: MGR,MGR_NAME,ENAME,SAL

select e.ename, e.mgr, em.ename, e.sal, d.deptno, d.dname,
                                        rank() over (order by sal desc) as 급여순위
        from emp e inner join dept d
                        on e.deptno = d.deptno
                        and d.loc =  'DALLAS'
                    inner join emp em
                        on e.mgr = em.empno
                ;