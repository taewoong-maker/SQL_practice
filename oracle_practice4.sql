select * from salgrade;
select * from grade;
select * from dept;
select * from grade;
select * from emp;


--DALLAS���� �ٹ��ϴ� ����� �� �������� ���� ���� ����� �Ŵ���(MGR)�� �������� ���Ͻÿ�
--���: MGR,MGR_NAME,ENAME,SAL

select e.ename, e.mgr, em.ename, e.sal, d.deptno, d.dname,
                                        rank() over (order by sal desc) as �޿�����
        from emp e inner join dept d
                        on e.deptno = d.deptno
                        and d.loc =  'DALLAS'
                    inner join emp em
                        on e.mgr = em.empno
                ;