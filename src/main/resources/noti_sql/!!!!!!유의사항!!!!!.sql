1. 쿼리문은 모두 대문자로 작성한다!! : RDS에서 MARIADB 생성 시 컬럼과 테이블이름을 대소문자를 구별함
   * 파라메터 옵션에서 대소문자 구분을 없애는 값이 있으나 동작을 안함
   
2. APPLICATION.YML의 DATABASE ID, PWD를 운영으로 동작시킬때는 깃 리파지토리를 반드시 PRIVATE로 변경해야함!!

3. mapper.xml안에 sql끝에 ";"  절대 넣지 않는다!!