select * from salgrade;
select * from grade;
select * from dept;
select * from grade;
select * from emp;


--DALLAS���� �ٹ��ϴ� ����� �� �������� ���� ���� ����� �Ŵ���(MGR)�� �������� ���Ͻÿ�
--���: MGR,MGR_NAME,ENAME,SAL

select dd.ename, dd.mgr, dd.mgr_name, dd.sal from
    (select e.ename, e.mgr, em.ename as mgr_name, e.sal, d.deptno, d.dname,
                                            rank() over (order by e.sal desc) as �޿�����
            from emp e inner join dept d
                            on e.deptno = d.deptno
                            and d.loc =  'DALLAS'
                        inner join emp em
                            on e.mgr = em.empno
                            ) dd where �޿�����=1
                ;   

--�޿������ Ȧ���� �������� �޿��� 1500������ �������� �޿��� 20%�λ��� ���� ��ü �޿� ����� ���Ͻÿ�.
--��� �޿� 

select sal, grade from emp e
    inner join grade g on sal<=1500
                    and e.sal between g.losal and g.hisal
                    where mod(grade,2)=1;
                    
select * from emp where sal<=1500; --�ϴ� �̷��� ���� �̾ƺ�

select ename, grade, sal, case
                            when sal<=1500 
                                then sal*1.2
                            else sal
                            end as newsal
                    from emp e left outer join grade g
                    on mod(grade,2)=1
                        and e.sal between g.losal and g.hisal; --left outer�� ����ϴ°� �ؼ� ��ôµ� �ƴ�
                        
select ename, grade, sal, case
                            when sal<=1500
                                and mod(g.grade,2)=1
                                and e.sal between g.losal and g.hisal
                                    then sal*1.2
                            else sal
                            end as newsal
from emp e inner join grade g
     on e.sal between g.losal and g.hisal; --�̷����ϴϱ� �޿������ Ȧ���� ������ ��Ʈ�� �ȵ�
     
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
; --�̰� ���� �� ��

select avg( case
                when sal<=1500
                    and mod(g.grade,2)=1                    
                        then sal*1.2
                        else sal
                        end) as avg_newsal
    from emp e inner join grade g
         on e.sal between g.losal and g.hisal
;--�̰� �Ʒ��� ���� ��ģ ��

SELECT AVG(CASE WHEN MOD(SG.GRADE, 2)=1 AND E.SAL<=1500 --���⼭ ���� ��������� Ȧ���� ������ �ƴ� ��쵵 ���� �ٰ��� ����� ���� �� �ִ�. 
                                    THEN E.SAL*1.2
                                    ELSE E.SAL
                        END)AS AVG_SAL
FROM EMP E INNER JOIN SALGRADE SG
                                        ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
;--�̰� ����� ��



--����� �޿������ ¦���� ����� �� �޿��� 3��°�� ���� ����� ã���ÿ�
--��°� : �Ŵ����̸�, �޿�

select e.empno, e.ename, e.sal, g.grade, e.mgr, em.ename as mgr_name, em.sal as mgr_sal from emp e
        inner join grade g
            on e.sal between g.losal and g.hisal
        inner join emp em
            on em.empno = e.mgr
;--�ϴ� �̰����� ������ �ִ°� �̾ƺ�(���, �̸�, �޿�, �޿����, �Ŵ���, �Ŵ����̸�, �Ŵ��� �޿�)

select DISTINCT aa.*, gr.grade as mgr_grade from(
    select e.empno, e.ename, e.sal, g.grade, e.mgr, e2.ename as mgr_name, e2.sal as mgr_sal from emp e
            inner join grade g
                on e.sal between g.losal and g.hisal
            inner join emp e2
                on e2.empno = e.mgr
) aa inner join grade gr
        on aa.mgr_sal between gr.losal and gr.hisal
;--�Ŵ��� �޿������ ��Ÿ�������� �ϴϱ� �ߺ��� row�� ����

select DISTINCT aa.*, gr.grade as mgr_grade from(
    select e.empno, e.ename, e.sal, g.grade, e.mgr, e2.ename as mgr_name, e2.sal as mgr_sal from emp e
            inner join grade g
                on e.sal between g.losal and g.hisal
            inner join emp e2
                on e2.empno = e.mgr
) aa inner join grade gr
        on aa.mgr_sal between gr.losal and gr.hisal
;--distinct ���� �ȴ� �׷��� ��ôµ� �Ȱ���

select e.ename as mgr_name, e.sal as mgr_sal, g.grade as mgr_grade from emp e
        inner join grade g
            on e.sal between g.losal and g.hisal
        inner join emp em
            on e.empno = em.mgr
;--�׷��� �÷����� ����(���� �����ϱ� ������)`


            
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








                